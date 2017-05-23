# Bitbucket server cookbook
 
![Build Status](https://travis-ci.org/bharathcp/bitbucket_server.svg?branch=master)

## Requirements

### Platforms
- CentOS 7

### Chef
Chef 12.4+

### Dependant cookbooks
- ark
- git
- java

## Bitbucket version
This cookbook only supports bitbucket server versions of 5.0.0 and above

## Usage
The should be added as a dependency in your wrapper cookbook. Then you can use the below resources to install and configure bitbucket server. 

### Custom resources
#### `bitbucket_install`
This resource installs a bitbucket server and sets the `BITBUCKET_HOME`. It expects the `JAVA_HOME` to be set. If it is not, then `jre_home` has to be set as an attribute. The usage is:
```
bitbucket_install 'bitbucket' do
  jre_home "#{node['java']['java_home']}/jre"
end
```
Below are the possible attributes:

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


#### `bitbucket_config`
This resource configures an already installed bitbucket. The configurations can be provided as a `Hash`. Below is the usage:
```
bitbucket_config 'bitbucket' do
  bitbucket_properties node['bitbucket']['properties']
end
```
or
```
bitbucket_config 'bitbucket' do
  bitbucket_properties {'setup.displayName' => 'aasdasd','setup.baseUrl' => 'http://localhost:7990'}
end
```

Below are the possible attributes:

| Property             | String | default                                                                      | required |
|----------------------|:------:|------------------------------------------------------------------------------|----------|
| product              | String | bitbucket                                                                    | false    |
| bitbucket_user       | String | atlbitbucket                                                                 | false    |
| bitbucket_group      | String | atlbitbucket                                                                 | false    |
| home_path            | String | /var/atlassian/application-data/bitbucket                                    | false    |
| bitbucket_properties | Hash   |                                                                              | true     |

To check the possible configurations to set in the Hash refer to *[Bitbucket Documentation](https://confluence.atlassian.com/bitbucketserver) > Administering Bitbucket Server > Bitbucket Server config properties*.
At the minimum it is useful to configure the setup properties mentioned in *[Bitbucket Documentation](https://confluence.atlassian.com/bitbucketserver) > Install or upgrade Bitbucket Server > Bitbucket Server installation guide > Automated setup for Bitbucket Server*.

#### `bitbucket_service`
This resource is used to create a systemd service config. It will `create`, `enable` and `start` the service. The name of the service is set by the property `product`. Below is the usage:

```
bitbucket_service 'bitbucket'
```

Below are the possible attributes:

| Property             | String | default                                                                      | required |
|----------------------|:------:|------------------------------------------------------------------------------|----------|
| product              | String | bitbucket                                                                    | false    |
| bitbucket_user       | String | atlbitbucket                                                                 | false    |
| install_path         | String | /opt/atlassian                                                               | false    |

## Testing
chef exec bundle install

To check rake tasks
```
chef exec bundle exec rake --tasks
```

Below runs rubocop & foodcritic
```
chef exec bundle exec rake style
```

For Integ test
```
rake integration:kitchen:default-centos-73
```

To directly use Kitchen
```
chef exec kitchen verify   default-centos-73
```
