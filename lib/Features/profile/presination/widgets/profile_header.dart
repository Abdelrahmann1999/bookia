import 'package:bookia/core/Services/shared_pref.dart';
import 'package:bookia/core/Utils/AppColors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class profileHeader extends StatelessWidget {
  const profileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var userInfo = SharedPref.getUserInfo();
    return Row(
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: userInfo.image ?? "",
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        Gap(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userInfo.name ?? "",
                style: TextStyles.getTitle(fontsize: 23),
              ),
              Gap(8),
              Text(
                userInfo.email ?? "",
                style: TextStyles.getSmall(color: AppColors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
