import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseConstants {
  FirebaseConstants._();
  static final String defaultRecipeImageUrl =
      dotenv.env['DEFAULT_RECIPE_IMAGE_URL'] ?? '';
  static final String defaultRecipeStepImageUrl =
      dotenv.env['DEFAULT_RECIPE_STEP_IMAGE_URL'] ?? '';
}
