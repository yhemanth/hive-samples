hive-samples
============

hive-samples is a project that demonstrates various features of Apache Hive.

Dependencies
------------

* Apache Hadoop 2.x.y
* Apache Hive 0.13.x

Usage
-----

* Clone the repository
* Edit conf/hive-site.xml, and set javax.jdo.option.ConnectionURL to point to a path of your choice.
* Set HADOOP_HOME, HIVE_HOME and add Hadoop and Hive bin locations to the system OS path
* cd bin
* Execute run.sh <subdirectory-name-under-scripts-directory>, e.g. run.sh external_table_crud

