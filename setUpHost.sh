#!/bin/bash

set -e

if [ "$(whoami)" != "root" ]; then
	echo "You need to be sudo to run this script"
	exit 1
fi

line="=-=-=-=-=-="
echo $line Updating repos $line

sudo apt update -y && sudo apt upgrade -y

echo $line Installing RPI Pico $line

cd ~

sudo apt install -y cmake python3 build-essential gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib

echo $line Installing ROS JASSY $line
locale  # check for UTF-8

sudo apt install -y locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale  # verify settings

echo $line Adding ROS repos $line
sudo apt install -y software-properties-common
sudo add-apt-repository universe
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update && sudo apt install ros-dev-tools

echo $line Installing ROS $line

sudo apt update && sudo apt upgrade

sudo apt install -y ros-jazzy-desktop


echo $line Alles gut! $line
