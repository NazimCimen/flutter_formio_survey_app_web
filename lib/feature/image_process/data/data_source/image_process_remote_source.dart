import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_survey_app_web/core/error/failure.dart';
import 'package:flutter_survey_app_web/core/error/failure_handler.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/data/model/question_model.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/data/model/survey_model.dart';
import 'package:flutter_survey_app_web/product/firebase/firebase_collection_enum.dart';
import 'package:flutter_survey_app_web/product/firebase/firebase_converter.dart';

abstract class ImageProcessRemoteSource {
  Future<Either<Failure, String>> getImageUrl({
    required Uint8List imageBytes,
    required String path,
  });

  Future<Either<Failure, bool>> removeSurveyImages({
    required String path,
  });
}

class ImageProcessRemoteSourceImpl extends ImageProcessRemoteSource {
  final FirebaseStorage storage;

  ImageProcessRemoteSourceImpl({
    required this.storage,
  });
  @override

  /// nulll check
  Future<Either<Failure, String>> getImageUrl({
    required Uint8List imageBytes,
    required String path,
  }) async {
    try {
      final storageRef = storage.ref();
      final uniqueFileName =
          '$path${DateTime.now().millisecondsSinceEpoch}.png';
      final imageRef = storageRef.child(uniqueFileName);
      await imageRef.putData(imageBytes);
      final urlPath = await imageRef.getDownloadURL();
      return Right(urlPath);
    } catch (e) {
      return Left(FailureHandler.handleFailure(e: e));
    }
  }

  @override
  Future<Either<Failure, bool>> removeSurveyImages({
    required String path,
  }) async {
    try {
      final listResult = await storage.ref(path).listAll();

      for (final ref in listResult.items) {
        await ref.delete();
      }
      return const Right(true);
    } catch (e) {
      return Left(FailureHandler.handleFailure(e: e));
    }
  }
}
