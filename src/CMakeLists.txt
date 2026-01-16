add_library(
  osgTools STATIC osgTools/StatsHandler.cpp include/osgTools/StatsHandler.h
                  include/osgTools/Version.h)

add_library(osgTools::osgTools ALIAS osgTools)

target_include_directories(osgTools PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}")
target_link_libraries(osgTools PUBLIC ${OPENSCENEGRAPH_LIBRARIES})
target_sources(
  osgTools
  PUBLIC FILE_SET
         HEADERS
         BASE_DIRS
         include
         FILES
         include/osgTools/StatsHandler.h
         include/osgTools/Version.h)

install(
  TARGETS osgTools
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
          FILE_SET HEADERS
          DESTINATION include)
