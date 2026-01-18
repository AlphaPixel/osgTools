add_library(
  osgTools STATIC osgTools/StatsHandler.cpp include/osgTools/StatsHandler.h
                  include/osgTools/Version.h)

add_library(osgTools::osgTools ALIAS osgTools)

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
  EXPORT osgToolsPackageConfig
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
          FILE_SET HEADERS
          DESTINATION include)

export(
  TARGETS osgTools
  NAMESPACE osgTools::
  FILE "${CMAKE_CURRENT_BINARY_DIR}/osgToolsConfig.cmake")
install(
  EXPORT osgToolsPackageConfig
  DESTINATION lib/cmake/osgTools
  NAMESPACE osgTools::)
