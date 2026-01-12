from typing import List
import glob
from pathlib import Path
from string import Template

def gen(moduleName: str, singletons: List[str] = []) -> None:
    cmakeTemplate: str = """
    qt_add_library(${moduleName} STATIC)
    qt6_add_qml_module(${moduleName}
        URI "${moduleName}"
        VERSION 1.0
        RESOURCE_PREFIX "/qt/qml"
        QML_FILES
            ${qmlFiles}
        RESOURCES
            ${iconsFolderFiles}
        )
    """

    qmlFiles: List[str] = []
    qmlFiles.extend(sorted(str(p) for p in glob.glob("*.qml")))
    icons: List[str] = []
    icons.extend(sorted(str(p) for p in glob.glob("icons/*.*")))

    qmlFileLines: List[str] = []
    qmlFileLines.append("Module " + moduleName)
    for f in qmlFiles:
        t: Template = Template("""${base} 1.0 ${name}""")
        if f in singletons:
            t = Template("""singleton  ${base} 1.0 ${name}""")
        qmlFileLines.append(t.substitute(base = Path(f).stem, name = f))

    with open("qmldir", "w") as file:
        file.write("\n".join(qmlFileLines))

    t: Template = Template(cmakeTemplate)

    with open("CMakeLists.txt", "w") as file:
        s: str = t.substitute(moduleName = moduleName,
                              qmlFiles = "\n".join(qmlFiles),
                              iconsFolderFiles = "\n".join(icons))

        for st in singletons:
            sTemplate: Template = Template("""
        set_source_files_properties(${st}
            PROPERTIES
                QT_QML_SINGLETON_TYPE true
        )
            """)
            file.write(sTemplate.substitute(st=st))
        file.write(s)

