# av_ouster
This repository hosts the required environment for running the ROS 2 Ouster LIDAR driver, specifically configured for running with the [OS2-128](https://ouster.com/products/hardware/os2-lidar-sensor) sensor.


## Docker container
- **Operating System**: Ubuntu 22.04
- **ROS Distribution**: Humble Hawksbill
- **Velodyne Drivers**:
    - `ros-humble-ros2-ouster` ( version `0.4.2-1`): Manages communication with the OS2  lidar
    - `ros-humble-ouster-msgs/` (version `0.4.2-1`): Custom Ouster ROS msgs

For more details please see [Dockerfile](./Dockerfile)


### ROS 2 launcher

The `av_ouster_launch` ROS package contains the required launch files and configuration parameters for launching the driver for a Ouster OS2-128.


## Usage

 Quickly build and run the Docker container using `runtime.sh` for runtime or debugging, and `dev.sh` for a convenient development setup.

### Runtime or Debugging

Execute the ROS 2 nodes in runtime mode or start an interactive bash session for detailed debugging:

```bash
./runtime.sh [bash]
```

- **Without arguments**: Activates the container in runtime mode.
- **With `bash`**: Opens an interactive bash session for debugging.

### Development

Prepare a development setting that reflects local code modifications and simplifies the build process:

```bash
./dev.sh
```

- **Live Code Synchronization**: Mounts local `av_ouster_launch` directory with the container.
- **Convenience Alias**: The development container features a `colcon_build` alias, which simplifies the ROS2 build process. Executing `colcon_build` runs `colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release` and then sources the `setup.bash` to ensure the environment is updated with the latest build artifacts. This alias enhances productivity by combining build commands and environment setup into a single, easy command.
