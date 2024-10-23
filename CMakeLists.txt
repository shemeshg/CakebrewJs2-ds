cmake_minimum_required(VERSION 3.21.1)

option(LINK_INSIGHT "Link Qt Insight Tracker library" ON)
option(BUILD_QDS_COMPONENTS "Build design studio components" ON)
set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64")


project(Cakebrewjs VERSION 2.67 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)


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

configure_file("${PROJECT_SOURCE_DIR}/config.h.in" "${CMAKE_BINARY_DIR}/config.h")
include_directories("${CMAKE_BINARY_DIR}")

find_package(Qt6  REQUIRED COMPONENTS Core Gui Qml Quick Svg Concurrent)

qt_policy(SET QTP0001 NEW)

if (Qt6_VERSION VERSION_GREATER_EQUAL 6.3)
    qt_standard_project_setup()
endif()


qt_add_executable(Cakebrewjs src/main.cpp ${APP_ICON_MACOSX})

qt_add_resources(Cakebrewjs "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

add_subdirectory(bal)

target_link_libraries(Cakebrewjs PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::Svg
    Qt6::Concurrent
    bal
)

set(QT_QML_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml)
set(QML_IMPORT_PATH ${QT_QML_OUTPUT_DIRECTORY}
    CACHE STRING "Import paths for Qt Creator's code model"
    FORCE
)

if (BUILD_QDS_COMPONENTS)
    include(${CMAKE_CURRENT_SOURCE_DIR}/qmlcomponents)
endif()

include(${CMAKE_CURRENT_SOURCE_DIR}/qmlmodules)

if (LINK_INSIGHT)
    include(${CMAKE_CURRENT_SOURCE_DIR}/insight)
endif ()

include(GNUInstallDirs)
install(TARGETS Cakebrewjs
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# make IDEs aware of the QML import path
set(QML_IMPORT_PATH ${PROJECT_BINARY_DIR}/qml CACHE PATH
    "Path to the custom QML components defined by the project")

set_target_properties(Cakebrewjs PROPERTIES
    WIN32_EXECUTABLE ON
    MACOSX_BUNDLE ON
)

set_target_properties(Cakebrewjs PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER CakebrewJs.shemeshg.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    OUTPUT_NAME "CakebrewJs"
)

qt_generate_deploy_qml_app_script(
    TARGET Cakebrewjs
    OUTPUT_SCRIPT deploy_script
)
install(SCRIPT ${deploy_script})
