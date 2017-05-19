systemd_unit "#{node['bitbucket']['product']}.service" do
  enabled true
  content({
    'Unit' => {
      'Description' => 'Atlassian Bitbucket Server Service',
      'After'       => 'syslog.target network.target'
    },
    'Service' => {
      'Type' => 'forking',
      'User' => node['bitbucket']['user'],
      'ExecStart' => "#{node['bitbucket']['bin_path']}/start-bitbucket.sh",
      'ExecStop' => "#{node['bitbucket']['bin_path']}/stop-bitbucket.sh"
    },
    'Install' => {
      'WantedBy' => 'multi-user.target'
    }
  })
  action [:create, :enable]
  verify false
end

service node['bitbucket']['product'] do
  supports :status => true, :restart => true, :reload => true, :start => true, :stop => true
  start_command "#{node['bitbucket']['bin_path']}/start-bitbucket.sh"
  stop_command "#{node['bitbucket']['bin_path']}/stop-bitbucket.sh"
  action [ :enable, :start ]
end