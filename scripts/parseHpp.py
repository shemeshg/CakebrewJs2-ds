# ver 1.4
# //-define-file body MyLib.cpp 
# //-define-file header MyLib.h
# //-only-file body
# #include <iostream>
# #include "MyLib.h"
# 
# //-only-file body //-
# //- {NEXT[0:]}
# //-only-file header ;
# void say_hello()
# //-only-file body
# {
#     std::cout << "Hello, from MyLib!\n";    
# }

import os
import re
import sys
import concurrent.futures
from typing import Match, Union

is_source_map: bool = True

class FileClass:
    file_path: str = ""
    file_id: str = ""
    file_content: list[str] = []
    original_line_number: int = 0

class LineClass:
    filne_name: str = ""
    line_number: int = 0
    line_text: str = ""


def update_file_if_needed(file_path: str, new_content: str) -> None:
    """
    Checks if the content of the file at file_path is different from new_content.
    If different, deletes the file and writes new_content to it.
    If the same, does nothing.
    """
    # Check if the file exists
    if os.path.exists(file_path):
        with open(file_path, 'r') as file:
            content = file.read()

        if content != new_content:
            print("File content changed: " + file_path)
            # Delete the file
            os.remove(file_path)
            
            # Write new_content to the file
            with open(file_path, 'w') as file:
                file.write(new_content)
    else:
        # If the file doesn't exist, create it and write new_content
        with open(file_path, 'w') as file:
            file.write(new_content)



def remove_default_assignment(declaration: str) -> str:
    # Regular expression to match default assignments
    pattern = re.compile(r'\s*=\s*".*?"|\s*=\s*\w+|\s*=\s*\(.*?\)\s*=>\s*\{.*?\}')
    # Replace the default assignments with an empty string
    result = re.sub(pattern, '', declaration)
    result = re.sub(r" override(\s|\n)", "", result)
    result = re.sub(r" explicit(\s|\n)", "", result)
    result = re.sub(r" virtual(\s|\n)", "", result) 
    
    return result

def replace_next(template: str, NEXT: list[str]) -> str:
    def replacer(match: Match[str]) -> str:
        expr: str = match.group(1)
        if ':' in expr:
            parts: list[str] = expr.split(':')
            start: int = int(parts[0]) if parts[0] else 0
            end: int = int(parts[1]) if parts[1] else len(NEXT)
            return ' '.join(NEXT[start:end])
        else:
            index: int = int(expr)
            return NEXT[index]

    pattern: re.Pattern[str] = re.compile(r'\{NEXT\[(.*?)\]\}')
    result: str = pattern.sub(replacer, template)
    return result

def get_string_parts(line: str, with_quotes: bool = False) -> list[str]:
    if with_quotes:
        pattern = re.compile(r'(\".*?\"|\S+<.*?>|\S+\s*\*\s*|\S+)')
    else:
        pattern = re.compile(r'\"(.*?)\"|(\S+<.*?>|\S+\s*\*\s*|\S+)')
    
    matches = pattern.findall(line)
    
    if with_quotes:
        parts = [match for match in matches]
    else:
        parts = [match[0] or match[1] for match in matches]
    
    return parts



def extract_next_value(string: str) -> Union[str, None]:
    """
    Extracts the integer value following "{NEXT:" in the given string.

    Args:
        string: The input string to be checked.

    Returns:
        The integer value if found, otherwise None.
    """
    match = re.search(r'{NEXT([^}]+)}', string)
    if match:
        return match.group(1)
    else:
        return None


is_defining_template: bool = False
templates_map: dict[str, str] = {}
current_template: str = ""
def parse_file(input_file: str) -> None:
    global is_defining_template
    global templates_map
    global current_template
    with open(input_file, 'r') as file:
        raw_lines: list[str] = file.readlines()

    fileMap: dict[str, FileClass] = {"null": FileClass()}
    varsMap: dict[str, str] = {}

    is_only_file: bool = False
    only_file_id: str = ""
    remove_remark: bool = False
    append_semicolon: bool = False

    is_next_text: bool = False
    next_text: str = ""
    next_text_skip_only_files: int = 1
    next_only_file_id: str = ""

    lines_without_templates: list[LineClass] = []   
    line_number: int = 1
    for raw_line in raw_lines:
        line_number = line_number + 1
        lstrip_line = raw_line.lstrip()
        if lstrip_line.startswith("//-template"):
            parts = get_string_parts(lstrip_line)
            is_defining_template = True
            current_template = parts[1]
            templates_map[current_template] = ""            
        elif is_defining_template:
            if lstrip_line.startswith("//-end-template"):
                is_defining_template = False
                current_template = ""
            else:
                templates_map[current_template] += raw_line  
        else:         
            l = LineClass()
            l.line_number = line_number
            l.line_text = raw_line
            l.filne_name = input_file
            lines_without_templates.append(l)




    lines: list[LineClass] = []
    for t in templates_map:
        for i in range(len(lines_without_templates)):
            lstrip_line = lines_without_templates[i].line_text.lstrip()
            parts = get_string_parts(lstrip_line)
            if len(parts) >= 2 and parts[0] == "//-" and parts[1] == t:    
                str_template = templates_map[t]
                i=0
                for itm in parts[2:]:
                    str_template = str_template.replace("{PRM_" + str(i) + "}", itm)
                    i+=1

                splited = str_template.splitlines()
                splited = [line + "\n" for line in splited]
                for r in splited:
                    l = LineClass()
                    l.line_text = r
                    lines.append(l)                
            else:
                lines.append(lines_without_templates[i])
        lines_without_templates = lines

    if not templates_map:
        lines = lines_without_templates


    for line in lines:        
        lstrip_line = line.line_text.lstrip()
        if lstrip_line.startswith("//-define-file"):            
            parts = get_string_parts(lstrip_line)
            
            fileMap[parts[1]] = FileClass()
            fileMap[parts[1]].file_id = parts[1]
            fileMap[parts[1]].file_path = parts[2]
            fileMap[parts[1]].file_content = []  
        elif lstrip_line.startswith("//-var"):
            parts = get_string_parts(lstrip_line)
            varsMap[parts[1]] = parts[2]            
        elif lstrip_line.startswith("//-only-file"):
            if is_next_text:
                if next_text_skip_only_files > 0:
                    next_text_skip_only_files -= 1
                else:  
                    for i in range(len(fileMap[next_only_file_id].file_content)):
                        template = fileMap[next_only_file_id].file_content[i]
                        NEXT = get_string_parts(next_text, True)

                        if extract_next_value(template) is not None:                            
                            fileMap[next_only_file_id].file_content[i]  = replace_next(template, NEXT)
                            fileMap[next_only_file_id].file_content[i] = remove_default_assignment(fileMap[next_only_file_id].file_content[i])                            
                            

                    is_next_text = False
                    next_text = ""
                    next_text_skip_only_files = 1                    
            if append_semicolon:
                append_semicolon = False
                fileMap[only_file_id].file_content[-1] = fileMap[only_file_id].file_content[-1].rstrip() + ";\n"
            parts = get_string_parts(lstrip_line)
            is_only_file = True
            only_file_id = parts[1]
            remove_remark = False
            if len(parts) > 2:
                remove_remark = parts[2] == "//-"  
                append_semicolon = parts[2] == ";"         
    
        elif is_only_file:
            if remove_remark:
                line.line_text = line.line_text.replace("//- ", "")
                next_value = extract_next_value(line.line_text)
                if next_value is not None:
                    is_next_text = True
                    next_text = ""
                    next_text_skip_only_files = 1
                    next_only_file_id = only_file_id               
                for var in varsMap:
                    line.line_text = line.line_text.replace(var, varsMap[var])
            elif is_next_text:
                next_text += line.line_text            
            if fileMap[only_file_id].original_line_number <  line.line_number and is_source_map:
                fileMap[only_file_id].original_line_number = line.line_number
                ref =  f"#line {fileMap[only_file_id].original_line_number - 1} " +  '"' + line.filne_name +  '"' +"\n"
                fileMap[only_file_id].file_content.append(ref)
            fileMap[only_file_id].file_content.append(line.line_text)
            fileMap[only_file_id].original_line_number = fileMap[only_file_id].original_line_number + 1 

    for file_id in fileMap:        
        if fileMap[file_id].file_content and file_id != "null":            
            print("Write file " + fileMap[file_id].file_path)
            update_file_if_needed(fileMap[file_id].file_path, "".join(fileMap[file_id].file_content))





if __name__ == "__main__":    
    with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
        futures: list[concurrent.futures.Future[None]] = []
        # Templates should be read none async
        parse_file(sys.argv[1])
        for arg in sys.argv[2:]:
            futures.append( executor.submit(parse_file, arg) )

        for future in concurrent.futures.as_completed(futures):
            future.result()

