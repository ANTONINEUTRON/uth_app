import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
          Text(
              "Generated Drug Details",
            style: Theme.of(context).textTheme.headline5,
          ),

        ],
      ),
    );
  }
}
