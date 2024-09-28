import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/core/error/failure.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImageProcessRepository {
  Future<Either<Failure, XFile?>> getImage({required ImageSource source});
  Future<Either<Failure, XFile?>> cropImage({
    required XFile imageFile,
    required CropAspectRatio cropRatio,
    required BuildContext context,
  });
  Future<Either<Failure, String>> getImageUrl({
    required Uint8List imageBytes,
    required String path,
  });
  Future<Either<Failure, bool>> removeSurveyImages({required String path});
}
