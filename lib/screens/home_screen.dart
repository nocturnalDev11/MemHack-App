import 'package:flutter/material.dart';
import 'package:memhack_flashcard_app/screens/create_set_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'MEM',
                    style: TextStyle(
                      color: Color(0xFF8074ac),
                      fontSize: 75,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '\nHACK',
                    style: TextStyle(
                      color: Color(0xFFa49ccc),
                      fontSize: 75,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateSetScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFdcd4ec),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0),
                ),
              ),
              child: const Text('Create Flashcard'),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
