# encoding: UTF-8

require "rubygems"
require "bundler/setup"
require "settingslogic"

class Settings < Settingslogic
  source File.join(File.expand_path("./", Dir.pwd), "config", "app.yml")
  namespace ENV["APP_ENV"] || "production"
end
