import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_survey_app_web/core/error/failure.dart';
import 'package:flutter_survey_app_web/core/error/failure_handler.dart';
import 'package:flutter_survey_app_web/core/error/timeout.dart';

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

  /// IT IS USED TO GET IMAGE URL OF SURVEY COVER IMAGE
  @override
  Future<Either<Failure, String>> getImageUrl({
    required Uint8List imageBytes,
    required String path,
  }) async {
    try {
      final storageRef = storage.ref();
      final uniqueFileName =
          '$path${DateTime.now().millisecondsSinceEpoch}.png';
      final imageRef = storageRef.child(uniqueFileName);
      await imageRef.putData(imageBytes).timeout(
        TimeoutHandler.timeoutDuration,
        onTimeout: () {
          throw TimeoutHandler.timeoutException;
        },
      );

      final urlPath = await imageRef.getDownloadURL().timeout(
        TimeoutHandler.timeoutDuration,
        onTimeout: () {
          throw TimeoutHandler.timeoutException;
        },
      );
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
      final listResult = await storage.ref(path).listAll().timeout(
        TimeoutHandler.timeoutDuration,
        onTimeout: () {
          throw TimeoutHandler.timeoutException;
        },
      );

      for (final ref in listResult.items) {
        await ref.delete().timeout(
          TimeoutHandler.timeoutDuration,
          onTimeout: () {
            throw TimeoutHandler.timeoutException;
          },
        );
      }
      return const Right(true);
    } catch (e) {
      return Left(FailureHandler.handleFailure(e: e));
    }
  }
}
