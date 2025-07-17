import 'package:bookia/core/Services/shared_pref.dart';
import 'package:bookia/core/Utils/AppColors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    var userInfo = SharedPref.getUserInfo();

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            final imageUrl = SharedPref.getUserInfo().image;
            if (imageUrl != null && imageUrl.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Image.network(imageUrl),
                ),
              );
            }

            // Navigate to profile screen
          },
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: userInfo.image ?? "",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(Icons.person),
            ),
          ),
        ),
        const Gap(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userInfo.name ?? "",
                style: TextStyles.getTitle(fontsize: 23),
              ),
              const Gap(8),
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
