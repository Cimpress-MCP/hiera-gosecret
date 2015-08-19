# Hiera-gosecret

[![Gem Version](https://badge.fury.io/rb/hiera-gosecret.svg)](http://badge.fury.io/rb/hiera-gosecret)

This hiera backend provides support for decrypting values that were encrypted using gosecret.
This plugin also installs gosecret CLI to be directly used via shell command. This provides full functionality of gosecret, including keygen and encryption.

## Notes

Version 0.3.0 of this gem supports gosecret 0.5.0, which is backwards compatible with the older tag syntax, and is therefore recommended to be used regardless of what version of gosecret was previously used.

To avoid inconsistency and incompatibility in OpenSSL versions from Ruby, the gosecret binaries are included and used in the gem for decryption.

## Support

This gem supports on linux_x64, windows, and darwin operating systems.
