require File.expand_path("lib/hdh/version", __DIR__)

Gem::Specification.new do |s|
  s.name        = 'hdh'
  s.version     = Hdh::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = '2019-05-05'
  s.summary     = 'Render plain data into HTML'
  s.description = <<-DESCRIPTION
    HTML is Data is HTML
  DESCRIPTION
  s.authors     = ['Artur Malabarba']
  s.email       = 'artur@endlessparentheses.com'
  s.files       = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.homepage    = 'http://rubygems.org/gems/hdh'
  s.license     = 'MIT'
end
