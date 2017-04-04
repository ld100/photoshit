# Watahmark

Resizes and watermarks photos for public access

## Prerequisites

* ImageMagick
* GhostScript (Mac Only)

On Mac:

`brew install ghostscript imagemagick`
`bundle install`

On Linux:

`sudo apt-get install imagemagick`
`bundle install`

## Running the Application

Set up initial folders for photos and watermark configuration

`bin/watermark -i [TARGET_FOLDER]`

Process photos in Source directory:

`bin/watermark -p`


Clean up Destination directory:

`rake cleanup`
