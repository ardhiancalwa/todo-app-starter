import 'package:flutter/material.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/empty-box.png'),
          const SizedBox(height: 10),
          const Text(
            'Empty Data',
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}