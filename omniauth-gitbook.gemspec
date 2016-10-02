# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gitbook/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Calvin Huang"]
  gem.email         = ["calvin.peak@capslock.tw"]
  gem.description   = %q{Gitbook Oauth2 strategy for Omniauth.}
  gem.summary       = %q{Gitbook Oauth2 strategy for Omniauth.}
  gem.homepage      = "https://github.com/Calvin-Huang/omniauth-gitbook"
  gem.license       = "MIT"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-gitbook"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::GitHub::VERSION

  gem.add_dependency 'omniauth', '~> 1.0'
  # Nothing lower than omniauth-oauth2 1.1.1
  # http://www.rubysec.com/advisories/CVE-2012-6134/
  gem.add_dependency 'omniauth-oauth2', '>= 1.1.1', '< 2.0'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end
