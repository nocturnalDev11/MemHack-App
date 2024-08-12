import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  final List<Map<String, String>>? flashcards;

  const ReviewScreen({super.key, required this.flashcards});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Review Flashcards',
          style: TextStyle(
            color: Color(0xFF887cac)
          ),
        ),
        backgroundColor: const Color(0xFFe7e5ee),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            if (widget.flashcards?.isEmpty == true)
              const Text('No flashcards added yet!'),
            if (widget.flashcards != null && widget.flashcards!.isNotEmpty)
              Column(
                children: [
                  Text(
                    widget.flashcards![currentIndex]['term']!,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45.0),
                    child: Text(
                      widget.flashcards![currentIndex]['definition']!,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                if (currentIndex > 0)
                  Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: SizedBox(
                      width: 80,
                      child: ElevatedButton(
                        onPressed: () {
                          if (currentIndex > 0) {
                            setState(() {
                              currentIndex--;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                if (currentIndex < widget.flashcards!.length - 1)
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: SizedBox(
                      width: 80,
                      child: ElevatedButton(
                        onPressed: () {
                          if (widget.flashcards != null &&
                              currentIndex < widget.flashcards!.length - 1) {
                            setState(() {
                              currentIndex++;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Reached the end of flashcards!'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0),
                          ),
                        ),
                        child: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
