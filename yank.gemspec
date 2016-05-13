Gem::Specification.new do |s|
	s.name          = 'yank'
	s.version       = '1.1.0'
	s.description   = 'Dependency manager'
	s.authors       = ['Justin Lathrop']
	s.email         = 'jelathrop@gmail.com'
	s.homepage      = 'https://github.com/jelathro/yank'
	s.summary       = 'Generic dependency management for popular version control systems'
	
	s.files         = Dir['bin/*', 'lib/**/*']
	s.executables   = ['yank']
	s.require_paths = ['lib']
	s.add_runtime_dependency 'kwalify', '~> 0.7.2'
	s.add_dependency 'nexus_client', '~> 0.3.0'
end
