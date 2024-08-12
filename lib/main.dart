import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:memhack_flashcard_app/screens/home_screen.dart';
import 'package:memhack_flashcard_app/models/flashcard_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FlashcardModel(),
      child: MaterialApp(
        title: 'MemHack Flashcard App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
