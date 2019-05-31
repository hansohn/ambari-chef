# -- PYTHON --
default['python'] = {
  'python2' => {
    'install' => true,
    'packages' => ['python'],
    'pips' => [],
  },
}

# -- JAVA --
force_default['java'] = {
  'install_from' => 'amazon_source',
  'install_version' => 'jdk-8u212-linux-x64',
}

# -- AMBARI --
default['hw'] = {
  'cluster' => {
    'name' => 'demo',
    'blueprint_name' => 'demo_blueprint',
    'blueprint_file' => 'demo_blueprint.json',
    'hostmapping_file' => 'demo_hostmapping.json',
    'version_definition_file' => 'demo_vdf.json',
  },
  'ambari' => {
    'version' => '2.7.3',
    '2.4.0' => {
      'version_full' => '2.4.0.1-1',
      'repo' => "http://public-repo-1.hortonworks.com/ambari/centos#{node['platform_version'].to_i}/2.x/updates/2.4.0.1/ambari.repo",
    },
    '2.4.3' => {
      'version_full' => '2.4.3.0-30',
      'repo' => "http://public-repo-1.hortonworks.com/ambari/centos#{node['platform_version'].to_i}/2.x/updates/2.4.3.0/ambari.repo",
    },
    '2.5.0' => {
      'version_full' => '2.5.2.0-298',
      'repo' => "http://public-repo-1.hortonworks.com/ambari/centos#{node['platform_version'].to_i}/2.x/updates/2.5.2.0/ambari.repo",
    },
    '2.6.2' => {
      'version_full' => '2.6.2.2-1',
      'repo' => "http://public-repo-1.hortonworks.com/ambari/centos#{node['platform_version'].to_i}/2.x/updates/2.6.2.2/ambari.repo",
    },
    '2.7.0' => {
      'version_full' => '2.7.0.0-897',
      'repo' => "http://public-repo-1.hortonworks.com/ambari/centos#{node['platform_version'].to_i}/2.x/updates/2.7.0.0/ambari.repo",
    },
    '2.7.3' => {
      'version_full' => '2.7.3.0-139',
      'repo' => "http://public-repo-1.hortonworks.com/ambari/centos#{node['platform_version'].to_i}/2.x/updates/2.7.3.0/ambari.repo",
    },
    'server' => {
      'setup' => {
        'db' => {
          'databasehost' => 'localhost',
          'databaseport' => '5432',
          'databasepassword' => 'bigdata',
        },
        'security' => {
          'setup-truststore' => 'false',
        },
      },
      'config' => {
        'ambari.properties' => {
          'ambari.ldap.isConfigured' => 'false',
          'api.ssl' => 'false',
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
          'client.api.port' => '8080',
          'client.api.ssl.cert_name' => 'https.crt',
          'client.api.ssl.key_name' => 'https.key',
          'client.api.ssl.port' => '8443',
          'gpl.license.accepted' => 'true',
          'security.server.two_way_ssl' => 'false',
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
          'ssl.trustStore.password' => 'changeit',
          'ssl.trustStore.path' => '/var/lib/ambari-server/keys/keystore.jks',
          'ssl.trustStore.type' => 'jks',
        },
      },
      'crypto' => {
        'ca' => '/etc/pki/ca-trust/source/anchors/ca.crt',
        'https_cert' => "/etc/pki/tls/certs/#{node['fqdn']}.crt",
        'https_key' => "/etc/pki/tls/private/#{node['fqdn']}.key",
        'https_key_pass' => 'changeit',
        'https_keystore_p12' => "/etc/pki/tls/certs/#{node['fqdn']}.p12",
        'https_keystore_jks' => "/etc/pki/tls/certs/#{node['fqdn']}.jks",
        'ldap_pass' => 'changeit',
        'truststore_jks' => "/etc/pki/tls/certs/#{node['fqdn']}.jks",
        'truststore_pass' => 'changeit',
      },
      'user' => {
        'name' => 'ambari-server',
        'uid' => '15010',
        'home' => '/var/lib/ambari-server',
        'shell' => '/bin/bash',
      },
    },
    'agent' => {
      'setup' => {
        'security' => {
          'setup-truststore' => 'false',
        },
      },
      'config' => {
        'ambari-agent.ini' => {
          'keysdir' => '/var/lib/ambari-agent/keys',
        },
      },
      'crypto' => {
        'cert' => "/etc/pki/tls/certs/#{node['fqdn']}.crt",
        'key' => "/etc/pki/tls/private/#{node['fqdn']}.key",
        'ca' => '/etc/pki/ca-trust/source/anchors/ca.crt',
        'truststore_jks' => "/etc/pki/tls/certs/#{node['fqdn']}.jks",
      },
      'user' => {
        'name' => 'ambari-agent',
        'home' => '/var/lib/ambari-agent',
        'shell' => '/bin/bash',
        'uid' => '15011',
      },
    },
    'infra' => {
      'config' => {
        'infra-solr-env' => {
          'infra_solr_datadir' => '/opt/ambari_infra_solr/data',
          'infra_solr_keystore_location' => '/etc/security/serverKeys/infra.solr.keyStore.jks',
          'infra_solr_keystore_type' => 'jks',
          'infra_solr_keystore_password' => 'changeit',
          'infra_solr_port' => '8886',
          'infra_solr_ssl_enabled' => 'false',
          'infra_solr_truststore_location' => '/etc/security/serverKeys/infra.solr.trustStore.jks',
          'infra_solr_truststore_type' => 'jks',
          'infra_solr_truststore_password' => 'changeit',
          'infra_solr_user' => 'infra-solr',
        },
      },
      'crypto' => {
        'keystore_jks' => '/var/lib/ambari-infra-solr/keys/infra.solr.keyStore.jks',
        'truststore_jks' => '/var/lib/ambari-infra-solr/keys/infra.solr.trustStore.jks',
      },
      'user' => {
        'name' => 'infra-solr',
        'home' => '/home/infra-solr',
        'shell' => '/bin/bash',
        'uid' => '15018',
      },
    },
    'metrics' => {
      'config' => {
        'ams-grafana-env' => {
          'metrics_grafana_data_dir' => '/var/lib/ambari-metrics-grafana',
          'metrics_grafana_username' => 'admin',
          'metrics_grafana_password' => 'admin',
        },
        'ams-grafana-ini' => {
          'cert_file' => '/etc/ambari-metrics-grafana/conf/ams-grafana.crt',
          'cert_key' => '/etc/ambari-metrics-grafana/conf/ams-grafana.key',
          'port' => '3000',
          'protocol' => 'http',
        },
        'ams-hbase-site' => {
          'hbase.rootdir' => 'file:///var/lib/ambari-metrics-collector/hbase',
          'hbase.tmp.dir' => '/var/lib/ambari-metrics-collector/hbase-tmp',
        },
        'ams-site' => {
          'timeline.metrics.aggregator.checkpoint.dir' => '/var/lib/ambari-metrics-collector/checkpoint',
        },
      },
      'crypto' => {
        'cert' => '/etc/ambari-metrics-grafana/conf/ams-grafana.crt',
        'key' => '/etc/ambari-metrics-grafana/conf/ams-grafana.key',
      },
      'user' => {
        'name' => 'ams',
        'home' => '/home/ams',
        'shell' => '/bin/bash',
        'uid' => '15013',
      },
      'group' => {
        'name' => 'hadoop',
        'gid' => '10010',
      },
    },
  },
  'hadoop' => {
    'common' => {
      'group' => {
        'name' => 'hadoop',
        'gid' => '10010',
      },
    },
  },
  'logsearch' => {
    'config' => {
      'logfeeder-env' => {
        'logfeeder_keystore_location' => '/etc/security/serverKeys/logsearch.keyStore.jks',
        'logfeeder_keystore_type' => 'jks',
        'logfeeder_keystore_password' => 'changeit',
        'logfeeder_truststore_location' => '/etc/security/serverKeys/logsearch.trustStore.jks',
        'logfeeder_truststore_type' => 'jks',
        'logfeeder_truststore_password' => 'changeit',
      },
      'logsearch-admin-json' => {
        'logsearch_admin_username' => 'ambari_logsearch_admin',
        'logsearch_admin_password' =>  'ambari_logsearch_password',
      },
      'logsearch-env' => {
        'logsearch_keystore_location' => '/etc/security/serverKeys/logsearch.keyStore.jks',
        'logsearch_keystore_type' => 'jks',
        'logsearch_keystore_password' => 'changeit',
        'logsearch_truststore_location' => '/etc/security/serverKeys/logsearch.trustStore.jks',
        'logsearch_truststore_type' => 'jks',
        'logsearch_truststore_password' => 'changeit',
        'logsearch_ui_port' => '61888',
        'logsearch_ui_protocol' => 'http',
      },
    },
    'crypto' => {
      'keystore_jks' => '/var/lib/logsearch/keys/logsearch.keyStore.jks',
      'truststore_jks' => '/var/lib/logsearch/keys/logsearch.trustStore.jks',
    },
    'user' => {
      'name' => 'logsearch',
      'home' => '/home/logsearch',
      'shell' => '/bin/bash',
      'uid' => '15021',
    },
  },
}

if defined?(node.chef_environment)
  case node.chef_environment
  when 'production'
    force_default['hw'] = {
      'ambari' => {
        'server' => {
          'config' => {
            'ambari.properties' => {
              'host_cname' => 'ambari.prd.domain.local',
              'authentication.ldap.baseDn' => 'dc=prd,dc=domain,dc=local',
              'authentication.ldap.managerDn' => 'uid=manager,cn=users,cn=accounts,dc=prd,dc=domain,dc=local',
              'authentication.ldap.primaryUrl' => 'ldap-server-01.prd.domain.local:636',
            },
          },
          'setup' => {
            'ldap' => {
              'ldap_sync_groups' => ['prd_user_group'],
              'ldap_sync_users' => ['prd_user'],
            },
          },
        },
      },
    }
  when 'staging'
    normal['hw'] = {
      'ambari' => {
        'server' => {
          'config' => {
            'ambari.properties' => {
              'host_cname' => 'ambari.stg.domain.local',
              'authentication.ldap.baseDn' => 'dc=stg,dc=domain,dc=local',
              'authentication.ldap.managerDn' => 'uid=manager,cn=users,cn=accounts,dc=stg,dc=domain,dc=local',
              'authentication.ldap.primaryUrl' => 'ldap-server-01.stg.domain.local:636',
            },
          },
          'setup' => {
            'ldap' => {
              'ldap_sync_groups' => ['stg_user_group'],
              'ldap_sync_users' => ['stg_user'],
            },
          },
        },
      },
    }
  else
    normal['hw'] = {
      'ambari' => {
        'server' => {
          'config' => {
            'ambari.properties' => {
              'host_cname' => 'ambari.dev.domain.local',
              'authentication.ldap.baseDn' => 'dc=dev,dc=domain,dc=local',
              'authentication.ldap.managerDn' => 'uid=manager,cn=users,cn=accounts,dc=dev,dc=domain,dc=local',
              'authentication.ldap.primaryUrl' => 'ldap-server-01.dev.domain.local:636',
            },
          },
          'setup' => {
            'ldap' => {
              'ldap_sync_groups' => ['dev_user_group'],
              'ldap_sync_users' => ['dev_user'],
            },
          },
        },
      },
    }
  end
end
