import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/feature/image_process/presentation/crop_dialog.dart';
import 'package:image_cropper/image_cropper.dart';

@immutable
final class CropperUiSettings {
  const CropperUiSettings._();
  static WebUiSettings getWebUiSettings({required BuildContext context}) {
    return WebUiSettings(
      context: context,
      background: true,
      center: true,
      zoomable: true,
      movable: true,
      customDialogBuilder: (cropper, initCropper, crop, rotate, scale) {
        return CropperDialog(
          cropper: cropper,
          initCropper: initCropper,
          crop: crop,
          rotate: rotate,
          scale: scale,
        );
      },
    );
  }
}
