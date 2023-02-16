import 'package:flutter/material.dart';

//finish
class WordStoryTab extends StatefulWidget {
  const WordStoryTab({super.key});

  @override
  State<WordStoryTab> createState() => _WordStoryTabState();
}

class _WordStoryTabState extends State<WordStoryTab> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 2,
        child: TabBar(
          labelColor: Colors.black, // selected text color
          unselectedLabelColor: Colors.white,
          indicatorColor: Color(0xffBAEDA6), //<-- SEE HERE
          tabs: [
            Tab(
              text: 'Word',
            ),
            Tab(
              text: 'Story',
            ),
          ],
        ));
  }
}
