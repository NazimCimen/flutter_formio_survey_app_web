import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_web/feature/image_process/presentation/crop_dialog.dart';

mixin CropperDialogMixin on State<CropperDialog> {
  double currentScale = 1;

  @override
  void initState() {
    super.initState();
    widget.initCropper();
  }

  void closeDialog() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        NavigatorService.goBack();
      },
    );
  }

  Future<void> cropImage() async {
    final result = await widget.crop();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Navigator.of(context).pop(result);
      },
    );
  }

  void changeScaleSlider(double value) {
    setState(() {
      currentScale = value;
    });
    widget.scale(currentScale);
  }
}
