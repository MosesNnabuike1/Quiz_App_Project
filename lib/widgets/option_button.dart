import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String option;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback onTap;

  const OptionButton({
    super.key,
    required this.option,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect ? Colors.green : Colors.red)
              : Colors.blueAccent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          option,
          style: const TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
