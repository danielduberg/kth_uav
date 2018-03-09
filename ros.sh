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
sudo apt-get install cmake

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu kinetic main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get update
sudo apt-get install ros-kinetic-desktop-full
sudo rosdep init
rosdep update
addToBashrc "source /opt/ros/kinetic/setup.bash"
addToBashrc "source \$HOME/catkin_ws/devel/setup.bash"

sudo apt-get update
sudo apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential python-catkin-tools

mkdir -p $HOME/catkin_ws/src

sudo apt-get update
sudo apt-get install libprotobuf-dev libprotoc-dev protobuf-compiler libeigen3-dev gazebo7 libgazebo7-dev gstreamer1.0-* libgstreamer1.0-* libimage-exiftool-perl python-jinja2

