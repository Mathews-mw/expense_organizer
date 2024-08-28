import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const AdaptiveButton(
      {super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(onPressed: onPressed, child: Text(label))
        : ElevatedButton(onPressed: onPressed, child: Text(label));
  }
}
