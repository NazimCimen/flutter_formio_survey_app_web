import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_survey_app_web/core/connection/network_info.dart';
import 'package:flutter_survey_app_web/feature/create_survey/domain/usecase/remove_survey_use_case.dart';
import 'package:flutter_survey_app_web/feature/create_survey/presentation/viewmodel/survey_logic.dart';
import 'package:flutter_survey_app_web/feature/image_process/data/data_source/image_process_local_source.dart';
import 'package:flutter_survey_app_web/feature/image_process/data/data_source/image_process_remote_source.dart';
import 'package:flutter_survey_app_web/feature/image_process/data/repository/image_process_repository_impl.dart';
import 'package:flutter_survey_app_web/feature/image_process/domain/repository/image_process_repository.dart';
import 'package:flutter_survey_app_web/feature/image_process/presentation/image_helper.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/data/model/question_model.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/data/model/survey_model.dart';
import 'package:flutter_survey_app_web/feature/create_survey/data/data_source/create_survey_remote_data_source.dart';
import 'package:flutter_survey_app_web/feature/create_survey/data/repository/create_survey_repository_impl.dart';
import 'package:flutter_survey_app_web/feature/create_survey/domain/repository/create_survey_repository.dart';
import 'package:flutter_survey_app_web/feature/image_process/domain/usecase/crop_image_use_case.dart';
import 'package:flutter_survey_app_web/feature/image_process/domain/usecase/get_image_file_use_case.dart';
import 'package:flutter_survey_app_web/feature/image_process/domain/usecase/get_image_url_use_case.dart';
import 'package:flutter_survey_app_web/feature/image_process/domain/usecase/remove_survey_images_use_case.dart';
import 'package:flutter_survey_app_web/feature/create_survey/domain/usecase/share_questions_use_case.dart';
import 'package:flutter_survey_app_web/feature/create_survey/domain/usecase/share_survey_info_use_case.dart';
import 'package:flutter_survey_app_web/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app_web/product/firebase/service/base_firebase_service.dart';
import 'package:flutter_survey_app_web/product/firebase/service/firebase_service_impl.dart';
import 'package:flutter_survey_app_web/product/helper/link_sharing_helper.dart';

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;
void setupLocator() {
  serviceLocator
    ..registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    )
    ..registerLazySingleton<FirebaseStorage>(
      () => FirebaseStorage.instance,
    )
    ..registerSingletonAsync<SharedPreferences>(
      () async => SharedPreferences.getInstance(),
    )
    ..registerLazySingleton<SurveyModel>(
      () => const SurveyModel(),
    )
    ..registerLazySingleton<QuestionModel>(
      () => const QuestionModel(),
    )
    ..registerLazySingleton<InternetConnection>(
      () => InternetConnection(),
    )
    ..registerLazySingleton<INetworkInfo>(
      () => NetworkInfo(serviceLocator<InternetConnection>()),
    )
    ..registerLazySingleton<BaseFirebaseService<SurveyModel>>(
      () => FirebaseServiceImpl(
        firestore: serviceLocator<FirebaseFirestore>(),
      ),
    )
    ..registerLazySingleton<BaseFirebaseService<QuestionModel>>(
      () => FirebaseServiceImpl(
        firestore: serviceLocator<FirebaseFirestore>(),
      ),
    )
    ..registerLazySingleton<CreateSurveyRemoteDataSource>(
      () => CreateSurveyRemoteDataSourceImpl(
        surveyFirebaseService:
            serviceLocator<BaseFirebaseService<SurveyModel>>(),
        questionFirebaseService:
            serviceLocator<BaseFirebaseService<QuestionModel>>(),
      ),
    )
    ..registerLazySingleton<CreateSurveyRepository>(
      () => CreateSurveyRepositoryImpl(
        remoteDataSource: serviceLocator<CreateSurveyRemoteDataSource>(),
      ),
    )
    ..registerLazySingleton<ShareQuestionsUseCase>(
      () => ShareQuestionsUseCase(
        repository: serviceLocator<CreateSurveyRepository>(),
      ),
    )
    ..registerLazySingleton<ShareSurveyInfoUseCase>(
      () => ShareSurveyInfoUseCase(
        repository: serviceLocator<CreateSurveyRepository>(),
      ),
    )
    ..registerLazySingleton<RemoveSurveyImagesUseCase>(
      () => RemoveSurveyImagesUseCase(
        repository: serviceLocator<ImageProcessRepository>(),
      ),
    )
    ..registerLazySingleton<RemoveSurveyUseCase>(
      () => RemoveSurveyUseCase(
        repository: serviceLocator<CreateSurveyRepository>(),
      ),
    )
    ..registerLazySingleton<SurveyLogic>(
      () => SurveyLogic(
        imageHelper: serviceLocator<ImageHelper>(),
        removeSurveyUseCase: serviceLocator<RemoveSurveyUseCase>(),
        shareSurveyInfoUseCase: serviceLocator<ShareSurveyInfoUseCase>(),
        shareQuestionsUseCase: serviceLocator<ShareQuestionsUseCase>(),
      ),
    )
    ..registerLazySingleton<LinkSharingHelper>(
      () => LinkSharingHelperImpl(),
    )
    ..registerLazySingleton<CreateSurveyViewModel>(
      () => CreateSurveyViewModel(
        imageHelper: serviceLocator<ImageHelper>(),
        surveyLogic: serviceLocator<SurveyLogic>(),
        shareLink: serviceLocator<LinkSharingHelper>(),
        connectivity: serviceLocator<INetworkInfo>(),
      ),
    )
    ..registerLazySingleton<ImageProcessRemoteSource>(
      () => ImageProcessRemoteSourceImpl(
        storage: serviceLocator<FirebaseStorage>(),
      ),
    )
    ..registerLazySingleton<ImageProcessLocalSource>(
      () => ImageProcessLocalSourceImpl(),
    )
    ..registerLazySingleton<ImageProcessRepository>(
      () => ImageProcessRepositoryImpl(
        localDataSource: serviceLocator<ImageProcessLocalSource>(),
        remoteDataSource: serviceLocator<ImageProcessRemoteSource>(),
      ),
    )
    ..registerLazySingleton<GetImageUrlUseCase>(
      () => GetImageUrlUseCase(
          repository: serviceLocator<ImageProcessRepository>()),
    )
    ..registerLazySingleton<GetImageFileUseCase>(
      () => GetImageFileUseCase(
          repository: serviceLocator<ImageProcessRepository>()),
    )
    ..registerLazySingleton<CropImageUseCase>(
      () => CropImageUseCase(
        repository: serviceLocator<ImageProcessRepository>(),
      ),
    )
    ..registerLazySingleton<ImageHelper>(
      () => ImageHelper(
        cropImageUseCase: serviceLocator<CropImageUseCase>(),
        getImageUrlUseCase: serviceLocator<GetImageUrlUseCase>(),
        getImageUseCase: serviceLocator<GetImageFileUseCase>(),
        removeSurveyImagesUseCase: serviceLocator<RemoveSurveyImagesUseCase>(),
      ),
    );
}
