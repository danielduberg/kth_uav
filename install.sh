#!/bin/bash

#Source: https://stackoverflow.com/questions/16850029/bash-get-current-directory-of-file-after-getting-called-by-another-bash-script
CURRENT_FILE_PATH=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

# Only adds the argument to $HOME/.bashrc if the line is not there yet
addToBashrc() {
  if ! grep -qF "$1" "$HOME/.bashrc"; then
    echo "$1" >> $HOME/.bashrc
  fi
}

sudo apt-get update
sudo apt-get install cmake python-pip python-rosinstall python-rosinstall-generator python-wstool build-essential python-catkin-tools

sudo apt-get update
sudo apt-get install libprotobuf-dev libprotoc-dev protobuf-compiler libeigen3-dev gazebo7 libgazebo7-dev gstreamer1.0-* libgstreamer1.0-* libimage-exiftool-perl python-jinja2 libgeographic-dev geographiclib-tools

sudo pip install numpy toml

cd $CURRENT_FILE_PATH

git submodule update --init --recursive

sudo $CURRENT_FILE_PATH/mavros/mavros/scripts/install_geographiclib_datasets.sh

addToBashrc "# Load the kth_uav bash file"
addToBashrc "source $CURRENT_FILE_PATH/.bashrc"

chmod +x $CURRENT_FILE_PATH/mavros/mavros/scripts/install_geographiclib_datasets.sh
sudo source $CURRENT_FILE_PATH/mavros/mavros/scripts/install_geographiclib_datasets.sh

cd $CURRENT_FILE_PATH/Firmware
make posix_sitl_default gazebo
