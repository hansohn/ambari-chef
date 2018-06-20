# # encoding: utf-8

# Inspec test for recipe ambari-chef::python

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'ambari-chef::python2' do
  title 'Testing ambari-server installation'

  describe package('python') do
    it { should be_installed }
  end
end
