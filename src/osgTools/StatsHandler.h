#pragma once

#include <osgViewer/Viewer>
#include <osgViewer/ViewerEventHandlers>

namespace osgTools {
    class StatsHandler : public osgViewer::StatsHandler {
    public:
        StatsHandler();
    };
}  // namespace osgTools
