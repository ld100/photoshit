#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'

require File.expand_path(File.dirname(__FILE__) + '/settings')
require File.expand_path(File.dirname(__FILE__) + '/photo_processor')

pp = PhotoProcessor.new
pp.source = $source
pp.destination = $destination
pp.watermark_text = $watermark_text
pp.process
