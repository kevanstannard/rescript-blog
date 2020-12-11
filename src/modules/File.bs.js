// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Fs = require("fs");
var Glob = require("glob");

function readFile(filePath) {
  return new Promise((function (resolve, reject) {
                var onRead = function (error, content) {
                  if (error == null) {
                    if (content == null) {
                      return reject({
                                  RE_EXN_ID: "Failure",
                                  _1: "Error reading file " + filePath + " (returned null)"
                                });
                    } else {
                      return resolve(content);
                    }
                  } else {
                    return reject({
                                RE_EXN_ID: "Failure",
                                _1: "Error reading file " + filePath
                              });
                  }
                };
                Fs.readFile(filePath, "utf-8", onRead);
                
              }));
}

function writeFile(filePath, content) {
  return new Promise((function (resolve, reject) {
                Fs.writeFile(filePath, content, (function (error) {
                        if (error == null) {
                          return resolve(undefined);
                        } else {
                          return reject({
                                      RE_EXN_ID: "Failure",
                                      _1: "Error writing file " + filePath
                                    });
                        }
                      }));
                
              }));
}

function readMarkdownFilePaths(dirPath) {
  return new Promise((function (resolve, reject) {
                Glob(dirPath + "/*.md", (function (error, paths) {
                        if (error == null) {
                          return resolve(paths);
                        } else {
                          return reject({
                                      RE_EXN_ID: "Failure",
                                      _1: "Error reading directory: " + dirPath
                                    });
                        }
                      }));
                
              }));
}

exports.readFile = readFile;
exports.writeFile = writeFile;
exports.readMarkdownFilePaths = readMarkdownFilePaths;
/* fs Not a pure module */