# encoding: UTF-8

require "rubygems"
require "bundler/setup"
require "settingslogic"

module Watahmark
  class Settings < Settingslogic
    local_conf = File.join(Dir.pwd, "config", "watahmark.yml")
    if File.exists?(local_conf)
      source local_conf
    else
      conf_dir = File.join(File.expand_path("..", File.dirname(File.dirname(__FILE__))), "config")
      source File.join(conf_dir, "app.yml")
    end
    namespace ENV["APP_ENV"] || "production"
  end
end
