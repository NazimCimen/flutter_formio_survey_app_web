import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/feature/image_process/presentation/crop_dialog_mixin.dart';
import 'package:image_cropper/image_cropper.dart';

final class CropperDialog extends StatefulWidget {
  final Widget cropper;
  final void Function() initCropper;
  final Future<String?> Function() crop;
  final void Function(RotationAngle) rotate;
  final void Function(num) scale;

  const CropperDialog({
    required this.cropper,
    required this.initCropper,
    required this.crop,
    required this.rotate,
    required this.scale,
    super.key,
  });

  @override
  CropperDialogState createState() => CropperDialogState();
}

class CropperDialogState extends State<CropperDialog> with CropperDialogMixin {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      shape: const ContinuousRectangleBorder(),
      child: FractionallySizedBox(
        widthFactor: screenWidth > 600 ? 0.6 : 0.9,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Crop Your Image',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    IconButton(
                      onPressed: closeDialog,
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.05),
                SizedBox(
                  height: screenHeight * 0.6,
                  child: widget.cropper,
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () =>
                          widget.rotate(RotationAngle.counterClockwise90),
                      icon: const Icon(Icons.rotate_90_degrees_ccw_outlined),
                    ),
                    Expanded(
                      child: Slider(
                        inactiveColor: Theme.of(context).colorScheme.tertiary,
                        value: currentScale,
                        min: 1,
                        max: 2,
                        onChanged: (value) {
                          changeScaleSlider(value);
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () => widget.rotate(RotationAngle.clockwise90),
                      icon: const Icon(Icons.rotate_90_degrees_cw_outlined),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.05),
                Align(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.cut_outlined),
                    onPressed: cropImage,
                    label: Text(
                      'Crop',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
