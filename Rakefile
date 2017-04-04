require "rubygems"
require "bundler/setup"
require "bundler/gem_tasks"

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'watahmark'

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  puts "WAT?"
end

task default: %w[process]

task :process do
    source_dir = ENV["source_dir"]
    destination_dir = ENV["destination_dir"]
    watermark_text = ENV["watermark_text"]

    watahmark = Watahmark::Watahmark.new(source_dir, destination_dir, watermark_text)
    watahmark.process
end

task :cleanup do
    puts "Cleaning up `Destination` directory..."
    FileUtils.rm_rf(Dir.glob('./destination/*'))
    puts "Done."
end
