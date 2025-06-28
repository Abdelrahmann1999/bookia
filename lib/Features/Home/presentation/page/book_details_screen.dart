import 'package:bookia/Components/buttons/main_back_button.dart';
import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/Components/dialogs/loading_dialog.dart';
import 'package:bookia/Features/Home/data/model/best_seller_responce/product.dart';
import 'package:bookia/Features/Home/presentation/cubit/home_cubit.dart';
import 'package:bookia/Features/Home/presentation/cubit/home_state.dart';
import 'package:bookia/core/Constants/AppAssete.dart';
import 'package:bookia/core/Utils/AppColors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is AddedToWishlistState) {
            context.pop();
            showMainDialog(context, "Added To WishList", DialogType.success);
          } else if (state is HomeFailureState) {
            context.pop();
            showMainDialog(context, "Something Went Wrong", DialogType.error);
          } else if (state is HomeLoadingState) {
            showLoadingDialog(context);
          }
        },

        builder: (context, state) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 90,
            title: Row(
              children: [
                MainBackButton(),
                Spacer(),
                IconButton(
                  onPressed: () {
                    context.read<HomeCubit>().addToWishkist(product.id ?? 0);
                  },
                  icon: SvgPicture.asset(Appassetes.bookmarkSvg),
                ),
              ],
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Gap(25),
                    Hero(
                      tag: product.id ?? "",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: product.image ?? '',
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error_outline),

                          fit: BoxFit.cover,
                          width: 183,
                          height: 271,
                        ),
                      ),
                    ),
                    Gap(15),
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        '${product.name}',
                        style: TextStyles.getHeadLine1(),
                      ),
                    ),
                    Gap(20),
                    Text(
                      product.category ?? "",
                      style: TextStyles.getTitle(color: AppColors.primary),
                    ),
                    Gap(15),
                    Text(
                      product.description ?? "",
                      style: TextStyles.getSmall(color: AppColors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${product.price}",
                    style: TextStyles.getBody(
                      fontsize: 24,
                      color: AppColors.dark,
                      fontweight: FontWeight.bold,
                    ),
                  ),
                  mainButton(
                    text: "Add To Cart",
                    onPressed: () {},
                    height: 55,
                    width: 250,
                    textColor: AppColors.white,
                    BGcolor: AppColors.dark,
                    borderRadius: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
