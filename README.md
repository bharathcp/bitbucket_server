# Bitbucket server cookbook

[![Chef cookbook](https://img.shields.io/cookbook/v/bitbucket_server.svg)](https://github.com/bharathcp/bitbucket_server)
![Build Status](https://travis-ci.org/bharathcp/bitbucket_server.svg?branch=master)
[![License](https://img.shields.io/badge/license-Apache_2-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)
[![Dependency Status](https://www.versioneye.com/user/projects/5948ed6a6725bd00322511d8/badge.svg)](https://www.versioneye.com/user/projects/5948ed6a6725bd00322511d8)
[![GitHub issues](https://img.shields.io/github/issues/bharathcp/bitbucket_server.svg)](https://github.com/bharathcp/bitbucket_server/issues)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/bharathcp/bitbucket_server.svg)](https://github.com/bharathcp/bitbucket_server/pulls)
[![GitHub contributors](https://img.shields.io/github/contributors/bharathcp/bitbucket_server.svg)](https://github.com/bharathcp/bitbucket_server/graphs/contributors)

The bitbucket server cookbook is a library cookbook that provides resource primitives for use in recipes. 

## Requirements

- Chef 12.7+
- git 5.8.8+
- java 8+
- unzip (to be used if required for backup_client resource)

## Platform Support

- CentOS 7
- Ubuntu 16.04
- Debian 8.8
- Fedora 25
- Opensuse-leap 42.2

We actively test on above platforms version. But any other linux version that supports `systemd` should work.

## Cookbook Dependencies
- ark

## Bitbucket version
This cookbook only supports versions of bitbucket server 5.0.0 and above.

## Usage

Place a dependency on the bitbucket_server cookbook in your cookbook's metadata.rb

```ruby
depends 'bitbucket_server'
```

Then, in a recipe within your cookbook:

```ruby
bitbucket_install 'bitbucket' do
  jre_home "#{node['java']['java_home']}/jre"
end
```

### Custom resources
#### `bitbucket_install`
This resource installs a bitbucket server and sets the `BITBUCKET_HOME`. It expects the `JAVA_HOME` to be set. If it is not, then `jre_home` has to be set as an attribute. The usage is:
```ruby
bitbucket_install 'bitbucket' do
  jre_home "#{node['java']['java_home']}/jre"
end
```
Below are the attributes supported by this resource:

| Property        | String | default                                                                      | required |
|-----------------|:------:|------------------------------------------------------------------------------|----------|
| product         | String | bitbucket                                                                    | false    |
| version         | String | 5.0.1                                                                        | false    |
| bitbucket_user  | String | atlbitbucket                                                                 | false    |
| bitbucket_group | String | atlbitbucket                                                                 | false    |
| home_path       | String | /var/atlassian/application-data/bitbucket                                    | false    |
| install_path    | String | /opt/atlassian                                                               | false    |
| checksum        | String | 677528dffb770fab9ac24a2056ef7be0fc41e45d23fc2b1d62f04648bfa07fad             | false    |
| url_base        | String | http://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket | false    |
| jre_home        | String |                                                                              | false    |
| jvm_args        | String |                                                                              | false    |

To unit test the usage of this resource you can use `install_bitbucket` matcher in chefspec like:

```ruby
  expect(chef_run).to install_bitbucket('bitbucket').with_jre_home('/usr/lib/jvm/java-8-oracl/jre')
```

#### `bitbucket_config`
This resource configures an already installed bitbucket. The configurations can be provided as a `Hash`. Below is the usage:
```ruby
bitbucket_config 'bitbucket' do
  bitbucket_properties node['bitbucket']['properties']
end
```
or
```ruby
bitbucket_config 'bitbucket' do
  bitbucket_properties {'setup.displayName' => 'aasdasd','setup.baseUrl' => 'http://localhost:7990'}
end
```

Below are the attributes supported by this resource:

| Property             | String | default                                                                      | required |
|----------------------|:------:|------------------------------------------------------------------------------|----------|
| product              | String | bitbucket                                                                    | false    |
| bitbucket_user       | String | atlbitbucket                                                                 | false    |
| bitbucket_group      | String | atlbitbucket                                                                 | false    |
| home_path            | String | /var/atlassian/application-data/bitbucket                                    | false    |
| bitbucket_properties | Hash   |                                                                              | true     |

To unit test the usage of this resource you can use `config_bitbucket` matcher in chefspec like:

```ruby
  expect(chef_run).to config_bitbucket('bitbucket').with_bitbucket_properties('setup.displayName' => 'my bitbucket')
```

To check the possible configurations to set in the Hash refer to *[Bitbucket Documentation](https://confluence.atlassian.com/bitbucketserver) > Administering Bitbucket Server > Bitbucket Server config properties*.
At the minimum it is useful to configure the setup properties mentioned in *[Bitbucket Documentation](https://confluence.atlassian.com/bitbucketserver) > Install or upgrade Bitbucket Server > Bitbucket Server installation guide > Automated setup for Bitbucket Server*.

#### `bitbucket_service`
This resource is used to create a systemd service config. It will `create`, `enable` and `start` the service. The name of the service is set by the property `product`. Below is the usage:

```ruby
bitbucket_service 'bitbucket'
```

Below are the attributes supported by this resource:

| Property             | String | default                                                                      | required |
|----------------------|:------:|------------------------------------------------------------------------------|----------|
| product              | String | bitbucket                                                                    | false    |
| bitbucket_user       | String | atlbitbucket                                                                 | false    |
| install_path         | String | /opt/atlassian                                                               | false    |

To unit test the usage of this resource you can use `service_bitbucket` matcher in chefspec like:

```ruby
  expect(chef_run).to service_bitbucket('bitbucket')
```

#### `backup_client`
This resource installs bitbucket backup-client and creates the backup properties config file.

Usage :
```ruby
backup_client 'bitbucket' do
  backup_user 'bitbucket_backup'
  backup_password 'passwd'
  bitbucket_url 'http://bitbucket_url:7990'
  backup_path '/tmp'
end
```
Below are the attributes supported by this resource:

| Property        | String | default                                                                      | required |
|-----------------|:------:|------------------------------------------------------------------------------|----------|
| product         | String | bitbucket                                                                    | false    |
| version         | String | 3.3.2                                                                        | false    |
| bitbucket_user  | String | atlbitbucket                                                                 | false    |
| bitbucket_group | String | atlbitbucket                                                                 | false    |
| home_path       | String | /var/atlassian/application-data/bitbucket                                    | false    |
| install_path    | String | /opt/atlassian                                                               | false    |
| bitbucket_url   | String | http://127.0.0.1:7990                           | false    |
| client_url      | String | http://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket | false    |
| backup_path     | String |                                                                              | true    |
| backup_user     | String |                                                                              | false    |
| backup_password     | String |                                                                              | false    |

## Testing
chef exec bundle install

To check rake tasks
```bash
chef exec bundle exec rake --tasks
```

To execute lynt and unit tests
```bash
chef exec bundle exec rake style
chef exec bundle exec rake unit
```
or 
```bash
chef exec bundle exec delivery local lint
chef exec bundle exec delivery local syntax
chef exec bundle exec delivery local unit
```
or 
```bash
chef exec bundle exec delivery local all
```

To execute Integration tests
```bash
rake integration:kitchen:<suitename-platform>
```
for instance:
```bash
rake integration:kitchen:default-centos-73
```
To directly use Kitchen
```bash
chef exec kitchen verify <suitename-platform>
```
for instance:
```bash
rake integration:kitchen:default-centos-73
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## License and Author

Author: Bharath Prakash (cippy.bharath@gmail.com)

Author: Raghavendra Gona (graghav@gmail.com)

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
