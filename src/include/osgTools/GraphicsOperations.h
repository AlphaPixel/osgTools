#pragma once

#include <osg/GraphicsContext>

//
// Graphics Operations
//

// UseVertexAttributeAliasing
//
// Enable with:
//      viewer.setRealizeOperation(new UseVertexAttributeAliasing());
//
class UseVertexAttributeAliasing : public osg::GraphicsOperation {
public:
    UseVertexAttributeAliasing()
        : osg::Referenced(true),
          osg::GraphicsOperation("GraphicsOperation", false) {}

    virtual void operator()(osg::GraphicsContext* gc) {
        gc->getState()->setUseVertexAttributeAliasing(true);
    }
};
