require_relative 'lib/crazy_train/version'

Gem::Specification.new do |spec|
  spec.name        = 'crazy_train'
  spec.version     = CrazyTrain::VERSION
  spec.authors     = ['Masaki Komagata']
  spec.email       = ['komagata@gmail.com']
  spec.homepage    = 'https://github.com/komagata/crazy_train'
  spec.summary     = 'Provides a RESTful API into your rails apps.'
  spec.description = 'Provides a RESTful API for database tables into your rails apps.'

  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/komagata/crazy_train'
  spec.metadata['changelog_uri'] = 'https://github.com/komagata/crazy_train/CHANGELOG.md'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.add_dependency 'api_error_handler', '~> 0.2.1'
  spec.add_dependency 'jwt', '~> 2.2', '>= 2.2.1'
  spec.add_dependency 'rails', '>= 6.0.0'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
