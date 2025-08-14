cmake_minimum_required(VERSION 3.16)

project(Cakebrewjs VERSION 2.81 LANGUAGES CXX)
set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64")
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Svg)

qt_standard_project_setup(REQUIRES 6.5)

## start custom
if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    set(MACOSX TRUE)
endif()
if(MACOSX)
    # Application icon
    set(MACOSX_BUNDLE_ICON_FILE icon.icns)
    set(APP_ICON_MACOSX ${CMAKE_CURRENT_SOURCE_DIR}/icon.icns)
    set_source_files_properties(${APP_ICON_MACOSX} PROPERTIES
           MACOSX_PACKAGE_LOCATION "Resources")
    set(CPACK_PACKAGE_NAME Cakebrewjs)
    set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Cakebrewjs")
    set(CPACK_PACKAGE_VENDOR "shemeshg")
    include(CPack)
endif()



## end custom


list(APPEND QML_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/Design/)
set(QML_IMPORT_PATH "${QML_DIRS}" CACHE STRING "Import paths for Qt Creator's code model" FORCE)



qt_add_executable(${CMAKE_PROJECT_NAME}
    main.cpp ${APP_ICON_MACOSX}
)


qt_add_qml_module(${CMAKE_PROJECT_NAME}
    URI shalom
    VERSION 1.0
    QML_FILES
        Main.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
##
# set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
#     MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appshalom
#     MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
#     MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
#     MACOSX_BUNDLE TRUE
#     WIN32_EXECUTABLE TRUE
# )
##

add_subdirectory(design/Design)
add_subdirectory(design/DesignContent)
add_subdirectory(design/Core)
add_subdirectory(Bal)

target_link_libraries(${CMAKE_PROJECT_NAME}
    PRIVATE Qt6::Quick Qt6::Svg
    Bal
    Coreplugin
    Designplugin
    DesignContentplugin
)

include(GNUInstallDirs)
#
# install(TARGETS ${CMAKE_PROJECT_NAME}
#     BUNDLE DESTINATION .
#     LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
#     RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
# )
#

# Custom ADded
set_target_properties(Cakebrewjs PROPERTIES
    WIN32_EXECUTABLE ON
    MACOSX_BUNDLE ON
)

set_target_properties(Cakebrewjs PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER CakebrewJs.shemeshg.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    OUTPUT_NAME "Cakebrewjs"
)


include(GNUInstallDirs)
install(TARGETS ${CMAKE_PROJECT_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

qt_finalize_executable(Cakebrewjs)

qt_generate_deploy_qml_app_script(
    TARGET Cakebrewjs
    OUTPUT_SCRIPT deploy_script

)
install(SCRIPT ${deploy_script})
# End custom Added
