from string import Template
from typing import List
import glob
from pathlib import Path
import re
import hashlib


class GenHpp:
    execJobId: str
    makeDirectories: List[str] = []
    hppGenFilesGlobes: List[str] = []
    hppGenFilesTemplates: List[str] = []
    parseHppPyPath: str = ""
    exeName: str
    def __init__(self, exeName: str):        
        hash_object = hashlib.sha256(exeName.encode())
        self.execJobId: str = "runScript_" +  hash_object.hexdigest()
        self.exeName: str = exeName

    def add_dependencies(self) -> str:
        t: Template = Template("""
if(GEN_HPP)
  add_dependencies(${exeName} ${execJobId})
endif()
        """)
        return t.substitute(exeName = self.exeName, 
                            execJobId = self.execJobId)

    def get_string_parts(self, line: str, with_quotes: bool = False) -> List[str]:
        if with_quotes:
            pattern: re.Pattern[str] = re.compile(r'(\".*?\"|\S+<.*?>|\S+\s*\*\s*|\S+)')
        else:
            pattern: re.Pattern[str] = re.compile(r'\"(.*?)\"|(\S+<.*?>|\S+\s*\*\s*|\S+)')

        matches: List[str] = pattern.findall(line)

        if with_quotes:
            parts: List[str] = [match for match in matches]
        else:
            parts: List[str] = [match[0] or match[1] for match in matches]

        return parts

    def getDefineFiles(self, preAppend: str = "") -> List[str]:
        defFiles: List[str] = []
        for globStr in self.hppGenFilesGlobes:
            globStr = globStr.replace('${CMAKE_CURRENT_SOURCE_DIR}/','')
            globStr = globStr.replace('"','')
            files: List[str] = [str(p) for p in glob.glob(globStr)]
            for file in files:
                with open(file, 'r') as f:                    
                    for line in f:
                        line = line.strip()
                        if line.startswith("//-define-file"):                            
                            defFiles.append(preAppend + self.get_string_parts(line)[2])
        return defFiles

    def getStr(self) -> str:
        makeDirsStr: str = ""
        if len(self.makeDirectories) > 0:
            makeDirsStrT: Template = Template("""make_directory(${items})""")
            makeDirsStr += "\n".join( [makeDirsStrT.substitute(items = m)  for m in self.makeDirectories] )


        hppGenFilesTemplatesStr: str = ""
        if len(self.hppGenFilesTemplates) > 0:
            hppGenFilesTemplatesStr = " ".join(self.hppGenFilesTemplates)

        
        hppGenFilesGlobesStr: List[str] = []
        for globStr in  self.hppGenFilesGlobes:      
            hppGenFilesGlobesStr.extend(sorted(["${CMAKE_CURRENT_SOURCE_DIR}/" + str(p) for p in Path(globStr).parent.glob(Path(globStr).name )]))

        t: Template = Template("""
SET(GEN_HPP TRUE)
if(GEN_HPP)
    ${makeDirsStr}


    set(HPP_GEN_FILES
        ${hppGenFilesTemplatesStr}
        ${hppGenFilesGlobesStr}
    )
    add_custom_target(${execJobId} ALL
        COMMAND python3 ${parseHppPyPath} ${HPP_GEN_FILES}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Running parseHpp shell script")

    # Run a shell script before everything else
    execute_process(
        COMMAND python3 ${parseHppPyPath} ${HPP_GEN_FILES}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        RESULT_VARIABLE result
    )

    # Check the result of the script execution
    if(NOT result EQUAL 0)
        message(FATAL_ERROR "Script execution failed with result: ${result}")
    endif()

    # Continue with the rest of your CMake configuration
endif()
                     """)
        return t.safe_substitute(makeDirsStr = makeDirsStr, 
                                 hppGenFilesTemplatesStr = hppGenFilesTemplatesStr,
                                 hppGenFilesGlobesStr = "\n".join(hppGenFilesGlobesStr),
                                 execJobId = self.execJobId,
                                 parseHppPyPath = self.parseHppPyPath)

class SubdirectoryItem:
    folder: str
    exeName: str
    def __init__(self, folder: str, exeName: str = ""):
        if exeName == "":
            exeName = folder 
        self.folder: str = folder
        self.exeName: str = exeName        

class CMakeCog:
    exeName: str
    subdirectoryItem: List[SubdirectoryItem] = []
    libType: str = "STATIC"
    libFiles: List[str] = []
    targetIncludeDirs: List[str] = [] 

    def __init__(self, exeName: str):
        self.exeName: str = exeName

    def libFilesExtendCppAndH(self, path: List[Path]):
        for p in path:
            self.libFilesExtend(p, ['*.h', '*.cpp']) 
        

    
    def libFilesExtend(self, path: Path, exts: List[str]):
        path = Path(path)
        if path.is_dir():
            for ext in exts:
                self.libFiles.extend(sorted(str(p) for p in path.glob(ext)))


    def add_library(self) -> str:
        t: Template = Template("""
add_library(${exeName} ${libType}
  ${libFiles}
)        
                     """)
        libFiles: str = "\n".join(self.libFiles)
        return t.safe_substitute(exeName = self.exeName,
                                 libType = self.libType,
                                 libFiles = libFiles)

    def cmake_minimum_required(self) -> str:
        return """cmake_minimum_required(VERSION 3.14)"""

    def project(self) -> str:
        t: Template = Template("""project(${exeName} LANGUAGES CXX)""")    
        return t.substitute(exeName = self.exeName)
    
    def CMAKE_CXX_STANDARD(self) -> str:
        return """
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
"""

    find_package_qt_components: List[str] = []

    def find_package_qt(self) -> str:
        t: Template = Template("""
find_package(QT NAMES Qt6 Qt5 COMPONENTS ${components} REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS ${components} REQUIRED)
""")
        return t.safe_substitute(components = " ".join(self.find_package_qt_components))

    def add_subdirectory(self) -> str:
        t: Template = Template("""add_subdirectory(${folder})""")
        return "\n".join([t.substitute(folder=item.folder) for item in self.subdirectoryItem])

    def target_link_libraries(self) -> str:
        libs: List[str] = []        
        t: Template = Template("""target_link_libraries(${exeName} PRIVATE ${libs}) """)        
        libs.extend(['Qt${QT_VERSION_MAJOR}::' + s for s in self.find_package_qt_components])
        libs.extend([itm.exeName for itm in self.subdirectoryItem])
        return t.substitute(exeName = self.exeName, 
                            libs = "\n".join(libs))
    
    def target_compile_definitions(self) -> str:
        t: Template = Template("""target_compile_definitions(${exeName} PRIVATE ${exeNameLib}) """)  
        exeNameLib: str = self.exeName.upper() + "_LIBRARY"
        return t.substitute(exeNameLib = exeNameLib, exeName = self.exeName)
    
    def target_include_directories(self) -> str:
        t: Template = Template("""
target_include_directories(${exeName} PUBLIC ${targetIncludeDirs})                     
        """)
        return t.substitute(exeName = self.exeName,
                            targetIncludeDirs = "\n".join(self.targetIncludeDirs))