 #!/usr/bin/env bash

 # Execute this file to install the quartercoin cli tools into your path on OS X

 CURRENT_LOC="$( cd "$(dirname "$0")" ; pwd -P )"
 LOCATION=${CURRENT_LOC%Quartercoin-Qt.app*}

 # Ensure that the directory to symlink to exists
 sudo mkdir -p /usr/local/bin

 # Create symlinks to the cli tools
 sudo ln -s ${LOCATION}/Quartercoin-Qt.app/Contents/MacOS/quartercoind /usr/local/bin/quartercoind
 sudo ln -s ${LOCATION}/Quartercoin-Qt.app/Contents/MacOS/quartercoin-cli /usr/local/bin/quartercoin-cli
