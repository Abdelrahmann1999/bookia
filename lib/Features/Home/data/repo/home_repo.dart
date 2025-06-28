import 'package:bookia/Features/Home/data/model/best_seller_responce/best_seller_responce.dart';
import 'package:bookia/Features/Home/data/model/slider_response/slider_response.dart';
import 'package:bookia/core/Constants/AppConstants.dart';
import 'package:bookia/core/Services/dio_provider.dart';

class HomeRepo {
  static Future<SliderResponse?> getSlider() async {
    try {
      var response = await DioProvider.get(endpoint: Appconstants.slider);
      if (response.statusCode == 200) {
        return SliderResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<BestSellerResponse?> getBestSeller() async {
    try {
      var response = await DioProvider.get(endpoint: Appconstants.bestSeller);
      if (response.statusCode == 200) {
        return BestSellerResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (_) {
      return null;
    }
  }
}
