import 'package:image_cropper/image_cropper.dart';

enum ImageAspectRatioEnum {
  surveyImage,
  questionImage,
}

extension CropImageAspectRatioExtension on ImageAspectRatioEnum {
  CropAspectRatio get ratioCrop {
    switch (this) {
      case ImageAspectRatioEnum.surveyImage:
        return const CropAspectRatio(ratioX: 5, ratioY: 4);
      case ImageAspectRatioEnum.questionImage:
        return const CropAspectRatio(ratioX: 16, ratioY: 9);
    }
  }

  double get ratio {
    switch (this) {
      case ImageAspectRatioEnum.surveyImage:
        return 5 / 4;
      case ImageAspectRatioEnum.questionImage:
        return 16 / 9;
    }
  }
}
