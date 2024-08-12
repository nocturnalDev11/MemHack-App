import 'package:flutter/material.dart';
import 'package:memhack_flashcard_app/screens/review_screen.dart';
import 'package:memhack_flashcard_app/screens/practice_screen.dart';

class CreateSetScreen extends StatefulWidget {
  const CreateSetScreen({super.key});

  @override
  _CreateSetScreenState createState() => _CreateSetScreenState();
}

class _CreateSetScreenState extends State<CreateSetScreen> {
  List<Map<String, String>> flashcards = [];
  final TextEditingController termController = TextEditingController();
  final TextEditingController definitionController = TextEditingController();
  int editingIndex = -1;

  void addNewFlashcard(String term, String definition) {
    setState(() {
      flashcards.add({
        'term': term,
        'definition': definition,
      });
    });
  }

  void navigateToReviewScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewScreen(
          flashcards: flashcards,
        ),
      ),
    );
  }

  void navigateToPracticeScreen() {
    if (flashcards.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PracticeScreen(
            flashcards: flashcards,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No flashcards added yet!'),
          backgroundColor: Color(0xFFE97777),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Set',
          style: TextStyle(
            color: Color(0xFF887cac)
          ),
        ),
        backgroundColor: const Color(0xFFe7e5ee),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: termController,
                decoration: const InputDecoration(
                  labelText: 'Term',
                ),
                onChanged: (String value) {
                  if (value.isEmpty) return;
                  final firstChar = value[0].toUpperCase();
                  final remainingText = value.substring(1).toLowerCase();
                  termController.text = firstChar + remainingText;
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: definitionController,
                decoration: const InputDecoration(
                  labelText: 'Definition',
                ),
                onChanged: (String value) {
                  if (value.isEmpty) return;

                  final firstChar = value[0].toUpperCase();
                  final remainingText = value.substring(1).toLowerCase();
                  definitionController.text = firstChar + remainingText;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (editingIndex >= 0) {
                      if (termController.text !=
                              flashcards[editingIndex]['term'] ||
                          definitionController.text !=
                              flashcards[editingIndex]['definition']) {
                        setState(() {
                          flashcards[editingIndex] = {
                            'term': termController.text,
                            'definition': definitionController.text,
                          };
                        });
                      }
                      setState(() {
                        editingIndex = -1;
                        termController.text = '';
                        definitionController.text = '';
                      });
                    } else {
                      addNewFlashcard(
                          termController.text, definitionController.text);
                      setState(() {
                        termController.text = '';
                        definitionController.text = '';
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      const Color(0xFFece4f4),
                    ),
                    foregroundColor: WidgetStateProperty.all<Color>(
                      const Color(0xFF8074ac),
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  child: Text(editingIndex >= 0
                      ? 'Update Flashcard'
                      : 'Add More Flashcards'),
                ),
              ),

              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: flashcards.length,
                itemBuilder: (context, index) {
                  return FlashcardItem(
                    flashcard: flashcards[index],
                    onDelete: () {
                      setState(() {
                        flashcards.removeAt(index);
                      });
                    },
                    onEdit: () {
                      setState(() {
                        editingIndex = index;
                        termController.text = flashcards[index]['term']!;
                        definitionController.text =
                            flashcards[index]['definition']!;
                      });
                    },
                  );
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    navigateToReviewScreen();
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
                  child: const Text('Review Flashcards'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    navigateToPracticeScreen();
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
                  child: const Text('Practice'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FlashcardItem extends StatelessWidget {
  final Map<String, String> flashcard;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const FlashcardItem({
    super.key,
    required this.flashcard,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 15.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    flashcard['term']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    flashcard['definition']!,
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Color(0xFF7ABA78),
                  ),
                  onPressed: onEdit,
                ),
                const SizedBox(width: 3),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Color(0xFFE97777),
                  ),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
