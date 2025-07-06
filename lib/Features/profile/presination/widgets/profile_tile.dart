import 'package:bookia/core/Utils/text_styles.dart';
import 'package:flutter/material.dart';

class profileTile extends StatelessWidget {
  final String label;
  final Function() Ontap;
  const profileTile({super.key, required this.label, required this.Ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Ontap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xff8A959E).withValues(alpha: 0.2),
              blurRadius: 30,
              offset: Offset(0, 7),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Text(label, style: TextStyles.getHeadLine2(fontsize: 18)),
              Spacer(),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
