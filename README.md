# ambari-chef

[![Build Status](https://travis-ci.org/hansohn/ambari-chef.svg?branch=master)](https://travis-ci.org/hansohn/ambari-chef) [![GitHub tag](https://img.shields.io/github/tag/hansohn/ambari-chef.svg)](https://github.com/hansohn/ambari-chef)

This cookbook installs [Apache Ambari](https://ambari.apache.org/), a project aimed at making Hadoop management simpler by developing software for provisioning, managing, and monitoring Apache Hadoop clusters. Ambari provides an intuitive, easy-to-use Hadoop management web UI backed by its RESTful APIs.

### Prerequsites

Ambari requires [Java](http://www.oracle.com/technetwork/java/javase/downloads/index.html) and [Python](https://www.python.org/) as prerequisites for installation. These prerequisites can be fulfilled using the `ambari-chef::ambari_server_prerequisites` or `ambari-chef::ambari_agent_prerequisites` recipes include with this cookbook or by any other means independently. You can customize the included prerequisites by modifying the following attributes.

```ruby
# python 2
override['python'] = {
  'python2' => {
    'packages' => ['python'],
  },
}

# java 8
override['java'] = {
  'install_from' => 'amazon_source',
  'install_version' => 'jdk-8u232-linux-x64',
}
```

### Configuration

By default this cookbook installs Ambari version ```2.7.4```, which at the time of this writing, is the current version. A different version of Ambari can be specified for installation by overriding the version attribute.

```ruby
# ambari
override['hw'] = {
  'ambari' => {
    'version' => '2.7.4',
    'server' => {
      'config' => {
        'ambari.properties' => {
          'api.ssl' => 'false',
          'client.api.port' => '8080',
        },
      },
    },
  },
}
```

### LDAP Authentication

To enable LDAP Authentication, define the following keys in your attributes file.

```ruby
# ambari ldap integration
override['hw'] = {
  'ambari' => {
    'server' => {
      'config' => {
        'ambari.properties' => {
          'ambari.ldap.isConfigured' => 'false',
          'authentication.ldap.baseDn' = 'dc=prd,dc=domain,dc=local',
          'authentication.ldap.managerDn' => 'uid=manager,cn=users,cn=accounts,dc=prd,dc=domain,dc=local',
          'authentication.ldap.primaryUrl' => 'ldap-server-01.prd.domain.local:636',
          'authentication.ldap.bindAnonymously' => 'false',
          'authentication.ldap.dnAttribute' => 'dn',
          'authentication.ldap.groupMembershipAttr' => 'memberUid',
          'authentication.ldap.groupNamingAttr' => 'cn',
          'authentication.ldap.groupObjectClass' => 'posixgroup',
          'authentication.ldap.managerPassword' => '/etc/ambari-server/conf/ldap-password.dat',
          'authentication.ldap.referral' => 'follow',
          'authentication.ldap.usernameAttribute' => 'uid',
          'authentication.ldap.userObjectClass' => 'person',
          'authentication.ldap.useSSL' => 'true',
        },
      },
    },
  },
}

# ambari ldap allowed users
override['hw'] = {
  'ambari' => {
    'server' => {
      'setup' => {
        'ldap' => {
          'ldap_sync_groups' => ['prd_user_group'],
          'ldap_sync_users' => ['prd_user'],
        },
      },
    },
  },
}
```

### PostgreSQL Database

Ambari installs and utilizes PostgreSQL by default. The `postgresql-server` package included in CestOS 7 at the time of this writing is `9.2.23`. If you are currently using a newer version of PostgreSQL you can modify the following attributes so that Ambari will point to your alternate version. You can can find more information about this [here](https://docs.hortonworks.com/HDPDocuments/Ambari-2.6.2.2/bk_ambari-administration/content/using_ambari_with_postgresql.html).

```ruby
# ambari server db setup values
override['hw'] = {
  'ambari' => {
    'server' => {
      'setup' => {
        'db' => {
          'databasehost' => 'localhost',
          'databaseport' => '5432',
          'databasepassword' => 'bigdata',
        },
      },
    },
  },
}

# ambari server config values
override['hw'] = {
  'ambari' => {
    'server' => {
      'config' => {
        'ambari.properties' => {
          'server.jdbc.connection-pool' => 'internal',
          'server.jdbc.database_name' => 'ambari',
          'server.jdbc.database' => 'postgres',
          'server.jdbc.driver' => 'org.postgresql.Driver',
          'server.jdbc.hostname' => 'localhost',
          'server.jdbc.port' => 5432,
          'server.jdbc.postgres.schema' => 'ambari',
          'server.jdbc.rca.driver' => 'org.postgresql.Driver',
          'server.jdbc.rca.url' => 'jdbc:postgresql://localhost:5432/ambari',
          'server.jdbc.rca.user.name' => 'ambari',
          'server.jdbc.rca.user.passwd' => '/etc/ambari-server/conf/password.dat',
          'server.jdbc.url' => 'jdbc:postgresql://localhost:5432/ambari',
          'server.jdbc.user.name' => 'ambari',
          'server.jdbc.user.passwd' => '/etc/ambari-server/conf/password.dat',
        },
      },
    },
  },
}
```

### Usage

##### Ambari Server

To install Ambari Server, include the ambari_server recipe in your run list

```ruby
# include ambari_server
include 'ambari-chef::ambari_server'
```

##### Ambari Agent

To install Ambari Server, include the ambari_agent recipe in your run list

```ruby
# include ambari_agent
include 'ambari-chef::ambari_agent'
```

##### Management Portal

Once installed, Ambari is available at http://127.0.0.1:8080 unless otherwise modified using the attributes referenced above. Ambari's default username and password are both `admin`.

### Documentation

The following resources may be helpful to better understand Ambari:

- [Apache Ambari](https://ambari.apache.org/)
- [Apache Ambari Blueprints](https://cwiki.apache.org/confluence/display/AMBARI/Blueprints)
- [Ambari Support Matrix](https://supportmatrix.hortonworks.com/)
- [Hortonworks Documentation](https://docs.hortonworks.com/index.html)
- [Hortonworks Community](https://community.hortonworks.com/answers/index.html)
