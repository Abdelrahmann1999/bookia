
import 'package:bookia/Features/cart/data/repo/cart_repo.dart';
import 'package:bookia/Features/wishlist/data/model/get_wishlist_response/get_wishlist_response.dart';
import 'package:bookia/Features/wishlist/data/repo/wishlist_repo.dart';
import 'package:bookia/Features/wishlist/presintation/cubit/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCupit extends Cubit<WishListState> {
  WishlistCupit() : super(WishListInitialState());
  GetWishlistResponse? whshlistResponse = GetWishlistResponse();

  Future<void> getWishlist() async {
    emit(WIshListLoadingState());

    try {
      var response = await WishlistRepo.getWIshList();
      if (response != null) {
        whshlistResponse = response;
        emit(WIshListSuccessState());
      } else {
        emit((WIshListFailureState()));
      }
    } catch (_) {
      emit(WIshListFailureState());
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    emit(WIshListLoadingState());
    WishlistRepo.removeFromWishlist(productId).then((value) {
      if (value != null) {
        whshlistResponse = value;
        emit(removedFromWishlistState());
      } else {
        emit(WIshListFailureState());
      }
    });
  }
   Future<void> addToCart(int productId) async {
    emit(WIshListLoadingState());
    try {
      var response = await CartRepo.addTOCartRepolist(productId);
      if (response) {
        emit(AddedToCartSate());
      } else {
        emit(WIshListFailureState());
      }
    } on Exception catch (_) {
      emit(WIshListFailureState());
    }
  }
}
