#pragma once

#include <osg/Node>
#include <osg/Program>

namespace osgTools {
    osg::ref_ptr<osg::Program> createPointShaderProgram(osg::Node *targetNode);
};
