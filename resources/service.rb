#
# Cookbook:: bitbucket_server
# Resource:: service
#
resource_name :bitbucket_service

property :product, String, default: 'bitbucket'
property :install_path, String, default: '/opt/atlassian'
property :bitbucket_user, String, default: 'atlbitbucket'

action :create do
  systemd_unit "#{new_resource.product}.service" do
    enabled true
    content('Unit' => {
              'Description' => 'Atlassian Bitbucket Server Service',
              'After' => 'syslog.target network.target',
            },
            'Service' => {
              'Type' => 'forking',
              'User' => new_resource.bitbucket_user,
              'ExecStart' => "#{bin_path}/start-bitbucket.sh",
              'ExecStop' => "#{bin_path}/stop-bitbucket.sh",
            },
            'Install' => {
              'WantedBy' => 'multi-user.target',
            })
    action [:create, :enable, :start]
    verify false
  end
end

action_class do
  # ensure version in semver format MAJOR.MINOR.PATCH
  def bin_path
    "#{new_resource.install_path}/bitbucket/bin"
  end
end
