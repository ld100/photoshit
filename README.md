# Photo Shit Application

Resizes and watermarks photos for public access

## Prerequisites

* ImageMagick
* GhostScript

`brew install ghostscript imagemagick graphicsmagick`
`bundle install`

## Running the Application

Process photos in Source directory:

`rake process`


Clean up Destination directory:

`rake cleanup`
