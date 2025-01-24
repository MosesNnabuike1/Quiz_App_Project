import 'package:flutter/material.dart';
import 'package:my_quiz_app/pages/result_page.dart';

void showResultPage(BuildContext context, int correctAnswers, int totalQuestions) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => ResultPage(correctAnswers: correctAnswers, totalQuestions: totalQuestions),
    ),
  );
}