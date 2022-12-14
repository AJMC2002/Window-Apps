import 'package:flutter/material.dart';

class TaskListBackground extends StatelessWidget {
  const TaskListBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 25,
        left: 50,
        right: 50,
        bottom: kFloatingActionButtonMargin,
      ),
      child: Column(
        children: List.filled(
          ((MediaQuery.of(context).size.height - 25) / 77).floor() - 1,
          Container(
            width: MediaQuery.of(context).size.width,
            height: 77,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 3,
                  color: Colors.deepPurpleAccent.shade100,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
