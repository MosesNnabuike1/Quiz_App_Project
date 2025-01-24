import 'package:flutter/material.dart';

class QuestionContainer extends StatelessWidget {
  final String question;

  const QuestionContainer({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(60.0),
      constraints: const BoxConstraints(maxWidth: 600),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 219, 214, 214),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 24, 23, 23).withOpacity(0.2),
            spreadRadius: 10,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            question,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
