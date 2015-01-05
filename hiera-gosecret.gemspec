# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name         = "hiera-gosecret"
  gem.version      = "0.1.0"
  gem.executables << "gosecret"
  gem.description  = "Hiera backend for decrypting gosecret-encrypted values"
  gem.summary      = "Hiera gosecret backend"
  gem.author       = "Calvin Leung Huang"
  gem.license      = "Apache 2.0"
  gem.homepage     = "http://github.com/Cimpress-MCP/hiera-gosecret"
  gem.files        = Dir['lib/**/*'] + ['LICENSE']
end
