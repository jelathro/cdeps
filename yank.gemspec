Gem::Specification.new do |s|
	s.name        = 'yank'
	s.version     = '1.0.0'
	s.description = 'Dependency manager'
	s.authors     = ['Justin Lathrop']
	s.files       = Dir['lib/**/*']
	s.bindir      = 'bin'
	s.homepage    = 'https://github.com/jelathro/yank'
	
	spec.add_runtime_dependency 'kwalify', '~> 0.7.2'
end
