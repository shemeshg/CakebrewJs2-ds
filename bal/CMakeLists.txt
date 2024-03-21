find_package(Qt6 REQUIRED COMPONENTS Concurrent)
link_libraries(
     Qt6::Concurrent
)


qt6_add_qml_module(bal
        URI Brew
        VERSION 1.0
        SOURCES
            BrewData.h
            BrewData.cpp
            BrewDataPrivate.h
            BrewDataPrivate.cpp        
            JsAsync.h
            #JsAsync.cpp
            shellcmd.h shellcmd.cpp
            json/single_include/nlohmann/json.hpp
            searchresultrow.h searchresultrow.cpp
            ServiceRow.h ServiceRow.cpp
            CaskRow.h CaskRow.cpp
            FormulaRow.h FormulaRow.cpp
              )
