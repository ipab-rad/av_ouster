FROM ros:humble-ros-base-jammy AS base

# Install basic dev tools (And clean apt cache afterwards)
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
        apt-get -y --quiet --no-install-recommends install \
        sudo \
        gosu \
        ros-"$ROS_DISTRO"-ros2-ouster \
        # Install Cyclone DDS ROS RMW
        ros-"$ROS_DISTRO"-rmw-cyclonedds-cpp \
    && rm -rf /var/lib/apt/lists/*

# Setup ROS workspace folder
ENV ROS_WS /opt/ros_ws
WORKDIR $ROS_WS

# Set cyclone DDS ROS RMW
ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

COPY ./cyclone_dds.xml $ROS_WS/

# Configure Cyclone cfg file
ENV CYCLONEDDS_URI=file://${ROS_WS}/cyclone_dds.xml

# Enable ROS log colorised output
ENV RCUTILS_COLORIZED_OUTPUT=1

# -----------------------------------------------------------------------

FROM base AS prebuilt

# Import av_ouster_launch
COPY av_ouster_launch $ROS_WS/src/av_ouster_launch

# Source ROS setup for dependencies and build our code
RUN . /opt/ros/"$ROS_DISTRO"/setup.sh \
    && colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release

# -----------------------------------------------------------------------

FROM base AS dev

# Install basic dev tools (And clean apt cache afterwards)
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
        apt-get -y --quiet --no-install-recommends install \
        # Command-line editor
        nano \
        # Ping network tools
        inetutils-ping \
        # Bash auto-completion for convenience
        bash-completion \
    && rm -rf /var/lib/apt/lists/*

# Add sourcing local workspace command to bashrc for
#    convenience when running interactively
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> /root/.bashrc && \
    # Add colcon build alias for convenience
    echo 'alias colcon_build="colcon build --symlink-install \
        --cmake-args -DCMAKE_BUILD_TYPE=Release && \
        source install/setup.bash"' >> /root/.bashrc

COPY entrypoint.sh ./

# Set the entrypoint
ENTRYPOINT ["/opt/ros_ws/entrypoint.sh"]

# Enter bash for development
CMD ["bash"]

# -----------------------------------------------------------------------

FROM base as runtime

# Copy artifacts/binaries from prebuilt
COPY --from=prebuilt $ROS_WS/install $ROS_WS/install

# Add command to docker entrypoint to source newly compiled
#   code when running docker container
RUN sed --in-place --expression \
        "\$isource \"$ROS_WS/install/setup.bash\" " \
        /ros_entrypoint.sh

# launch ros package
CMD ["ros2", "launch", "av_ouster_launch", "av_ouster.launch.xml"]
