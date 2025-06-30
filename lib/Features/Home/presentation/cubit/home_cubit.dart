import 'package:bookia/Features/Home/data/model/best_seller_responce/best_seller_responce.dart';
import 'package:bookia/Features/Home/data/model/best_seller_responce/product.dart';
import 'package:bookia/Features/Home/data/model/slider_response/slider.dart';
import 'package:bookia/Features/Home/data/model/slider_response/slider_response.dart';
import 'package:bookia/Features/Home/data/repo/home_repo.dart';
import 'package:bookia/Features/Home/presentation/cubit/home_state.dart';
import 'package:bookia/Features/cart/data/repo/cart_repo.dart';
import 'package:bookia/Features/wishlist/data/repo/wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<SliderModel> sliders = [];

  List<Product> bestSellers = [];

  getHomeData() async {
    emit(HomeLoadingState());

    try {
      var futures = await Future.value([
        HomeRepo.getSlider(),
        HomeRepo.getBestSeller(),
      ]);

      sliders = ((await futures[0]) as SliderResponse).data?.sliders ?? [];
      bestSellers =
          ((await futures[1]) as BestSellerResponse).data?.products ?? [];
      emit(HomeSuccessState());
    } on Exception catch (_) {
      emit(HomeFailureState());
    }
  }

  Future<void> addToWishkist(int productId) async {
    emit(HomeLoadingState());
    try {
      var response = await WishlistRepo.addTOWishlist(productId);
      if (response) {
        emit(AddedToWishlistCartState(message: "Added To Wishlist"));
      } else {
        emit(HomeFailureState());
      }
    } on Exception catch (_) {
      emit(HomeFailureState());
    }
  }
  Future<void> addToCart(int productId) async {
    emit(HomeLoadingState());
    try {
      var response = await CartRepo.addTOCartRepolist(productId);
      if (response) {
        emit(AddedToWishlistCartState(message: "Added To Cart"));
      } else {
        emit(HomeFailureState());
      }
    } on Exception catch (_) {
      emit(HomeFailureState());
    }
  }
}
