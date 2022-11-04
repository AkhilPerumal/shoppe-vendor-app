import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class FileHelper {
  static getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  static double getFileSizeInMB(File file) {
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }

  // void compressWithImageCompress() async {
  //   await FlutterImageCompress.compressWithFile(
  //     imageFile!.absolute.path,
  //     minWidth : 320,
  //     minHeight: 240,
  //     quality: 90,
  //   )
  //     .then((response) {
  //       info2 = _ImageInfo.fromRaw(response!);
  //       imageCompressed = Image(
  //         image: MemoryImage(Uint8List.fromList(response)),
  //         fit: BoxFit.contain,
  //       );
  //     })
  //     .catchError((e) {
  //       imageCompressed = null;
  //       print(e);
  //     });
  // }
  // void getInfoFromRaw(Uint8List raw) async {
  //   var decodeImage = await decodeImageFromList(raw);
  //   width.value = decodeImage.width;
  //   height.value = decodeImage.height;
  //   var bytes = raw.lengthInBytes;
  //   sizeKB = bytes / 1024;
  //   sizeMB = sizeKB / 1024;
  //   setSize();
  //   headerBytes = raw.take(4).toList(); //raw.getRange(0, raw.indexOf(0)).toList();
  //   headerBytesHex.value = headerBytes.map((e) => e.toRadixString(16).toUpperCase()).join(' ');
  // }
}
