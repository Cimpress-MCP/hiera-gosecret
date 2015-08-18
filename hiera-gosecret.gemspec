# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'hiera/backend/gosecret/version'

Gem::Specification.new do |gem|
  gem.name        = "hiera-gosecret"
  gem.version     = Hiera::Backend::Gosecret::VERSION
  gem.executables = ['gosecret']
  gem.description = "Hiera backend for decrypting gosecret-encrypted values"
  gem.summary     = "Hiera gosecret backend"
  gem.author      = "Calvin Leung Huang"
  gem.email       = ["cleung2010@gmail.com"]
  gem.license     = "Apache 2.0"
  gem.homepage    = "http://github.com/Cimpress-MCP/hiera-gosecret"
  gem.files       = Dir['lib/**/*', 'bin/*', 'LICENSE']
end
