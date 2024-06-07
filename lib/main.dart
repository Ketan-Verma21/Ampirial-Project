import 'package:feedback/feedback.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recruit_portal/services/auth/selection.dart';
import 'package:recruit_portal/theme/theme_provider.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BetterFeedback(
  theme:FeedbackThemeData(
  activeFeedbackModeColor:Colors.green,
      background: Colors.lightBlueAccent,
      drawColors: [
        Colors.green,
        Colors.yellow,
        Colors.black,
        Colors.red
      ]
  ),
    child:ProviderScope(
      child: MyApp(),
    ),)
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      title: 'Slim Shady',
      debugShowCheckedModeBanner: false,
      theme: ref.watch(themeProvider).themeData,
      home: Selection(),
    );
  }
}

