ubuntu_version=$(lsb_release -sr)
ros_version=""

if [ $ubuntu_version = "16.04" ]; then
  ros_version="kinetic"
  sudo apt-get -qq update
  sudo apt-get -qq install cmake
elif [ $ubuntu_version = "14.04" ]; then
  ros_version="indigo"
  sudo apt-get -qq update
  sudo apt-get -qq install cmake3
else 
  echo "Ubuntu version" $ubuntu_version "is not supported. Use 16.04 or 14.04."
  exit 1
fi

sudo apt install python-pip python-rosinstall python-rosinstall-generator python-wstool build-essential python-catkin-tools


sudo pip install numpy toml

if [ $ubuntu_version = "14.04" ]; then
  echo "Upgrading Gazebo to Gazebo 7"
  sudo apt-get -qq remove gazebo2
  sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
  wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
  sudo apt-get -qq update
  sudo apt-get -qq install ros-indigo-gazebo7-ros-pkgs ros-indigo-gazebo7-ros-control
fi


sudo apt install libprotobuf-dev libprotoc-dev protobuf-compiler libeigen3-dev gazebo7 libgazebo7-dev gstreamer1.0-* libgstreamer1.0-* libimage-exiftool-perl python-jinja2



sudo ~/catkin_ws/src/mavros/mavros/scripts/install_geographiclib_datasets.sh 
cd ~/catkin_ws/src/Firmware
git submodule update --init
git submodule update --recursive --remote
git submodule update --init --recursive
make posix_sitl_default gazebo

sudo apt-get install libusb-dev libbluetooth-dev libspnav-dev libcwiid-dev

catkin config --cmake-args -DCMAKE_CXX_COMPILER:STRING=/usr/bin/g++ -DCMAKE_BUILD_TYPE=Release --
