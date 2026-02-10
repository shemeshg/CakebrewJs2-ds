from jinja2 import Environment, FileSystemLoader
import os

max_score = 100
test_name = "Python Challenge"
template_dict = {
           "APP_VER": "2.95",
           "APP_NAME": "Cakebrewjs",
           "APP_DESCRIPTION": "Homebrew GUI App",
           "APP_VENDOR": "shemeshg",
           "APP_IDENTIFIER": "com.shemeshg.cakebrewjs",
           "APP_CONTACT":"https://github.com/shemeshg",           
           "MAIN_QML_URI": "MainQml",

           "CPACK_DEBIAN_PACKAGE_DEPENDS": [],

           "QML_DIRS": ["Design","Bal"],

           "QT_COMPONENTS": [ "Quick","Svg"],
           "add_subdirectory_lib": ["Bal"],
           "add_subdirectory_qt": ["Design/Design", "Design/DesignContent", "Design/Core"]
           }

template_dict["add_subdirectory_lib_target"] = [os.path.basename(path) for path in template_dict["add_subdirectory_lib"]]
template_dict["add_subdirectory_qt_target"] = [os.path.basename(path) + "plugin" for path in template_dict["add_subdirectory_qt"]]

environment = Environment(loader=FileSystemLoader("."))
template = environment.get_template("CMakeCogMain.j2")


content = template.render(
    template_dict,
    max_score=max_score,
    test_name=test_name
)

def getCmake():   
    return content
#print(getCmake())
