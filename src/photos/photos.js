'use strict';

const {
  dialog
} = require("electron").remote;
const fs = require("fs");
import {
  Watermarker
} from "./watermarker";

export class PhotoDialog {
  constructor() {
    this.inputPath = null;
    this.outputPath = null;

    this.dirProps = {
      properties: ['openDirectory']
    };
    this.openInputFolder = this.openInputFolder.bind(this);
    this.openOutputFolder = this.openOutputFolder.bind(this);
    this.isValid = this.isValid.bind(this);
    this.processPhotos = this.processPhotos.bind(this);
  }

  // openInputFolder = () => {
  openInputFolder() {
    dialog.showOpenDialog(this.dirProps, function (fileNames) {
      if (fileNames === undefined) return;
      this.inputPath = fileNames[0];
    }.bind(this));
  }

  openOutputFolder() {
    dialog.showOpenDialog(this.dirProps, function (fileNames) {
      if (fileNames === undefined) return;
      this.outputPath = fileNames[0];
    }.bind(this));
  }

  isValid() {
    if (this.inputPath && this.outputPath) {
      if (this.inputPath != this.outputPath) {
        return true;
      }
    }
    return false;
  }

  processPhotos() {
    if (this.isValid()) {
      alert("Woohoo, lets process da fotazz!");
      const cfg = {
        inputDir: this.inputPath,
        outputDir: this.outputPath,
        watermarkText: " © Alexander Lockshyn | http://lab37.com",
        targetLength: 1200,
        markWidth: 300,
        markHeight: 20,
        outputSuffix: "_"
      };
      const wm = new Watermarker(cfg);
      wm.process();
      alert("Processing Complete");
    } else {
      alert("DA FUCK?");
    }
  }

  renderBody() {
    let content = "";
    const inputFolderHTML = '<button id="inputFolder">Open Input Folder</button>';
    const outputFolderHTML = '<button id="outputFolder">Open Output Folder</button>';
    const separator = "<br />\n";
    const processHTML = '<button id="process">Process Photos</button>';
    content = content.concat(inputFolderHTML, separator, outputFolderHTML, separator, processHTML);
    return content;
  }
};
