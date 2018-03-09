#!/bin/bash

#Source: https://stackoverflow.com/questions/16850029/bash-get-current-directory-of-file-after-getting-called-by-another-bash-script
CURRENT_FILE_PATH=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

if [ -f /opt/ros/kinetic/setup.bash ]; then
    source /opt/ros/kinetic/setup.bash
fi
if [ -f /opt/ros/indigo/setup.bash ]; then
    source /opt/ros/indigo/setup.bash
fi

# Set the plugin path so Gazebo finds our model and sim export
export GAZEBO_PLUGIN_PATH=${GAZEBO_PLUGIN_PATH}:$CURRENT_FILE_PATH/Firmware/build/posix_sitl_default/build_gazebo
# Set the model path so Gazebo finds the airframes
export GAZEBO_MODEL_PATH=${GAZEBO_MODEL_PATH}:$CURRENT_FILE_PATH/Firmware/Tools/sitl_gazebo/models:$CURRENT_FILE_PATH/simulation/models
# Set path to sitl_gazebo repository
export SITL_GAZEBO_PATH=$CURRENT_FILE_PATH/Firmware/Tools/sitl_gazebo
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$CURRENT_FILE_PATH/Firmware/Tools/sitl_gazebo/Build/msgs/:$CURRENT_FILE_PATH/Firmware/build/posix_sitl_default/build_gazebo
# So ROS finds these packages
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$CURRENT_FILE_PATH/Firmware:$CURRENT_FILE_PATH/Firmware/Tools/sitl_gazebo
