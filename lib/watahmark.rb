require 'watahmark/version'
require 'watahmark/settings'
require 'watahmark/photo_processor'
require 'fileutils'

module Watahmark
  class Watahmark
    attr_accessor :target_dir

    def initialize (source_dir, destination_dir, watermark_text)
      @source_dir = source_dir || Settings.source_dir
      @destination_dir = destination_dir || Settings.destination_dir
      @watermark_text = watermark_text || Settings.watermark_text
      @processor = PhotoProcessor.new

      @processor.source = @source_dir
      @processor.destination = @destination_dir
      @processor.watermark_text = @watermark_text
    end

    def process
      puts "Processing photos..."
      @processor.process
      puts "Done."
    end

    def prepare_dir
      puts "Preparing directory for watahmark..."
      target_dir = @target_dir || Dir.pwd
      config_path = File.join(target_dir, "config")
      source_path = File.join(target_dir, "source")
      destination_path = File.join(target_dir, "destination")

      Dir.mkdir(target_dir) unless File.exists?(target_dir)
      Dir.mkdir(config_path) unless File.exists?(config_path)
      Dir.mkdir(source_path) unless File.exists?(source_path)
      Dir.mkdir(destination_path) unless File.exists?(destination_path)

      sample_config_path = File.expand_path('../config/watahmark_example.yml', File.dirname(__FILE__))
      FileUtils.cp(sample_config_path, config_path)
      File.rename(File.join(config_path, "watahmark_example.yml"), File.join(config_path, "watahmark.yml"))
      puts "Done."
    end
  end
end
