import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/core/error/failure.dart';
import 'package:flutter_survey_app_web/feature/image_process/domain/repository/image_process_repository.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CropImageUseCase {
  final ImageProcessRepository repository;
  CropImageUseCase({required this.repository});
  Future<Either<Failure, XFile?>> call({
    required XFile imageFile,
    required CropAspectRatio cropRatio,
    required BuildContext context,
  }) async {
    return repository.cropImage(
        imageFile: imageFile, cropRatio: cropRatio, context: context);
  }
}
