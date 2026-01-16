add_library(osgTools STATIC osgTools/StatsHandler.cpp osgTools/StatsHandler.h)
add_library(osgTools::osgTools ALIAS osgTools)

target_include_directories(osgTools PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}")
target_link_libraries(osgTools PUBLIC ${OPENSCENEGRAPH_LIBRARIES})

install(TARGETS osgTools)
