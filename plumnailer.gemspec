# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'plumnailer'
  s.version = '0.1.2'
  s.summary = 'Choose the most representative image on an HTML page for use as a thumbnail'
  s.description = s.summary
  s.homepage = 'https://github.com/mmb/plumnailer'
  s.authors = ['Matthew M. Boedicker']
  s.email = %w{matthewm@boedicker.org}
  s.license = 'MIT'

  %w{
    net-http-persistent > 0
    nokogiri > 0
    rmagick > 0
    }.each_slice(3) { |g,o,v| s.add_dependency(g, "#{o} #{v}") }

  %w{
    sinatra > 0
    }.each_slice(3) { |g,o,v| s.add_development_dependency(g, "#{o} #{v}") }

  s.files = `git ls-files`.split("\n")
end
