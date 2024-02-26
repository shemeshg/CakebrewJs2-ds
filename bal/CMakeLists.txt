find_package(Qt6 REQUIRED COMPONENTS Concurrent)
link_libraries(
     Qt6::Concurrent
)


qt6_add_qml_module(Brew
        URI Brew
        VERSION 1.0
        SOURCES
            BrewData.h
            BrewData.cpp
            JsAsync.h
            JsAsync.cpp
              )
