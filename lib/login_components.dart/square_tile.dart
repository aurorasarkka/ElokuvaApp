import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String title;
  const SquareTile({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(20), //määrittää googlen korkeutta
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          const SizedBox(width: 1),
          Text(title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}