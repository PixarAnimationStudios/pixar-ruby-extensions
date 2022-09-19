proj_name = 'pixar-ruby-extensions'
proj_dir = 'pixar_ruby_extensions'
require "./lib/#{proj_dir}/version"

Gem::Specification.new do |s|
  # General

  s.name        = proj_name
  s.version     = PixarRubyExtensions::VERSION
  s.license     = 'Nonstandard'
  s.date        = Time.now.utc.strftime('%Y-%m-%d')
  s.summary     = "Extensions to Ruby Core and Ctandard libraries used in Pixar's ruby projects"
  s.description = <<~EOD
    This gem contans extensions to the Ruby core and standard libraries which have been used in many
    Pixar projects over the years.
  EOD
  s.authors     = ['Chris Lasell']
  s.email       = 'chrisl@pixar.com'
  s.files       = Dir['lib/**/*.rb']

  # Ruby version
  s.required_ruby_version = '>= 2.6.3'

  s.extra_rdoc_files = ['README.md', 'LICENSE.txt']
end
