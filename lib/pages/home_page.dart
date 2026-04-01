import 'package:ai_rag_project/widgets/search_section.dart';
import 'package:ai_rag_project/widgets/side_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: SearchSection()
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      Text('© 2026 Your Company. All rights reserved.'),
                      Text('Privacy Policy'),
                      Text('Terms of Service'),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}