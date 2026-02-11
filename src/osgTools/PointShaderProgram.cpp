#include <osgTools/PointShaderProgram.h>

using namespace osgTools;

const char* vertexShaderSource = R"(
    #version 330 core

    in vec4 osg_Vertex;
    in vec4 osg_Color;

    uniform mat4 osg_ModelViewProjectionMatrix;
    uniform float pointSize;

    out vec4 vertexColor;

    void main(void) {
        gl_Position = osg_ModelViewProjectionMatrix * osg_Vertex;

        vertexColor = osg_Color;

        // Be sure and call `StateSet::setMode(GL_PROGRAM_POINT_SIZE, osg::StateAttribute::ON)`, or
        // this will be a no-op! IMPORTANT!
        gl_PointSize = pointSize;
    }
)";

const char* fragmentShaderSource = R"(
    #version 330 core
    in vec4 vertexColor;

    out vec4 color;

    void main(void) {
        // Convert to [-1, 1] so (0,0) is the center of the point.
        vec2 p = gl_PointCoord * 2.0 - 1.0;

        // This gives us a radial coordinate without a costly sqrt(), supposedly.
        float r2 = dot(p, p);

        // This explicitly recreates legacy FFP point behavior...
        float alpha = exp(-r2 * 2.5);
        color = vec4(vertexColor.rgb * alpha, vertexColor.a   * alpha);
    }
)";

osg::ref_ptr<osg::Program> osgTools::createPointShaderProgram(
    osg::Node* target) {
    osg::ref_ptr<osg::Program> prg = new osg::Program();

    prg->addShader(new osg::Shader(osg::Shader::VERTEX, vertexShaderSource));
    prg->addShader(
        new osg::Shader(osg::Shader::FRAGMENT, fragmentShaderSource));

    if (target) {
        auto stateSet = target->getOrCreateStateSet();
        stateSet->setAttributeAndModes(prg);
        stateSet->setMode(GL_PROGRAM_POINT_SIZE, osg::StateAttribute::ON);
    }

    return prg;
}
