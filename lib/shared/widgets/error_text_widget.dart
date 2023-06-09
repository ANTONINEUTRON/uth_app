import 'package:flutter/material.dart';

class ErrorTextWidget extends StatelessWidget {
  const ErrorTextWidget({
    Key? key,
    required this.errorMsg,
  }) : super(key: key);

  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:10.0),
      child: errorMsg.isEmpty
          ? Container()
          : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.warning, color: Colors.red.shade700,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  errorMsg,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.red.shade700
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
