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

*Note: We intend to remove java and git dependancies from this cook book in future.*

## Bitbucket version
This cookbook only supports bitbucket server versions of 5.0.0 and above

## Usage
This is a library cookbook. You can use the resources it provides in your wrapper cookbook / recipe.

### Custom resources
#### `bitbucket_install`
This resource installs a bitbucket server and sets the `BITBUCKET_HOME`. It expects the `JAVA_HOME` to be set. If it is not, then `jre_home` has to be set as an attribute. The usage is:
```
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

Below are the attributes supported by this resource:

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

Below are the attributes supported by this resource:

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

To execute lynt and unit tests
```
chef exec bundle exec rake style
```

To execute Integration tests
```
rake integration:kitchen:default-centos-73
```

To directly use Kitchen
```
chef exec kitchen verify   default-centos-73
```

##License and Author

Author: Bharath Prakash (cippy.bharath@gmail.com)
Author: Raghavendra Gona (graghav@gmail.com)

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

```
http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
```