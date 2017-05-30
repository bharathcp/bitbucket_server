# tomcat Cookbook CHANGELOG

This file is used to list changes made in each version of the tomcat cookbook.

## 0.1.4 (2017-05-30)

- Corrected documentation - Readme.md
- Added matchers for the custom resources - `bitbucket_server_install`, `bitbucket_server_config`, `bitbucket_server_service` in library.
- fixed idempotence for `directory` and `template` resources in `bitbucket_server_install`, `bitbucket_server_config`.
- Any changed to `bitbucket_server_install`, `bitbucket_server_config` will notify restart of bitbucket service if it exists.

## 0.1.3 (2017-05-24)

- First release with 3 resources: `bitbucket_server_install`, `bitbucket_server_config`, `bitbucket_server_service`