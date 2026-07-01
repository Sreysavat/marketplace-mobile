import 'package:flutter/material.dart';

import 'colors.dart';

class ButtonReusable extends StatelessWidget {
  const ButtonReusable({
    super.key,
    required this.isLoading, required this.action, this.textBtt = 'Sign In', this.width=double.infinity,
  });

  final bool isLoading;
  final VoidCallback action;
  final String textBtt;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
        ),
        onPressed: isLoading ? null
            : action,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Text(
          textBtt,
          style: TextStyle(color: AppColors.withe),
        ),
      ),
    );
  }
}