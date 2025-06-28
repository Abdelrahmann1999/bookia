import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/Features/Home/data/model/best_seller_responce/product.dart';
import 'package:bookia/core/Extensions/navigation.dart';
import 'package:bookia/core/Utils/AppColors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BestSellerList extends StatelessWidget {
  const BestSellerList({super.key, required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Best Seller",
            style: TextStyles.getHeadLine2(color: AppColors.black),
          ),
          Gap(15),
          Skeletonizer(
            enabled: products.isEmpty,
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: products.isEmpty ? 4 : products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 300,
              ),
              itemBuilder: (context, index) {
                if (products.isEmpty) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      context.pushTo(Routes.details, extra: products[index]);
                    },
                    child: Container(
                      padding: EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        color: AppColors.primary50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Hero(
                              tag: products[index].id ?? "",
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error_outline),

                                  imageUrl: products[index].image ?? '',

                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ),
                          Gap(5),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Text(
                              '${products[index].name}',
                              style: TextStyles.getTitle(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Gap(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${products[index].price}",
                                style: TextStyles.getBody(
                                  color: AppColors.dark,
                                  fontweight: FontWeight.bold,
                                ),
                              ),
                              mainButton(
                                text: "Buy",
                                onPressed: () {},
                                height: 30,
                                width: 85,
                                textColor: AppColors.white,
                                BGcolor: AppColors.black,
                                borderRadius: 5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
