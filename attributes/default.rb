# -- PYTHON --
default['python']['python2']['install'] = true
default['python']['python2']['packages'] = ['python']
default['python']['python2']['pips'] = []

# -- JAVA --
default['java']['install_from'] = 'amazon_source'
default['java']['install_version'] = 'jdk-8u212-linux-x64'

# -- HW CLUSTER --
default['hw']['cluster']['name'] = 'demo'
default['hw']['cluster']['blueprint_name'] = 'demo_blueprint'
default['hw']['cluster']['blueprint_file'] = 'demo_blueprint.json'
default['hw']['cluster']['hostmapping_file'] = 'demo_hostmapping.json'
default['hw']['cluster']['version_definition_file'] = 'demo_vdf.json'

# -- AMBARI REPO --
default['hw']['ambari']['version'] = '2.7.3'
# 2.4.0
default['hw']['ambari']['2.4.0']['version_full'] = '2.4.0.1-1'
default['hw']['ambari']['2.4.0']['repo'] = "http://public-repo-1.hortonworks.com/ambari/centos#{node['platform_version'].to_i}/2.x/updates/2.4.0.1/ambari.repo"
# 2.4.3
default['hw']['ambari']['2.4.3']['version_full'] = '2.4.3.0-30'
default['hw']['ambari']['2.4.3']['repo'] = "http://public-repo-1.hortonworks.com/ambari/centos#{node['platform_version'].to_i}/2.x/updates/2.4.3.0/ambari.repo"
# 2.5.0
default['hw']['ambari']['2.5.0']['version_full'] = '2.5.2.0-298'
default['hw']['ambari']['2.5.0']['repo'] = "http://public-repo-1.hortonworks.com/ambari/centos#{node['platform_version'].to_i}/2.x/updates/2.5.2.0/ambari.repo"
# 2.6.2
default['hw']['ambari']['2.6.2']['version_full'] = '2.6.2.2-1'
default['hw']['ambari']['2.6.2']['repo'] = "http://public-repo-1.hortonworks.com/ambari/centos#{node['platform_version'].to_i}/2.x/updates/2.6.2.2/ambari.repo"
# 2.7.0
default['hw']['ambari']['2.7.0']['version_full'] = '2.7.0.0-897'
default['hw']['ambari']['2.7.0']['repo'] = "http://public-repo-1.hortonworks.com/ambari/centos#{node['platform_version'].to_i}/2.x/updates/2.7.0.0/ambari.repo"
# 2.7.3
default['hw']['ambari']['2.7.3']['version_full'] = '2.7.3.0-139'
default['hw']['ambari']['2.7.3']['repo'] = "http://public-repo-1.hortonworks.com/ambari/centos#{node['platform_version'].to_i}/2.x/updates/2.7.3.0/ambari.repo"

# -- AMBARI CONFIG --
default['hw']['ambari']['server']['setup']['db']['databasehost'] = 'localhost'
default['hw']['ambari']['server']['setup']['db']['databaseport'] = '5432'
default['hw']['ambari']['server']['setup']['db']['databasepassword'] = 'bigdata'
default['hw']['ambari']['server']['setup']['security']['setup-truststore'] = 'false'
default['hw']['ambari']['server']['config']['ambari.properties']['ambari.ldap.isConfigured'] = 'false'
default['hw']['ambari']['server']['config']['ambari.properties']['api.ssl'] = 'false'
default['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.bindAnonymously'] = 'false'
default['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.dnAttribute'] = 'dn'
default['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.groupMembershipAttr'] = 'memberUid'
default['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.groupNamingAttr'] = 'cn'
default['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.groupObjectClass'] = 'posixgroup'
default['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.managerPassword'] = '/etc/ambari-server/conf/ldap-password.dat'
default['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.referral'] = 'follow'
default['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.usernameAttribute'] = 'uid'
default['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.userObjectClass'] = 'person'
default['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.useSSL'] = 'true'
default['hw']['ambari']['server']['config']['ambari.properties']['client.api.port'] = '8080'
default['hw']['ambari']['server']['config']['ambari.properties']['client.api.ssl.cert_name'] = 'https.crt'
default['hw']['ambari']['server']['config']['ambari.properties']['client.api.ssl.key_name'] = 'https.key'
default['hw']['ambari']['server']['config']['ambari.properties']['client.api.ssl.port'] = '8443'
default['hw']['ambari']['server']['config']['ambari.properties']['gpl.license.accepted'] = 'true'
default['hw']['ambari']['server']['config']['ambari.properties']['security.server.two_way_ssl'] = 'false'
default['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.connection-pool'] = 'internal'
default['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.database_name'] = 'ambari'
default['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.database'] = 'postgres'
default['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.driver'] = 'org.postgresql.Driver'
default['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.hostname'] = 'localhost'
default['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.port'] = 5432
default['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.postgres.schema'] = 'ambari'
default['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.rca.driver'] = 'org.postgresql.Driver'
default['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.rca.url'] = 'jdbc:postgresql://localhost:5432/ambari'
default['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.rca.user.name'] = 'ambari'
default['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.rca.user.passwd'] = '/etc/ambari-server/conf/password.dat'
default['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.url'] = 'jdbc:postgresql://localhost:5432/ambari'
default['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.user.name'] = 'ambari'
default['hw']['ambari']['server']['config']['ambari.properties']['server.jdbc.user.passwd'] = '/etc/ambari-server/conf/password.dat'
default['hw']['ambari']['server']['config']['ambari.properties']['ssl.trustStore.password'] = 'changeit'
default['hw']['ambari']['server']['config']['ambari.properties']['ssl.trustStore.path'] = '/var/lib/ambari-server/keys/keystore.jks'
default['hw']['ambari']['server']['config']['ambari.properties']['ssl.trustStore.type'] = 'jks'
default['hw']['ambari']['server']['crypto']['ca'] = '/etc/pki/ca-trust/source/anchors/ca.crt'
default['hw']['ambari']['server']['crypto']['https_cert'] = "/etc/pki/tls/certs/#{node['fqdn']}.crt"
default['hw']['ambari']['server']['crypto']['https_key'] = "/etc/pki/tls/private/#{node['fqdn']}.key"
default['hw']['ambari']['server']['crypto']['https_key_pass'] = 'changeit'
default['hw']['ambari']['server']['crypto']['https_keystore_p12'] = "/etc/pki/tls/certs/#{node['fqdn']}.p12"
default['hw']['ambari']['server']['crypto']['https_keystore_jks'] = "/etc/pki/tls/certs/#{node['fqdn']}.jks"
default['hw']['ambari']['server']['crypto']['ldap_pass'] = 'changeit'
default['hw']['ambari']['server']['crypto']['truststore_jks'] = "/etc/pki/tls/certs/#{node['fqdn']}.jks"
default['hw']['ambari']['server']['crypto']['truststore_pass'] = 'changeit'
default['hw']['ambari']['server']['user']['name'] = 'ambari-server'
default['hw']['ambari']['server']['user']['uid'] = '15010'
default['hw']['ambari']['server']['user']['home'] = '/var/lib/ambari-server'
default['hw']['ambari']['server']['user']['shell'] = '/bin/bash'
default['hw']['ambari']['agent']['setup']['security']['setup-truststore'] = 'false'
default['hw']['ambari']['agent']['config']['ambari-agent.ini']['keysdir'] = '/var/lib/ambari-agent/keys'
default['hw']['ambari']['agent']['crypto']['cert'] = "/etc/pki/tls/certs/#{node['fqdn']}.crt"
default['hw']['ambari']['agent']['crypto']['key'] = "/etc/pki/tls/private/#{node['fqdn']}.key"
default['hw']['ambari']['agent']['crypto']['ca'] = '/etc/pki/ca-trust/source/anchors/ca.crt'
default['hw']['ambari']['agent']['crypto']['truststore_jks'] = "/etc/pki/tls/certs/#{node['fqdn']}.jks"
default['hw']['ambari']['agent']['user']['name'] = 'ambari-agent'
default['hw']['ambari']['agent']['user']['home'] = '/var/lib/ambari-agent'
default['hw']['ambari']['agent']['user']['shell'] = '/bin/bash'
default['hw']['ambari']['agent']['user']['uid'] = '15011'
default['hw']['ambari']['infra']['config']['infra-solr-env']['infra_solr_datadir'] = '/opt/ambari_infra_solr/data'
default['hw']['ambari']['infra']['config']['infra-solr-env']['infra_solr_keystore_location'] = '/etc/security/serverKeys/infra.solr.keyStore.jks'
default['hw']['ambari']['infra']['config']['infra-solr-env']['infra_solr_keystore_type'] = 'jks'
default['hw']['ambari']['infra']['config']['infra-solr-env']['infra_solr_keystore_password'] = 'changeit'
default['hw']['ambari']['infra']['config']['infra-solr-env']['infra_solr_port'] = '8886'
default['hw']['ambari']['infra']['config']['infra-solr-env']['infra_solr_ssl_enabled'] = 'false'
default['hw']['ambari']['infra']['config']['infra-solr-env']['infra_solr_truststore_location'] = '/etc/security/serverKeys/infra.solr.trustStore.jks'
default['hw']['ambari']['infra']['config']['infra-solr-env']['infra_solr_truststore_type'] = 'jks'
default['hw']['ambari']['infra']['config']['infra-solr-env']['infra_solr_truststore_password'] = 'changeit'
default['hw']['ambari']['infra']['config']['infra-solr-env']['infra_solr_user'] = 'infra-solr'
default['hw']['ambari']['infra']['crypto']['keystore_jks'] = '/var/lib/ambari-infra-solr/keys/infra.solr.keyStore.jks'
default['hw']['ambari']['infra']['crypto']['truststore_jks'] = '/var/lib/ambari-infra-solr/keys/infra.solr.trustStore.jks'
default['hw']['ambari']['infra']['user']['name'] = 'infra-solr'
default['hw']['ambari']['infra']['user']['home'] = '/home/infra-solr'
default['hw']['ambari']['infra']['user']['shell'] = '/bin/bash'
default['hw']['ambari']['infra']['user']['uid'] = '15018'
default['hw']['ambari']['metrics']['config']['ams-grafana-env']['metrics_grafana_data_dir'] = '/var/lib/ambari-metrics-grafana'
default['hw']['ambari']['metrics']['config']['ams-grafana-env']['metrics_grafana_username'] = 'admin'
default['hw']['ambari']['metrics']['config']['ams-grafana-env']['metrics_grafana_password'] = 'admin'
default['hw']['ambari']['metrics']['config']['ams-grafana-ini']['cert_file'] = '/etc/ambari-metrics-grafana/conf/ams-grafana.crt'
default['hw']['ambari']['metrics']['config']['ams-grafana-ini']['cert_key'] = '/etc/ambari-metrics-grafana/conf/ams-grafana.key'
default['hw']['ambari']['metrics']['config']['ams-grafana-ini']['port'] = '3000'
default['hw']['ambari']['metrics']['config']['ams-grafana-ini']['protocol'] = 'http'
default['hw']['ambari']['metrics']['config']['ams-hbase-site']['hbase.rootdir'] = 'file:///var/lib/ambari-metrics-collector/hbase'
default['hw']['ambari']['metrics']['config']['ams-hbase-site']['hbase.tmp.dir'] = '/var/lib/ambari-metrics-collector/hbase-tmp'
default['hw']['ambari']['metrics']['config']['ams-site']['timeline.metrics.aggregator.checkpoint.dir'] = '/var/lib/ambari-metrics-collector/checkpoint'
default['hw']['ambari']['metrics']['crypto']['cert'] = '/etc/ambari-metrics-grafana/conf/ams-grafana.crt'
default['hw']['ambari']['metrics']['crypto']['key'] = '/etc/ambari-metrics-grafana/conf/ams-grafana.key'
default['hw']['ambari']['metrics']['user']['name'] = 'ams'
default['hw']['ambari']['metrics']['user']['home'] = '/home/ams'
default['hw']['ambari']['metrics']['user']['shell'] = '/bin/bash'
default['hw']['ambari']['metrics']['user']['uid'] = '15013'
default['hw']['hadoop']['common']['group']['name'] = 'hadoop'
default['hw']['hadoop']['common']['group']['gid'] = '10010'
default['hw']['logsearch']['config']['logfeeder-env']['logfeeder_keystore_location'] = '/etc/security/serverKeys/logsearch.keyStore.jks'
default['hw']['logsearch']['config']['logfeeder-env']['logfeeder_keystore_type'] = 'jks'
default['hw']['logsearch']['config']['logfeeder-env']['logfeeder_keystore_password'] = 'changeit'
default['hw']['logsearch']['config']['logfeeder-env']['logfeeder_truststore_location'] = '/etc/security/serverKeys/logsearch.trustStore.jks'
default['hw']['logsearch']['config']['logfeeder-env']['logfeeder_keystore_location'] = 'jks'
default['hw']['logsearch']['config']['logfeeder-env']['logfeeder_truststore_password'] = 'changeit'
default['hw']['logsearch']['config']['logsearch-admin-json']['logsearch_admin_username'] = 'ambari_logsearch_admin'
default['hw']['logsearch']['config']['logsearch-admin-json']['logsearch_admin_password'] = 'ambari_logsearch_password'
default['hw']['logsearch']['config']['logsearch-env']['logsearch_keystore_location'] = '/etc/security/serverKeys/logsearch.keyStore.jks'
default['hw']['logsearch']['config']['logsearch-env']['logsearch_keystore_type'] = 'jks'
default['hw']['logsearch']['config']['logsearch-env']['logsearch_keystore_password'] = 'changeit'
default['hw']['logsearch']['config']['logsearch-env']['logsearch_truststore_location'] = '/etc/security/serverKeys/logsearch.trustStore.jks'
default['hw']['logsearch']['config']['logsearch-env']['logsearch_truststore_type'] = 'jks'
default['hw']['logsearch']['config']['logsearch-env']['logsearch_truststore_password'] = 'changeit'
default['hw']['logsearch']['config']['logsearch-env']['logsearch_ui_port'] = '61888'
default['hw']['logsearch']['config']['logsearch-env']['logsearch_ui_protocol'] = 'http'
default['hw']['logsearch']['crypto']['keystore_jks'] = '/var/lib/logsearch/keys/logsearch.keyStore.jks'
default['hw']['logsearch']['crypto']['truststore_jks'] = '/var/lib/logsearch/keys/logsearch.trustStore.jks'
default['hw']['logsearch']['user']['name'] = 'logsearch'
default['hw']['logsearch']['user']['home'] = '/home/logsearch'
default['hw']['logsearch']['user']['shell'] = '/bin/bash'
default['hw']['logsearch']['user']['uid'] = '15021'

case node.chef_environment
when 'production'
  default['hw']['ambari']['server']['config']['ambari.properties']['host_cname'] = 'ambari.prd.domain.local'
  default['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.baseDn'] = 'dc=prd,dc=domain,dc=local'
  default['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.managerDn'] = 'uid=manager,cn=users,cn=accounts,dc=prd,dc=domain,dc=local'
  default['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.primaryUrl'] = 'ldap-server-01.prd.domain.local:636'
  default['hw']['ambari']['server']['setup']['ldap']['ldap_sync_groups'] = ['prd_user_group']
  default['hw']['ambari']['server']['setup']['ldap']['ldap_sync_users'] = ['prd_user']
when 'staging'
  default['hw']['ambari']['server']['config']['ambari.properties']['host_cname'] = 'ambari.stg.domain.local'
  default['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.baseDn'] = 'dc=stg,dc=domain,dc=local'
  default['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.managerDn'] = 'uid=manager,cn=users,cn=accounts,dc=stg,dc=domain,dc=local'
  default['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.primaryUrl'] = 'ldap-server-01.stg.domain.local:636'
  default['hw']['ambari']['server']['setup']['ldap']['ldap_sync_groups'] = ['stg_user_group']
  default['hw']['ambari']['server']['setup']['ldap']['ldap_sync_users'] = ['stg_user']
else
  default['hw']['ambari']['server']['config']['ambari.properties']['host_cname'] = 'ambari.dev.domain.local'
  default['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.baseDn'] = 'dc=dev,dc=domain,dc=local'
  default['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.managerDn'] = 'uid=manager,cn=users,cn=accounts,dc=dev,dc=domain,dc=local'
  default['hw']['ambari']['server']['config']['ambari.properties']['authentication.ldap.primaryUrl'] = 'ldap-server-01.dev.domain.local:636'
  default['hw']['ambari']['server']['setup']['ldap']['ldap_sync_groups'] = ['dev_user_group']
  default['hw']['ambari']['server']['setup']['ldap']['ldap_sync_users'] = ['dev_user']
end
