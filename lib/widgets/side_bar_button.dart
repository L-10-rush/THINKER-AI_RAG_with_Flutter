import 'package:ai_rag_project/themes/colors.dart';
import 'package:flutter/material.dart';

class SideBarButton extends StatelessWidget {
  
  final bool isCollapsed;
  final IconData icon;
  final String text;

  const SideBarButton({
    super.key,
    required this.isCollapsed,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isCollapsed? MainAxisAlignment.center: MainAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Icon(
              icon,
              size: 22,
              color: AppColors.iconGrey,
            ),
          ),
        isCollapsed ?
          const SizedBox()
          :Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )
      ],
    );
  }
}