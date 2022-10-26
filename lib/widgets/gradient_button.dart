import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class GradientButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final Function() onPressed;

  const GradientButton({
    Key? key,
    this.width = double.infinity,
    this.height = 48.0,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: AppTheme.gradientLR,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              onTap: onPressed,
              child: Center(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
              )),
        ),
      ),
    );
  }
}
