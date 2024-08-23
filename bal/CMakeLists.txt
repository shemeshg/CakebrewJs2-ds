find_package(Qt6  REQUIRED COMPONENTS  Concurrent)

include(FetchContent)
FetchContent_Declare(json URL https://github.com/nlohmann/json/releases/download/v3.11.3/json.tar.xz)
FetchContent_MakeAvailable(json)

link_libraries(
    Qt6::Concurrent
     nlohmann_json::nlohmann_json
)


qt6_add_qml_module(bal
        URI Brew
        VERSION 1.0
        SOURCES
            JsAsync.h
            JsAsync.cpp
            BrewData.h
            BrewData.cpp
            BrewDataPrivate.h
            BrewDataPrivate.cpp        
            shellcmd.h shellcmd.cpp
            searchresultrow.h searchresultrow.cpp
            ServiceRow.h ServiceRow.cpp
            CaskRow.h CaskRow.cpp
            FormulaRow.h FormulaRow.cpp
            ParseCmd.h ParseCmd.cpp
              )





