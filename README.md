# Chef Cookbook for installing standalone bitbucket server on Linux 

## Get started 
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

