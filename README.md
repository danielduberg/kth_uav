# KTH UAV

## Assumptions
1. You are running `Ubuntu 16.04`
2. You are using `bash`
3. You have installed `ros-kinetic-desktop-full` (otherwise follow this guide: [http://wiki.ros.org/kinetic/Installation/Ubuntu] and install `ros-kinetic-desktop-full`)
4. You are using `catkin build` instead of `catkin_make`
   1. If you have not used `catkin build` before, then read this: [http://catkin-tools.readthedocs.io/en/latest/verbs/catkin_build.html]

## Prerequisites

## Install Instructions
1. Clone to your ROS workspace: `git clone https://github.com/danielduberg/kth_uav.git`
2. Run `install.sh` (might have to `chmod +x install.sh` first)
3. Close down Gazebo and `CTRL+c` the terminal
4. `source ~/.bashrc` or restart the terminal

## Package Explaination
### `mavros`
1. This is what you should use to communicate with the UAV.
2. Here is a list of some of the most interesting topics:

    | Filename               | Use           |
    | ---------------------- |:--------------|
    | `/mavros/distance_sensor/teraranger` | Get the distance measure from the TeraRanger. |
    | `/mavros/imu/data`                   | Get IMU data. |
    | `/mavros/local_position/odom`        | Get pose of UAV and velocity in UAV frame. |
    | `/mavros/local_position/pose`        | Get pose of the UAV. |
    | `/mavros/local_position/velocity`    | Get velocity in map frame. |
    | `/mavros/mocap/pose`                 | Send your estimate of the pose of the UAV. |
    | `/mavros/setpoint_raw/local`         | The prefered (by me) topic to publish positions, velocities, and accelerations to the UAV. From my experience you can only send one of the three at the same time. You can specify which frame the message is in, which makes it possible to give velocity in UAV frame instead of map frame. Only use the non-OFFSET frames, OFFSET is not working with `px4`. |
    | `/mavros/setpoint_velocity/cmd_vel`  | Can be used to send velocities. But I prefer the above one instead since it is easier to switch to sending positions if you find that better later on. With the above you can also specify the frame, which you can not here. |
    | `/mavros/setpoint_position/local`    | Can be used to send positions. Once again I prefer `/mavros/setpoint_raw/local` over this. |
    
3. Here is a list of some of the most interesting services:

    | Filename               | Use           |
    | ---------------------- |:--------------|
    | `/mavros/cmd/arming`   | Used to arm/disarm the UAV. |
    | `/mavros/set_mode`                   | Change between different mode. Use `offboard` to control it with the above topics. For it to stay in `offboard` you have to publish continously at a certain frequence, else it will go back to the mode it was in before going into `offboard`. You can use `land` when you want to land. |  

### `simulation`
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
    
### `px4`/`Firmware`
1. This is the code that is running on the FCU.

### `mavlink`
1. This is the intermidiate layer between the `px4` and `mavros`.
