import 'package:ai_rag_project/themes/colors.dart';
import 'package:ai_rag_project/widgets/side_bar_button.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool isCollapsed = true;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration( milliseconds: 100),
      width: isCollapsed ? 64 : 140,
      color: AppColors.sideNav,
      child: Column(
        children: [
          const SizedBox(height: 16,),
          Icon(
            Icons.auto_awesome_mosaic,
            color: AppColors.whiteColor,
            size: isCollapsed? 30: 60,
          ),
          
          Expanded(
            child: Column(
              crossAxisAlignment: isCollapsed ? CrossAxisAlignment.center: CrossAxisAlignment.start,
              children: [
                
                SideBarButton(
                  isCollapsed: isCollapsed,
                  icon: Icons.add,
                  text: "Home"
                ),
                SideBarButton(
                  isCollapsed: isCollapsed,
                  icon: Icons.search,
                  text: "Search"
                ),
                SideBarButton(
                  isCollapsed: isCollapsed,
                  icon: Icons.auto_awesome,
                  text: "Discover"
                ),
                SideBarButton(
                  isCollapsed: isCollapsed,
                  icon: Icons.cloud_outlined,
                  text: "Library"
                ),
            
                const Spacer(),
            
                
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                isCollapsed = !isCollapsed;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 120),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Icon(
                isCollapsed? Icons.keyboard_arrow_right : Icons.keyboard_arrow_left,
                size: 22,
                color: AppColors.iconGrey,
              ),
            ),
          ),
      
          const SizedBox(height: 16,),
        ],
      ),
    );
  }
}