import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String category;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const CategoryButton({
    super.key,
    required this.category,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: Icon(icon, color: Colors.white, size: 30),
      label: Text(
        category,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
