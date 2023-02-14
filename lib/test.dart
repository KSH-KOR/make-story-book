import 'package:flutter/material.dart';
import 'package:my_english_story/service/firebase_firestore/firebase_firestore_provider.dart';

class TestFuture extends StatelessWidget {
  const TestFuture({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestoreProvider().test(),
      builder: (context, snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.done:
            return const Text("done");
          default:
            return const CircularProgressIndicator();
        }
    },);
  }
}

class TestStream extends StatelessWidget {
  const TestStream({super.key});

  @override
  Widget build(BuildContext context) {
    
    final stream = FirebaseFirestoreProvider().getStoryBooksByLevel();
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
          case ConnectionState.active:
            return snapshot.data != null
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final pages = FirebaseFirestoreProvider().getStudyPagesByPageOrder(docId: snapshot.data!.first.docId);
                      return StreamBuilder(
                        stream: pages,
                        builder: (context, snapshot) {
                          switch(snapshot.connectionState){
                            case ConnectionState.waiting:
                            case ConnectionState.active:
                              if(snapshot.data != null){
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Text(snapshot.data!.toList()[index].pageDescription);
                                    },
                                  );
                              } else{
                                return Container();
                              }
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

// class TestStream extends StatelessWidget {
//   const TestStream({super.key});

//   @override
//   Widget build(BuildContext context) {
    
//     final stream = FirebaseStoryBookProvider().getStoryBooksByLevel();
//     return StreamBuilder(
//       stream: stream,
//       builder: (context, snapshot) {
//         switch(snapshot.connectionState){
//           case ConnectionState.waiting:
//           case ConnectionState.active:
//             return snapshot.data != null
//                 ? ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       final pages = FirebaseStoryBookProvider().getQuizPagesByPageOrder(docId: snapshot.data!.first.docId);
//                       return StreamBuilder(
//                         stream: pages,
//                         builder: (context, snapshot) {
//                           switch(snapshot.connectionState){
//                             case ConnectionState.waiting:
//                             case ConnectionState.active:
//                               if(snapshot.data != null){
//                                 final l = StoryBookService.firebase().convertQuestionsToWidgets(question: snapshot.data!.first.question).toList();
//                                 return ListView.builder(
//                                     shrinkWrap: true,
//                                     itemCount: l.length,
//                                     itemBuilder: (context, index) {
//                                       return l[index];
//                                     },
//                                   );
//                               } else{
//                                 return Container();
//                               }
//                             default:
//                               return const CircularProgressIndicator();
//                           }
//                       },);
//                     },
//                   )
//                 : Container();
//           default:
//             return const CircularProgressIndicator();
//         }
//     },);
//   }
// }