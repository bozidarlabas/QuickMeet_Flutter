import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String label1;
  final String label2;
  final String label3;
  final String label4;

  CustomCard({
    super.key,
    required this.label1,
    required this.label2,
    required this.label3,
    required this.label4,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label1,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(label2),
                ],
              ),
              SizedBox(height: 8.0), // Add spacing between rows
              // Second Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label3,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(label4),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}