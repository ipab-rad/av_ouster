^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package av_ouster_launch
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Forthcoming
-----------
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
