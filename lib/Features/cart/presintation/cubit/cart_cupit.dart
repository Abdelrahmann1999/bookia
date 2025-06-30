import 'package:bookia/Features/cart/data/model/get_cart_response/get_cart_response.dart';
import 'package:bookia/Features/cart/data/model/update_cart_params.dart';
import 'package:bookia/Features/cart/data/repo/cart_repo.dart';
import 'package:bookia/Features/cart/presintation/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCupit extends Cubit<CartState> {
  CartCupit() : super(CartInitialState());
  GetCartResponse? cartResponse = GetCartResponse();

  Future<void> getCart() async {
    emit(CartLoadingState());

    CartRepo.getCartRepoList().then((value) {
      if (value != null) {
        cartResponse = value;
        emit(CartSuccessState());
      } else {
        emit(CartFailureState());
      }
    });
  }

  Future<void> removeFromCart(int cartItemId) async {
    emit(RemovedFromCartLoadingState());

    CartRepo.removeFromCartRepolist(cartItemId).then((value) {
      if (value != null) {
        cartResponse = value;
        emit(RemovedFromCartState());
      } else {
        emit(CartFailureState());
      }
    });
  }

  Future<void> updateCart(UpdateCartParams params) async {
    emit(UpdateCartLoadingState());

    CartRepo.updateCart(params).then((value) {
      if (value != null) {
        cartResponse = value;
        emit(CartSuccessState());
      } else {
        emit(CartFailureState());
      }
    });
  }

  Future<void> checkOut() async {
    emit(UpdateCartLoadingState());

    CartRepo.checkOut().then((value) {
      if (value == true) {
        emit(CheckOutOrderDoneState());
      } else {
        emit(CartFailureState());
      }
    });
  }
}
