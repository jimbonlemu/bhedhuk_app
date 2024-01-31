import 'package:flutter_dotenv/flutter_dotenv.dart';

class Images {
  static final Images instanceImages = Images();

  static const String appLogo = 'assets/images/feed_me_logo.png';
  static const String lottieNoResult = "assets/lotties/lottie_no_result.json";
  static const String lottieError = "assets/lotties/error_lottie.json";

  static final String _getSmallImage = dotenv.env['GET_IMAGE_SMALL'] ?? '';
  static final String _getMediumImage = dotenv.env['GET_IMAGE_MEDIUM'] ?? '';
  static final String _getLargeImage = dotenv.env['GET_IMAGE_LARGE'] ?? '';

  String getImageSize(String imageId, String size) {
    String imageUrl;
    switch (size) {
      case 'small':
        imageUrl = _getSmallImage;
        break;
      case 'medium':
        imageUrl = _getMediumImage;
        break;
      case 'large':
        imageUrl = _getLargeImage;
        break;
      default:
        throw Exception('Invalid size statement');
    }

    return imageUrl + imageId;
  }
}
