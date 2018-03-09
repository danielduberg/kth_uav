# KTH UAV

## Assumptions
1. You are running `Ubuntu 16.04`
2. You are using `bash`
3. You have installed `ros-kinetic-desktop-full` (otherwise follow this guide: [http://wiki.ros.org/kinetic/Installation/Ubuntu] and install `ros-kinetic-desktop-full`)
4. You are using `catkin build` instead of `catkin_make`

## Prerequisites

## Install Instructions
1. Clone to your ROS workspace: `git clone https://github.com/danielduberg/kth_uav.git`
2. Run `install.sh` (might have to `chmod +x install.sh` first)
3. Close down Gazebo and you are done

## `px4`

## Example Use
1. `roslaunch simulation both.launch`

## `simulation` package explained
1. The folder `models` inside `simulation` contains Gazebo models. If you want, you can add more models in that folder and they will automatically show up in Gazebo.
3. The folder `worlds` contains worlds...
2. The folder `launch` contains a number of launch files and configuration files for PX4. We will go through each file in the table:

    | Filename               | Use           |
    | ---------------------- |:--------------|
    | `arm.launch`           | After you have launched the simulator you can launch this to arm the UAV and put it in `offboard` mode. You have to publish some sort of setpoint (one of `/mavros/setpoint...` topics) to the UAV at a certain frequency for it to stay in `offboard` mode. |
    | `client.launch`        | Launches only the Gazebo GUI. In the file you have to specify `GAZEBO_IP`, which is the IP of the client computer, and `GAZEBO_MASTER_URI`, which is the URI to the Gazebo server that you start using `server.launch`. |
    | `server.launch`        | Launches only the Gazebo server (no GUI). In the file you have to specify `GAZEBO_IP`, which is the IP of the server, and `GAZEBO_MASTER_URI`, which is the URI to the server (so they are the same except for the port number). |
    | `simulation.launch`    | Launches the simulator (both server and client). As with the `server.launch` you can in this file specify the model (UAV) and world to load by changing the arguments `sdf` and `world`, respectively. |
    | `px4_config.yaml`      | Config file for the PX4 where you can specify a bounch of fancy stuff. |
    | `px4_pluginlists.yaml` | In this file you can blacklist/whitelist different plugins used by PX4. |
