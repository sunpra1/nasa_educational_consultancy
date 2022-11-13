import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast {
  final BuildContext context;

  const ShowToast({required this.context});

  void show(String message) {
    FToast fToast = FToast().init(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48.0),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.9),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
          const SizedBox(
            width: 8.0,
          ),
          Flexible(
            child: FittedBox(
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 3),
    );
  }
}
