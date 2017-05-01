'use strict';
const fs = require("fs");
const path = require("path");
const mime = require("mime-types");
const jimp = require("jimp");


/**
 * Class representing single report
 * Sequence of actions: Extract, Enrich, Normalize
 * @class
 **/
const OldWatermarker = (function() {

  /**
   * Constructor method
   * @constructor
   * @param {object} config - JSON representation configuration
   **/
  var Class = function(config) {
    this.config = config;
    this.finished = false;
    this.images = []
  };

  /**
   * Public method to process list of input files
   * @public
   **/
  Class.prototype.process = function() {
    analyze.call(this);
    const items = unprocessed.call(this);
    items.forEach(function(image) {
      // Process the image
      image.watermarkText = this.config.watermarkText;
      image.targetLength = this.config.targetLength;
      image.markWidth = this.config.markWidth;
      image.markHeight = this.config.markHeight;
      transform.call(this, image);
    }.bind(this));
  };


  /**
   * Analyze input directory, build a list of files to manipulate
   *
   * @private
   **/
  function analyze() {
    const items = fs.readdirSync(this.config.inputDir);
    for (var i = 0; i < items.length; i++) {
      // We are working just with JPEG images
      if ("image/jpeg" == mime.lookup(items[i])) {
        const inputPath = path.join(this.config.inputDir, items[i]);
        const fileName = path.basename(inputPath);
        const outputPath = path.join(this.config.outputDir, this.config.outputSuffix.concat(fileName));
        const imageItem = {
          filename: fileName,
          inputPath: inputPath,
          outputPath: outputPath,
          processed: false
        }
        this.images.push(imageItem);
      }
    }
  }

  /**
   * Provide queue of unprocessed files
   *
   * @private
   **/
  function unprocessed() {
    let result = this.images.map(function(item) {
      if (item.processed == false) {
        return item;
      }
    });
    // Filter out undefined values
    return result.filter(function(e){return e});
  }

  /**
   * Provide queue of processed files
   *
   * @private
   **/
  function processed() {
    let result = this.images.map(function(item) {
      if (item.processed == true) {
        return item;
      }
    });
    // Filter out undefined values
    return result.filter(function(e){return e});
  }

  /**
   * Transform selected image, e.g. resize and watermark
   * @TODO: Move this functionality to separate class
   * @param {object} image - JSON representation of image
   *
   * @private
   **/
  function transform(item) {
    const watermark = new jimp(item.markWidth, item.markHeight, 0x00000080, function(err, mark) {
      jimp.loadFont(jimp.FONT_SANS_16_WHITE).then(function(font) {
        mark.print(font, 10, 1, item.watermarkText);
        jimp.read(item.inputPath).then(function(image) {
          let imageWidth = item.targetLength;
          let imageHeight = item.targetLength;
          if (image.bitmap.width > image.bitmap.height) {
            imageHeight = jimp.AUTO;
          } else {
            imageWidth = jimp.AUTO;
          }
          image.resize(imageWidth, imageHeight)
            .composite(mark, image.bitmap.width - item.markWidth, image.bitmap.height - item.markHeight)
            .write(item.outputPath);
        }).catch(function(err) {
          console.error(err);
        });
      });
    });
    item.processed = true;
  }

  return Class;
})();

const cfg = {
  inputDir: "./input",
  outputDir: "./output",
  watermarkText: " © Alexander Lockshyn | http://lab37.com",
  targetLength: 1200,
  markWidth: 300,
  markHeight: 20,
  outputSuffix: "_"
}
const wm = new Watermarker(cfg);
wm.process()
