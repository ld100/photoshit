require_relative 'watahmark/settings'
require_relative 'watahmark/photo_processor'

class Watahmark
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
end
