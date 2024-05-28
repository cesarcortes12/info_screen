import 'package:flutter/material.dart';

class CustomEmptyState extends StatelessWidget {
  final String message;

  const CustomEmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.info_outline,
              size: 50,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(color: Colors.grey, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
