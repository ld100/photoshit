require 'rubygems'
require 'bundler/setup'

task default: %w[process]

# task :process do
#     ruby "launcher.rb"
# end

task :process do
    require File.expand_path(File.dirname(__FILE__) + '/settings')
    require File.expand_path(File.dirname(__FILE__) + '/photo_processor')

    pp = PhotoProcessor.new
    pp.source = $source
    pp.destination = $destination
    pp.watermark_text = $watermark_text
    puts "Processing photos..."
    pp.process
    puts "Done."
end

task :cleanup do
    puts "Cleaning up `Destination` directory..."
    FileUtils.rm_rf(Dir.glob('./destination/*'))
    puts "Done."
end
