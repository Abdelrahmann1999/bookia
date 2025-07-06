import 'package:bookia/Features/cart/data/model/get_cart_response/get_cart_response.dart';
import 'package:bookia/Features/cart/data/model/update_cart_params.dart';
import 'package:bookia/core/Constants/AppConstants.dart';
import 'package:bookia/core/Services/dio_provider.dart';
import 'package:bookia/core/Services/shared_pref.dart';

class CartRepo {
  static Future<GetCartResponse?> getCartRepoList() async {
    try {
      var response = await DioProvider.get(
        endpoint: Appconstants.cart,
        headers: {"Authorization": "Bearer ${SharedPref.getUserTokin()}"},
      );
      if (response.statusCode == 200) {
        return GetCartResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<bool> addTOCartRepolist(int productId) async {
    try {
      var response = await DioProvider.post(
        endpoint: Appconstants.addTocartlist,
        headers: {"Authorization": "Bearer ${SharedPref.getUserTokin()}"},
        data: {"product_id": productId},
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (_) {
      return false;
    }
  }

  static Future<GetCartResponse?> removeFromCartRepolist(int cartItemId) async {
    try {
      var response = await DioProvider.post(
        endpoint: Appconstants.removeFromcartlist,
        headers: {"Authorization": "Bearer ${SharedPref.getUserTokin()}"},
        data: {"cart_item_id": cartItemId},
      );
      if (response.statusCode == 200) {
        return GetCartResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<GetCartResponse?> updateCart(UpdateCartParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Appconstants.updateCart,
        headers: {"Authorization": "Bearer ${SharedPref.getUserTokin()}"},
        data: params.toJson(),
      );
      if (response.statusCode == 201) {
        return GetCartResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<bool> checkOut() async {
    try {
      var response = await DioProvider.get(
        endpoint: Appconstants.checkOut,
        headers: {"Authorization": "Bearer ${SharedPref.getUserTokin()}"},
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
}
