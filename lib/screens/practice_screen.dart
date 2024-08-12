import 'dart:math';
import 'package:flutter/material.dart';
import 'package:memhack_flashcard_app/screens/create_set_screen.dart';
import 'package:memhack_flashcard_app/screens/home_screen.dart';

class PracticeScreen extends StatefulWidget {
  final List<Map<String, String>> flashcards;

  const PracticeScreen({super.key, required this.flashcards});

  @override
  _PracticeScreenState createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  int currentFlashcardIndex = 0;
  late List<String> choices;

  @override
  void initState() {
    super.initState();
    choices = [];
    _generateChoices();
  }

  void _generateChoices() {
    final flashcard = widget.flashcards[currentFlashcardIndex];
    final correctAnswer = flashcard['term']!;
    final allTerms = widget.flashcards.map((flashcard) => flashcard['term']!).toList();
    allTerms.remove(correctAnswer);
    allTerms.shuffle();
    choices = allTerms.take(2).toList();
    final randomIndex = Random().nextInt(choices.length + 1);
    choices.insert(randomIndex, correctAnswer);
    if (choices.last == correctAnswer) {
      choices.shuffle();
    }
  }

  void _handleAnswer(String selectedChoice) {
    final bool isCorrect =
        selectedChoice == widget.flashcards[currentFlashcardIndex]['term'];
    final String message = isCorrect ? 'Correct!' : 'Incorrect. Try again.';
    final Color backgroundColor =
        isCorrect ? const Color(0xFFBACD92) : const Color(0xFFE97777);

    _showSnackBar(message, backgroundColor);

    if (isCorrect) {
      _moveToNextFlashcard();
    }
  }

  void _moveToNextFlashcard() {
    setState(() {
      currentFlashcardIndex++;
      if (currentFlashcardIndex >= widget.flashcards.length) {
        currentFlashcardIndex = 0;
      } else {
        _generateChoices();
      }
    });
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Practice (${currentFlashcardIndex + 1}/${widget.flashcards.length})',
          style: const TextStyle(
              color: Color(0xFF887cac)
              ),
        ),
        backgroundColor: const Color(0xFFe7e5ee),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics:
              const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    widget.flashcards[currentFlashcardIndex]['definition']!,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                ...choices.map((choice) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _handleAnswer(choice);
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFF8074ac),
                        ),
                        foregroundColor: WidgetStateProperty.all<Color>(
                          Colors.white,
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      child: Text(choice),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
