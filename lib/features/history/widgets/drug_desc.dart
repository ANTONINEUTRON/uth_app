import 'package:flutter/material.dart';

class DrugDesc extends StatelessWidget {
  const DrugDesc({Key? key, required this.title, required this.desc,}) : super(key: key);

  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(width: 8,),
          Flexible(
              child: Text(
                  desc,
                style: Theme.of(context).textTheme.bodyMedium,
              )
          )
        ],
      ),
    );
  }
}
