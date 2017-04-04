$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "watahmark"
require "watahmark/photo"

RSpec.describe "Watahmark" do
  it "Should work" do
    source_location = "source/IMG_8958.jpg"
    destination_location = "destination/_IMG_8958.jpg"
    watermark_text = "© Alexander Lockshyn | emotionalphoto.com"

    img = Photo.new(source_location, destination_location, watermark_text, 1200)
    img.process
    puts "ok"
  end
end
