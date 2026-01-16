#include <osgTools/StatsHandler.h>

#include <string>

using namespace osgTools;

const std::string frameNumberName = "Custom Frame Number";
const std::string frameTimeName = "Custom Frame Time";
const std::string customTimeName = "Custom";

StatsHandler::StatsHandler() {
    // This line displays the frame number. It's not averaged, just displayed as
    // is.
    addUserStatsLine("Frame", osg::Vec4(0.7, 0.7, 0.7, 1),
                     osg::Vec4(0.7, 0.7, 0.7, 0.5), frameNumberName, 1.0, false,
                     false, "", "", 0.0);

    // This line displays the frame time (from beginning of event to end of
    // draw). No bars.
    addUserStatsLine("MS/frame", osg::Vec4(1, 0, 1, 1), osg::Vec4(1, 0, 1, 0.5),
                     frameTimeName, 1000.0, true, false, "", "", 0.02);

    // This line displays the sum of update and main camera cull times.
    addUserStatsLine("Custom", osg::Vec4(1, 1, 1, 1), osg::Vec4(1, 1, 1, 0.5),
                     customTimeName + " time taken", 1000.0, true, false,
                     customTimeName + " begin", customTimeName + " end", 0.016);
}
