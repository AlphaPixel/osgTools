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
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
          FILE_SET HEADERS
          DESTINATION include)

include(GNUInstallDirs)
set(INCLUDE_INSTALL_DIR
    ${CMAKE_INSTALL_INCLUDEDIR}/osgTools
    CACHE PATH "Location of header files")
# ...
include(CMakePackageConfigHelpers)
configure_package_config_file(
  osgToolsConfig.cmake.in ${CMAKE_CURRENT_BINARY_DIR}/osgToolsConfig.cmake
  INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/osgTools
  PATH_VARS INCLUDE_INSTALL_DIR)
write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/osgToolsConfigVersion.cmake
  VERSION 0.1.0
  COMPATIBILITY SameMajorVersion)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/osgToolsConfig.cmake
              ${CMAKE_CURRENT_BINARY_DIR}/osgToolsConfigVersion.cmake
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/osgTools)
