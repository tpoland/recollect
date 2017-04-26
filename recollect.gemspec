$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'recollect/version'

Gem::Specification.new do |s|
  s.name = 'recollect'
  s.version = Recollect::VERSION
  s.authors = ['Tyler Poland']
  s.email = 'recollect@tylerpoland.com'
  s.homepage = 'http://github.com/tpoland/recollect'
  s.summary = "Storage, Management and Retrieval of things you'd like to remember (recollect)."
  s.description = s.summary
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '~> 1.9'
  s.has_rdoc = true
  s.extra_rdoc_files = %w[LICENSE TODO]
  s.bindir = 'bin'
  s.executables = %w[recollect]
  s.default_executable = 'recollect'
  s.files = `git ls-files`.split("\n")
end
