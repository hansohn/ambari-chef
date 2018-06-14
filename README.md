# ambari-chef

This cookbook installs [Apache Ambari](https://ambari.apache.org/), a project aimed at making Hadoop management simpler by developing software for provisioning, managing, and monitoring Apache Hadoop clusters. Ambari provides an intuitive, easy-to-use Hadoop management web UI backed by its RESTful APIs.

### Prerequsites

Ambari requires [Java](http://www.oracle.com/technetwork/java/javase/downloads/index.html) and [Python](https://www.python.org/) as prerequisites for installation. These prerequisites can be fulfilled using the `ambari-chef::ambari_server_prerequisites` or `ambari-chef::ambari_agent_prerequisites` recipes include with this cookbook or by any other means independently. You can customize the included prerequisites by modifying the following attributes.

```ruby
# python 2
node['python']['python2']['packages'] = [ 'python' ]

# java 8
node['java']['install_from'] = 'oracle_source'
node['java']['install_version'] = 'jdk-8u172-linux-x64'
```

### Configuration

By default this cookbook installs Ambari version ```2.6.2```, which at the time of this writing, is the current version. A different version of Ambari can be specified for installation by overriding the version attribute.

```ruby
# ambari
node['hw']['ambari']['version'] = '2.6.2'
node['hw']['ambari']['server']['config']['ambari.properties']['api.ssl'] = 'false'
node['hw']['ambari']['server']['config']['ambari.properties']['client.api.port'] = '8080'
```

### LDAP Authentication

To enable LDAP Authentication, define the following keys in your attributes file.

```ruby
# ambari ldap integration
node['hw']['ambari']['server']['config']['ambari.properties']['ambari.ldap.isConfigured'] = 'false'
node['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.bindAnonymously'] = 'false'
node['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.dnAttribute'] = 'dn'
node['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.groupMembershipAttr'] = 'memberUid'
node['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.groupNamingAttr'] = 'cn'
node['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.groupObjectClass'] = 'posixgroup'
node['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.managerPassword'] = '/etc/ambari-server/conf/ldap-password.dat'
node['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.referral'] = 'follow'
node['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.usernameAttribute'] = 'uid'
node['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.userObjectClass'] = 'person'
node['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.useSSL'] = 'true'
```

### PostgreSQL Database

Ambari installs and utilizes PostgreSQL by default. The `postgresql-server` package included in CestOS 7 at the time of this writing is `9.2.23`. If you are currently using a newer version of PostgreSQL you can modify the following attributes so that Ambari will point to your alternate version. You can can find more information about this [here](https://docs.hortonworks.com/HDPDocuments/Ambari-2.6.2.2/bk_ambari-administration/content/using_ambari_with_postgresql.html).

```ruby
# ambari server db setup values
node['hw']['ambari']['server']['setup']['db']['databasehost'] = 'localhost'
node['hw']['ambari']['server']['setup']['db']['databaseport'] = '5432'
node['hw']['ambari']['server']['setup']['db']['databasepassword'] = 'bigdata'

# ambari server config values
node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.connection-pool'] = 'internal'
node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.database_name'] = 'ambari'
node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.database'] = 'postgres'
node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.driver'] = 'org.postgresql.Driver'
node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.hostname'] = 'localhost'
node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.port'] = 5432
node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.postgres.schema'] = 'ambari'
node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.rca.driver'] = 'org.postgresql.Driver'
node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.rca.url'] = 'jdbc:postgresql://localhost:5432/ambari'
node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.rca.user.name'] = 'ambari'
node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.rca.user.passwd'] = '/etc/ambari-server/conf/password.dat'
node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.url'] = 'jdbc:postgresql://localhost:5432/ambari'
node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.user.name'] = 'ambari'
node['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.user.passwd'] = '/etc/ambari-server/conf/password.dat'
```

### Usage

##### Ambari Server

To install Ambari Server, include the ambari_server recipe in your run list

```ruby
# include ambari_server
include "ambari-chef::ambari_server"
```

##### Ambari Agent

To install Ambari Server, include the ambari_agent recipe in your run list

```ruby
# include ambari_agent
include "ambari-chef::ambari_agent"
```

##### Management Portal

Once installed, Ambari is available at http://127.0.0.1:8080 unless otherwise modified using the attributes referenced above. Ambari's default username and password are both `admin`.

### Documentation

The following resources may be helpful to better understand Ambari:

- [Apache Ambari](https://ambari.apache.org/)
- [Apache Ambari Blueprints](https://cwiki.apache.org/confluence/display/AMBARI/Blueprints)
- [Hortonworks Documentation](https://docs.hortonworks.com/index.html)
- [Hortonworks Community](https://community.hortonworks.com/answers/index.html)
