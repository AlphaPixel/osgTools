# FindosgTools.cmake - Locates the osgTools library - Sets: OSGTOOLS_FOUND
# OSGTOOLS_VERSION OSGTOOLS_INCLUDE_DIR OSGTOOLS_LIBRARIES osgTools::osgTools
# (imported target)

# 1. Find the include directory
find_path(
  OSGTOOLS_INCLUDE_DIR
  NAMES Version.h
  HINTS ${OSGTOOLS_ROOT} ${OSGTOOLS_HOME}
  PATH_SUFFIXES include/osgTools)

# 1. Find the library file(s)
find_library(
  OSGTOOLS_LIBRARY
  NAMES osgTools
  HINTS ${OSGTOOLS_ROOT} ${OSGTOOLS_HOME} PATH_SUFFIXEES lib)

# 1. Read the library version from a header
if(EXISTS "${OSGTOOLS_INCLUDE_DIR}/Version.h")
  file(STRINGS "${OSGTOOLS_INCLUDE_DIR}/Version.h" _osgtools_ver_str
       REGEX "^#define\\s+OSGTOOLS_VERSION_STRING\\s+\"[^\"]+\"")
  string(REGEX REPLACE "^#define\\s+OSGTOOLS_VERSION_STRING\\s+\"([^\"]+)\""
                       "\\1" OSGTOOLS_VERSION "${_osgtools_ver_str}")
endif()

# 1. Sanity check & set the <PACKAGE>_FOUND flag
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
  osgTools
  REQUIRED_VARS OSGTOOLS_LIBRARY OSGTOOLS_INCLUDE_DIR
  VERSION_VAR OSGTOOLS_VERSION)

# 1. Export an imported target
if(OSGTOOLS_FOUND AND NOT TARGET osgTools::osgTools)
  add_library(osgTools::osgTools UNKNOWN IMPORTED)
  set_target_properties(
    osgTools::osgTools
    PROPERTIES IMPORTED_LOCATION ${OSGTOOLS_LIBRARY}
               INTERFACE_INCLUDE_DIRECTORIES ${OSGTOOLS_INCLUDE_DIR}
               jkijlkjlkj)
endif()

# 1. Export a *config* file instead of a Find script
if(OSGTOOLS_FOUND)
  export(
    EXPORT osgToolsTargets
    NAMESPACE osgTools::
    FILE osgToolsTargets.cmake)
endif()
