import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BitmapDescriptorHelper {
  static Future<BitmapDescriptor> getBitmapDescriptorFromSvgAsset(
      BuildContext context, String svgAssetLink) async {
    final svgImage = await _getSvgImageFromAssets(context, svgAssetLink);
    final sizedSvgImage = await _getSizedSvgImage(svgImage);

    final pngSizedBytes =
        await sizedSvgImage.toByteData(format: ui.ImageByteFormat.png);
    final unit8List = pngSizedBytes?.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(unit8List!);
  }

  static Future<BitmapDescriptor> getBitmapDescriptorFromSvgString(
      String svgString) async {
    final svgImage = await _getSvgImageFromString(svgString);
    final sizedSvgImage = await _getSizedSvgImage(svgImage);

    final pngSizedBytes =
        await sizedSvgImage.toByteData(format: ui.ImageByteFormat.png);
    final unit8List = pngSizedBytes?.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(unit8List!);
  }

  static Future<ui.Image> _getSvgImageFromAssets(
      BuildContext context, String svgAssertLink) async {
    String svgString =
        await DefaultAssetBundle.of(context).loadString(svgAssertLink);
    DrawableRoot drawableRoot =
        svg.fromSvgString(svgString, "") as DrawableRoot;
    ui.Picture picture = drawableRoot.toPicture();
    ui.Image image = await picture.toImage(drawableRoot.viewport.width.toInt(),
        drawableRoot.viewport.height.toInt());
    return image;
  }

  static Future<ui.Image> _getSvgImageFromString(String svgString) async {
    DrawableRoot drawableRoot =
        svg.fromSvgString(svgString, "") as DrawableRoot;
    ui.Picture picture = drawableRoot.toPicture();
    ui.Image image = await picture.toImage(drawableRoot.viewport.width.toInt(),
        drawableRoot.viewport.height.toInt());
    return image;
  }

  static Future<ui.Image> _getSizedSvgImage(ui.Image svgImage) async {
    final size = 50 * ui.window.devicePixelRatio;
    final width = size;
    final height = width;

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Rect svgRect = Rect.fromLTRB(
        0.0, 0.0, svgImage.width.toDouble(), svgImage.height.toDouble());
    final Rect sizedRect = Rect.fromLTRB(
        0.0, 0.0, width.toDouble(), height.toDouble()); // owr size here
    canvas.drawImageRect(svgImage, svgRect, sizedRect, Paint());
    return await pictureRecorder
        .endRecording()
        .toImage(width.toInt(), height.toInt());
  }
}
