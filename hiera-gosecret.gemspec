# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name         = "hiera-gosecret"
  gem.version      = "0.2.4"
  gem.executables << "gosecret" << "gosecret-linux-x64" << "gosecret-win-x64.exe"
  gem.description  = "Hiera backend for decrypting gosecret-encrypted values"
  gem.summary      = "Hiera gosecret backend"
  gem.author       = "Calvin Leung Huang"
  gem.license      = "Apache 2.0"
  gem.homepage     = "http://github.com/Cimpress-MCP/hiera-gosecret"
  gem.files        = Dir['lib/**/*'] + ['LICENSE']
end
