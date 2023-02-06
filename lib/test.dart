import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_english_story/service/story_book/firebase_story_book_provider.dart';

class TestFuture extends StatelessWidget {
  const TestFuture({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseStoryBookProvider().test(),
      builder: (context, snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.done:
            return Text("done");
          default:
            return CircularProgressIndicator();
        }
    },);
  }
}

class TestStream extends StatelessWidget {
  const TestStream({super.key});

  @override
  Widget build(BuildContext context) {
    
    final stream = FirebaseStoryBookProvider().getStoryBooksByLevel();
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
          case ConnectionState.active:
            return snapshot.data != null
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {

                      final pages = FirebaseStoryBookProvider().getStudyPagesByPageOrder(docId: snapshot.data!.first.docId);
                      return StreamBuilder(
                        stream: pages,
                        builder: (context, snapshot) {
                          switch(snapshot.connectionState){
                            case ConnectionState.waiting:
                            case ConnectionState.active:
                              return snapshot.data != null
                                  ? Text(snapshot.data!.first.vocabList.first.meaning)
                                  : Container();
                            default:
                              return const CircularProgressIndicator();
                          }
                      },);
                    },
                  )
                : Container();
          default:
            return const CircularProgressIndicator();
        }
    },);
  }
}