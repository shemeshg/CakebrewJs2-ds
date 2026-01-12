#!/bin/sh
LD_LIBRARY_PATH=/opt/Cakebrewjs/lib:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH
/opt/Cakebrewjs/bin/Cakebrewjs "$@"
