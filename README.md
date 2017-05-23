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
bitbucket_install 'bitbucket'
```
Below are the possible attributes:
|Property       |String|default                                                                      |
|:-------------:|:----:|-----------------------------------------------------------------------------|
|product        |String|bitbucket                                                                    |
|version        |String|5.0.1                                                                        |
|bitbucket_user |String|atlbitbucket                                                                 |
|bitbucket_group|String|atlbitbucket                                                                 |
|home_path      |String|/var/atlassian/application-data/bitbucket                                    |
|install_path   |String|/opt/atlassian                                                               |
|checksum       |String|677528dffb770fab9ac24a2056ef7be0fc41e45d23fc2b1d62f04648bfa07fad             |
|url_base       |String|http://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket |
|jre_home       |String|                                                                             |


#### `bitbucket_config`
#### `bitbucket_service`


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
