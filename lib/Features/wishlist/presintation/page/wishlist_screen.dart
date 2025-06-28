import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/Components/dialogs/loading_dialog.dart';
import 'package:bookia/Features/wishlist/presintation/cubit/wishlist_cupit.dart';
import 'package:bookia/Features/wishlist/presintation/cubit/wishlist_state.dart';
import 'package:bookia/core/Constants/AppAssete.dart';
import 'package:bookia/core/Utils/AppColors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistCupit()..getWishlist(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          title: Text("Wishlist"),
          centerTitle: true,
        ),
        body: BlocConsumer<WishlistCupit, WishListState>(
          listener: (context, state) {
            if (state is WIshListFailureState) {
              context.pop();

              showMainDialog(
                context,
                "An Error Ocurred While Fetching the WishList",
              );
            } else if (state is removedFromWishlistState) {
              showMainDialog(
                context,
                "Removed From WishList",
                DialogType.success,
              );
            }
          },
          builder: (context, state) {
            var cubit = context.read<WishlistCupit>();
            if (cubit.whshlistResponse?.data?.data?.isEmpty == true) {
              return Center(
                child: Text(
                  "Your WishList Is Empty !",
                  style: TextStyles.getTitle(
                    color: AppColors.black,
                    fontsize: 18,
                  ),
                ),
              );
            }

            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                var book = cubit.whshlistResponse?.data?.data?[index];
                return Row(
                  children: [
                    Hero(
                      tag: index,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: book?.image ?? "",
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
                                  book?.name ?? "",
                                  style: TextStyles.getHeadLine2(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.removeFromWishlist(book?.id ?? 0);
                                },
                                icon: SvgPicture.asset(Appassetes.closeSvg),
                              ),
                            ],
                          ),
                          Gap(10),
                          Text(book?.price ?? "", style: TextStyles.getBody()),
                          Gap(20),
                          mainButton(
                            text: "Add To Cart",
                            onPressed: () {},
                            width: 270,
                            height: 50,
                            borderRadius: 5,
                          ),
                          Gap(10),
                        ],
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
              itemCount: cubit.whshlistResponse?.data?.data?.length ?? 0,
              padding: EdgeInsets.all(20),
            );
          },
        ),
      ),
    );
  }
}
