^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package av_ouster_launch
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

2.3.0 (2024-10-07)
------------------
* Update Ouster-2 params (`#14 <https://github.com/ipab-rad/av_ouster/issues/14>`_)
  - Use `TIME_FROM_SYNC_PULSE_IN` to use NMEA timestamp for pointclouds
  - Switch to non-deprecated `RNG19_RFL8_SIG16_NIR16` udp profile
  - Revert to full point_type "original" as we need `xyzirt`
* Contributors: Alejandro Bordallo

2.2.0 (2024-08-27)
------------------
* Change point type to xyzi
* Contributors: Hector Cruz

2.1.0 (2024-07-04)
------------------
* Fix ros driver build error
* Contributors: hect95

2.0.0 (2024-07-04)
------------------
* Migrate sensor driver to Ouster's official
  ROS 2 driver
* Adapt launch pipeline for new driver
  - driver_launch.py is removed
* Contributors: hect95

1.2.0 (2024-06-05)
------------------
* Add bash args to optionally load local cyclone_dds
* Contributors: Alejandro Bordallo, hect95

1.1.0 (2024-05-20)
------------------
* Add cyclone DDS as ROS RMW  + configurate it to support high msg throughput
* Avoid `dev.sh` override `latest` docker tag for convenience
* Enable colorised ROS log

1.0.1 (2024-05-07)
------------------
* Using ROS timestamp
* Contributors: Hector Cruz

1.0.0 (2024-04-30)
------------------
* Fix line length on inherited python launch script
* Fix matched_node_name deprecation warn
* Porting code frome ipab-rad/ros2_ouster_drivers
  - Implementing av_ouster_launch ros2 package, dockerfile and
  scripts
  - ros2 ouster drivers are now installed via the apt repository
* Contributors: Alejandro Bordallo, Hector Cruz
