cmake_minimum_required(VERSION 3.31)

project(osgTools LANGUAGES CXX)

find_package(
  OpenSceneGraph
  COMPONENTS osg
             osgDB
             osgGA
             osgSim
             osgText
             osgUtil
             osgViewer
  REQUIRED)

add_subdirectory(src)

install(FILES cmake/FindosgTools.cmake DESTINATION share/cmake/osgTools)
