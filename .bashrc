#!/bin/bash

if [ -f /opt/ros/kinetic/setup.bash ]; then
    source /opt/ros/kinetic/setup.bash
fi
if [ -f /opt/ros/indigo/setup.bash ]; then
    source /opt/ros/indigo/setup.bash
fi
source $HOME/catkin_ws/devel/setup.bash
# Set the plugin path so Gazebo finds our model and sim export
export GAZEBO_PLUGIN_PATH=${GAZEBO_PLUGIN_PATH}:$HOME/catkin_ws/src/kth_uav/Firmware/build/posix_sitl_default/build_gazebo
# Set the model path so Gazebo finds the airframes
export GAZEBO_MODEL_PATH=${GAZEBO_MODEL_PATH}:$HOME/catkin_ws/src/kth_uav/Firmware/Tools/sitl_gazebo/models:$HOME/catkin_ws/src/kth_uav/simulation/models
# Set path to sitl_gazebo repository
export SITL_GAZEBO_PATH=$HOME/catkin_ws/src/kth_uav/Firmware/Tools/sitl_gazebo
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$HOME/catkin_ws/src/kth_uav/Firmware/Tools/sitl_gazebo/Build/msgs/:$HOME/catkin_ws/src/kth_uav/Firmware/build/posix_sitl_default/build_gazebo
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$HOME/catkin_ws/src/Firmware:$HOME/catkin_ws/src/kth_uav/Firmware/Tools/sitl_gazebo

export CURRENT_CMAKE_BUILD_DIR="$(catkin locate --workspace ~/catkin_ws --build)"
