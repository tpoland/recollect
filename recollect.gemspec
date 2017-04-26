Gem::Specification.new do |s|
  s.name = 'recollect'
  s.version = ::Recollect::VERSION
  s.authors = ['Tyler Poland']
  s.email = 'recollect@tylerpoland.com'
  s.homepage = 'http://github.com/tpoland/recollect'
  s.summary = "Storage, Management and Retrieval of things you'd like to remember (recollect)."
  s.description = s.summary
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '~> 2.4'
  # s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to?(:required_rubygems_version=)
  s.has_rdoc = true
  s.extra_rdoc_files = %w[LICENSE TODO]
  s.files = %w[LICENSE README.md Rakefile TODO] + Dir.glob('lib/**/*')
  # s.test_files = Dir.glob("spec/**/*")
  s.bindir = 'bin'
  s.executables = %w[recollect]
  s.default_executable = 'recollect'
  s.files = `git ls-files`.split('\n')
end
