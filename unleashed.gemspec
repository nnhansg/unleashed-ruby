lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'unleashed/version'

Gem::Specification.new do |spec|
  spec.name          = 'unleashed'
  spec.version       = Unleashed::Version::STRING
  spec.authors       = ['Nhan Nguyen']
  spec.email         = ['nnhansg@gmail.com']

  spec.summary       = 'Ruby gem for invoking Unleashedsoftware RESTful API https://apidocs.unleashedsoftware.com'
  spec.description   = 'Ruby gem for invoking Unleashedsoftware RESTful API https://apidocs.unleashedsoftware.com'
  spec.homepage      = 'https://github.com/nnhansg/unleashed-ruby'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/nnhansg/unleashed-ruby/src/master/'
  spec.metadata['changelog_uri'] = 'https://github.com/nnhansg/unleashed-ruby/src/master/CHANGELOG.md'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/nnhansg/unleashed-ruby/issues'

  spec.required_ruby_version = '>= 2.5.0'
  spec.requirements << 'ruby >= 2.5.0'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '>= 0'
  spec.add_dependency 'json', '>= 0'
  spec.add_development_dependency 'bundler', '~> 1.16', '>= 1.16.1'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
