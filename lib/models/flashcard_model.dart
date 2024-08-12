import 'package:flutter/material.dart';

class FlashcardModel extends ChangeNotifier {
  List<Map<String, String>> flashcards = [];

  void addFlashcard(Map<String, String> flashcard) {
    flashcards.add(flashcard);
    notifyListeners();
  }
}
