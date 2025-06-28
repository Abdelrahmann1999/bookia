import 'package:bookia/Features/wishlist/data/model/get_wishlist_response/get_wishlist_response.dart';
import 'package:bookia/core/Constants/AppConstants.dart';
import 'package:bookia/core/Services/dio_provider.dart';
import 'package:bookia/core/Services/shared_pref.dart';

class WishlistRepo {
  static Future<GetWishlistResponse?> getWIshList() async {
    try {
      var response = await DioProvider.get(
        endpoint: Appconstants.wishlist,
        headers: {"Authorization": "Bearer ${SharedPref.getUserTokin()}"},
      );
      if (response.statusCode == 200) {
        return GetWishlistResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<bool> addTOWishlist(int productId) async {
    try {
      var response = await DioProvider.post(
        endpoint: Appconstants.addToWishlist,
        headers: {"Authorization": "Bearer ${SharedPref.getUserTokin()}"},
        data: {"product_id": productId},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (_) {
      return false;
    }
  }

  static Future<GetWishlistResponse?> removeFromWishlist(int productId) async {
    try {
      var response = await DioProvider.post(
        endpoint: Appconstants.removeFromWishlist,
        headers: {"Authorization": "Bearer ${SharedPref.getUserTokin()}"},
        data: {"product_id": productId},
      );
      if (response.statusCode == 200) {
        return GetWishlistResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (_) {
      return null;
    }
  }
}
