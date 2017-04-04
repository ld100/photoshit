require "watahmark/photo"

module Watahmark
  class PhotoProcessor
    attr_accessor :source
    attr_accessor :destination
    attr_accessor :watermark_text
    attr_accessor :length

    def process
      source_dir = Dir.new(@source)
      source_dir.each do |filename|
        if ".jpg" == File.extname(filename)
          source_path = File.join(@source, filename)
          destination_path = File.join(@destination, "_" + filename)
          if "jpg" == self.get_image_extension(source_path)
            p = Photo.new(source_path, destination_path, @watermark_text)
            p.process
            puts "#{source_path} -> #{destination_path}"
          else
            puts "WTF? Only JPEG files are allowed"
          end
        end
      end
    end

    protected
      def get_image_extension(local_file_path)
        png = Regexp.new("\x89PNG".force_encoding("binary"))
        jpg = Regexp.new("\xff\xd8\xff\xe0\x00\x10JFIF".force_encoding("binary"))
        jpg2 = Regexp.new("\xff\xd8\xff\xe1(.*){2}Exif".force_encoding("binary"))
        case IO.read(local_file_path, 10)
        when /^GIF8/
          'gif'
        when /^#{png}/
          'png'
        when /^#{jpg}/
          'jpg'
        when /^#{jpg2}/
          'jpg'
        else
          mime_type = `file #{local_file_path} --mime-type`.gsub("\n", '') # Works on linux and mac
          raise UnprocessableEntity, "unknown file type" if !mime_type
          mime_type.split(':')[1].split('/')[1].gsub('x-', '').gsub(/jpeg/, 'jpg').gsub(/text/, 'txt').gsub(/x-/, '')
      end
    end
  end
end
