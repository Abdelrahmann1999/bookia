import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/Components/dialogs/loading_dialog.dart';
import 'package:bookia/Features/cart/data/model/update_cart_params.dart';
import 'package:bookia/Features/cart/presintation/cubit/cart_cupit.dart';
import 'package:bookia/Features/cart/presintation/cubit/cart_state.dart';
import 'package:bookia/core/Constants/AppAssete.dart';
import 'package:bookia/core/Extensions/navigation.dart';
import 'package:bookia/core/Utils/AppColors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCupit()..getCart(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          title: Text("CartScreen"),
          centerTitle: true,
        ),
        body: BlocConsumer<CartCupit, CartState>(
          listener: (context, state) {
            if (state is CartFailureState) {
              context.pop();
              showMainDialog(context, "something went Wrong");
            } else if (state is RemovedFromCartState) {
              context.pop();
              showMainDialog(context, "Removed From Cart", DialogType.success);
            } else if (state is RemovedFromCartLoadingState) {
              showLoadingDialog(context);
            } else if (state is CartSuccessState) {
              if (Navigator.canPop(context)) context.pop();
            } else if (state is CheckOutOrderDoneState) {
              context.pushTo(Routes.checkout);
            }
          },

          builder: (context, state) {
            var cubit = context.read<CartCupit>();
            if (cubit.cartResponse?.data?.cartItems?.isEmpty == true) {
              return Center(
                child: Text(
                  "Your Cart Screen Is Empty !",
                  style: TextStyles.getTitle(
                    color: AppColors.black,
                    fontsize: 18,
                  ),
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      var book = cubit.cartResponse?.data?.cartItems?[index];
                      return Row(
                        children: [
                          Hero(
                            tag: index,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: book?.itemProductImage ?? "",
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error_outline),
                                fit: BoxFit.cover,
                                width: 100,
                              ),
                            ),
                          ),
                          Gap(20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        book?.itemProductName ?? "",
                                        style: TextStyles.getHeadLine2(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        cubit.removeFromCart(book?.itemId ?? 0);
                                      },
                                      icon: SvgPicture.asset(
                                        Appassetes.closeSvg,
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(10),
                                Row(
                                  children: [
                                    Text(
                                      "${book?.itemProductPriceAfterDiscount ?? 0}",
                                      style: TextStyles.getBody(),
                                    ),
                                    Visibility(
                                      visible:
                                          (book?.itemProductDiscount != null &&
                                          book?.itemProductDiscount != 0),
                                      child: Row(
                                        children: [
                                          Gap(10),
                                          Text(
                                            book?.itemProductPrice ?? "",
                                            style:
                                                TextStyles.getBody(
                                                  color: AppColors.darkGrey,
                                                ).copyWith(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(10),

                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (((book?.itemQuantity ?? 0) + 1) <=
                                            (book?.itemProductStock ?? 1)) {
                                          context.read<CartCupit>().updateCart(
                                            UpdateCartParams(
                                              cartItemId: book?.itemId ?? 0,
                                              quantity:
                                                  (book?.itemQuantity ?? 0) + 1,
                                            ),
                                          );
                                        } else {
                                          showMainDialog(
                                            context,
                                            "Quantity cannot be more than ${book?.itemProductStock ?? 0}",
                                          );
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          color: AppColors.accent,
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Gap(10),
                                    SizedBox(
                                      width: 20,
                                      child: Text(
                                        "${book?.itemQuantity}",
                                        textAlign: TextAlign.center,
                                        style: TextStyles.getBody(),
                                      ),
                                    ),
                                    Gap(10),

                                    GestureDetector(
                                      onTap: () {
                                        if (((book?.itemQuantity ?? 0) - 1) >
                                            0) {
                                          context.read<CartCupit>().updateCart(
                                            UpdateCartParams(
                                              cartItemId: book?.itemId ?? 0,
                                              quantity:
                                                  (book?.itemQuantity ?? 0) - 1,
                                            ),
                                          );
                                        } else {
                                          showMainDialog(
                                            context,
                                            "Quantity cannont be liss than 1",
                                            DialogType.error,
                                          );
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          color: AppColors.accent,
                                        ),
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Text(
                                        "\$ ${book?.itemTotal?.round() ?? 0}",
                                        style: TextStyles.getTitle(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                    itemCount: cubit.cartResponse?.data?.cartItems?.length ?? 0,
                    padding: EdgeInsets.all(20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              "Total:",
                              style: TextStyles.getTitle(
                                color: AppColors.darkGrey,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$ ${cubit.cartResponse?.data?.total ?? 0}",
                              style: TextStyles.getTitle(),
                            ),
                          ],
                        ),
                      ),
                      Gap(20),
                      mainButton(
                        text: "Checkout",
                        onPressed: () {
                          cubit.checkOut();
                        },
                        width: 375,
                        borderRadius: 5,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
