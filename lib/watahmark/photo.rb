# encoding: UTF-8
require "rubygems"
require "mini_magick"
# MiniMagick.logger.level = Logger::DEBUG

class Photo
  # TODO: Get length from external config
  def initialize(source_path, destination_path, watermark_text, length=1200)
    @source_path = source_path
    @destination_path = destination_path
    @watermark = watermark_text
    @length = length

    @image = MiniMagick::Image.open(@source_path)
  end

  def process
    self.resize
    self.put_watermark
    self.save_copy
  end

  def resizable?
    return true if (@length <= @image.width) && (@length < @image.height)
    return false
  end

  protected
  def resize
    @image.resize "#{@length}x#{@length}" if self.resizable?
  end

  # TODO: Fetch watermark settings from external config
  # instead of hardcoding them here
  def put_watermark
    watermark_background_width = (@watermark.size*11*0.96).to_i
    watermark_background_height = 30
    top_x = @image.width - watermark_background_width
    top_y = @image.height - watermark_background_height
    bottom_x = @image.width
    bottom_y = @image.height

    @image.combine_options do |c|
      c.stroke "transparent"
      c.strokewidth "1"
      c.fill "rgba(0, 0, 0 , 0.5) fill-opacity 0.6"
      c.draw "fill-opacity 0.6 rectangle #{top_x},#{top_y} #{bottom_x},#{bottom_y}"
    end

    @image.combine_options do |c|
      c.gravity "SouthEast"
      c.pointsize "20"
      c.font "Tahoma"
      c.draw "text 7,7 '#{@watermark}'"
      c.fill "#efefef"
      c.draw "text 6,6 '#{@watermark}'"
      c.fill "gray"
    end
  end

  def save_copy
    @image.write(@destination_path)
  end

end
