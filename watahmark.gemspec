# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'watahmark/version'

Gem::Specification.new do |s|
  s.name        = 'watahmark'
  s.version     = Watahmark::VERSION
  s.date        = '2017-04-04'
  s.summary     = "Watermark and resize your photos."
  s.description = "A simple utility that downsizes your photos and watermaks them before public posting."
  s.authors     = ["Alexander Lockshyn"]
  s.email       = 'ld100@mourk.com'
  # s.files       = ["Rakefile", "lib/watahmark/photo_file.rb", "lib/watahmark/photo_processor.rb", "lib/watahmark/settings.rb"]
  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.homepage    =
    'http://rubygems.org/gems/watahmark'
  s.license       = 'MIT'
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if s.respond_to?(:metadata)
    s.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end
  s.bindir        = "bin"
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.14"
  s.add_development_dependency "rake", "~> 11.2"
  s.add_development_dependency "rspec", "~> 3.0"
end
