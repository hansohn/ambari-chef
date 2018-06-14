# # encoding: utf-8

# Inspec test for recipe ambari-chef::ambari_agent_service

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html


control 'ambari-chef::ambari_agent_service' do
  title 'Testing ambari-agent service'

  describe service('ambari-agent') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end

  describe port(8670) do
    it { should be_listening }
  end
end
