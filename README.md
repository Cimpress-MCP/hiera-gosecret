# Hiera-gosecret

[![Gem Version](https://badge.fury.io/rb/hiera-gosecret.svg)](http://badge.fury.io/rb/hiera-gosecret)

This hiera backend provides support for decrypting values that were encrypted using gosecret.
This plugin also installs gosecret-cli to be directly used via shell command. This provides full functionality of gosecret, including encryption.

## Notes

To avoid inconsistency and incompatibility in OpenSSL versions from Ruby, the gosecret binaries are included and used in the gem for decryption.

## Support

It is only currently supported on linux_x64 and windows systems, since these are the only binaries present in the gem at the moment.
