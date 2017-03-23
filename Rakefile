require 'rubygems'
require 'bundler/setup'

task default: %w[process]

# task :process do
#     ruby "launcher.rb"
# end

task :process do
    require_relative 'lib/watahmark.rb'

    source_dir = ENV['source_dir']
    destination_dir = ENV['destination_dir']
    watermark_text = ENV['watermark_text']

    watahmark = Watahmark.new(source_dir, destination_dir, watermark_text)
    watahmark.process
end

task :cleanup do
    puts "Cleaning up `Destination` directory..."
    FileUtils.rm_rf(Dir.glob('./destination/*'))
    puts "Done."
end
