# MySQL Galera from Codership

This is a Helm chart for MySQL Galera from Codership.

## Installation
1. Plan your cluster capacity. Default is 3 nodes, each with 1 vCPU and 4GB of RAM, the storage is 2GB. It is minimal requirement for Galera to work.
2. Consider separate namespace for the MySQL Galera cluster, like `mysql-galera`.
3. Install the MySQL Galera chart with desired capacity.

## Configuration
Sometimes you need to configure the MySQL Galera cluster with custom values. You can do this by setting the customConfig multiline in values.yaml.

See the values.yaml file for the full list of configurable parameters.
