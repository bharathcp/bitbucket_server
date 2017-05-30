# bitbucket server Cookbook CHANGELOG

This file is used to list changes made in each version of the bitbucket server cookbook.

## 0.1.4 (2017-05-30)

- Corrected documentation - Readme.md (fixes [#12](/bharathcp/bitbucket_server/issues/12))
- Added matchers for the custom resources - `bitbucket_server_install`, `bitbucket_server_config`, `bitbucket_server_service` in library. (fixes [#11](/bharathcp/bitbucket_server/issues/11))
- fixed idempotence for `directory` and `template` resources in `bitbucket_server_install`, `bitbucket_server_config`. (fixes [#19](/bharathcp/bitbucket_server/issues/19))
- Any changed to `bitbucket_server_install`, `bitbucket_server_config` will notify restart of bitbucket service if it exists. (fixes [#17](/bharathcp/bitbucket_server/issues/17))

## 0.1.3 (2017-05-24)

- First release with 3 resources: `bitbucket_server_install`, `bitbucket_server_config`, `bitbucket_server_service`