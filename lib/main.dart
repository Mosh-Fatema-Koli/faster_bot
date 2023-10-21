import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wow_chat_app/firebase_options.dart';
import 'package:wow_chat_app/src/app.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const MyApp());
}





// import 'package:flutter/material.dart';
// import 'package:grouped_list/grouped_list.dart';
// import 'package:intl/intl.dart';
// import 'package:wow_chat_app/src/service/controller/audio_sound.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Chat App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: AudioPlayScreen(),
//     );
//   }
// }

// class AudioPlayScreen extends StatelessWidget {
//    AudioPlayScreen({super.key});
//   AudioPlayerController  _controller = AudioPlayerController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(onPressed:(){
//           _controller.playAudio();
//         }, child: Text("ontab")),
//       ),
//     );
//   }
// }
