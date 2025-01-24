import 'package:flutter/material.dart';
import 'category_page.dart';

class ResultPage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  const ResultPage(
      {super.key, required this.correctAnswers, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 64, 51, 90),
        title:
            const Text('Quiz Results', style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: const Color.fromARGB(255, 64, 51, 90),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Quiz Completed!',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 20),
              Text(
                'You got $correctAnswers out of $totalQuestions correct.',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CategoryPage()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text('Return to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
