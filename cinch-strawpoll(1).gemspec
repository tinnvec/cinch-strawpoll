# coding: utf-8
# file: cinch-strawpoll.gemspec

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cinch/plugins/strawpoll/version'

Gem::Specification.new do |spec|
    spec.name          = 'cinch-strawpoll'
    spec.version       = Cinch::Plugins::Strawpoll::VERSION
    spec.authors       = ['Alex Hanna']
    spec.email         = ['tinnvec@gmail.com']
    spec.description   = 'A Strawpoll plugin for Cinch.'
    spec.summary       = 'A Cinch plugin for creating polls on http://strawpoll.me'
    spec.homepage      = 'https://github.com/tinnvec/cinch-strawpoll'
    spec.license       = 'MIT'

    spec.files         = `git ls-files`.split("\n")
    spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
    spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
    spec.require_paths = ['lib']

    # Gem dependencies
    spec.add_dependency 'cinch', '~> 2.3.1', '>= 2.3.1'
    spec.add_dependency 'cinch-authentication', '~> 0.1.1'
    spec.add_dependency 'httparty', '~> 0.13.7'
    spec.add_dependency 'json', '~> 1.8.3',  '>= 1.8.3'

    # Development dependencies
    spec.add_development_dependency 'bundler', '~> 1.3'
    spec.add_development_dependency 'rake', '~> 0'
end
