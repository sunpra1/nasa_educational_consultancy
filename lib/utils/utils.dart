import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

import '../widgets/progress_dialog.dart';

class Utils {
  static Future<Position?> getCurrentLocation(BuildContext context) async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          title: const Text(""),
          content: const Text(""),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(""))
          ],
        ),
      );
      return null;
    }

    if (await Geolocator.checkPermission() == LocationPermission.denied &&
        await Geolocator.requestPermission() == LocationPermission.denied) {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          title: const Text(""),
          content: const Text(""),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(""),
            )
          ],
        ),
      );
      return null;
    } else {
      return await Geolocator.getCurrentPosition();
    }
  }

  static Future<void> getDirections(
    BuildContext context,
    double latitude,
    double longitude,
  ) async {
    NavigatorState navigatorState = Navigator.of(context);
    showDialog(
        context: context, builder: (_) => const ProgressDialog(message: ""));
    Position? position = await getCurrentLocation(context);
    if (position != null) {
      Uri? url = Uri.tryParse(
          'https://www.google.com/maps/dir/?api=1&origin=${position.latitude},${position.longitude}&destination=$latitude,$longitude&travelmode=driving&dir_action=navigate');
      if (url != null && await launcher.canLaunchUrl(url)) {
        await launcher.launchUrl(url);
      }
    }
    navigatorState.pop();
  }

  static Future<void> openLink(BuildContext context, String link) async {
    Uri? url = Uri.tryParse(link);
    if (url != null && await launcher.canLaunchUrl(url)) {
      await launcher.launchUrl(url,
          mode: launcher.LaunchMode.externalNonBrowserApplication);
    } else {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("FAILED"),
          content: const Text("Unable to open link."),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"))
          ],
        ),
      );
    }
  }

  static Future<void> makeCall(BuildContext context, String phoneNumber) async {
    final Uri callLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await launcher.canLaunchUrl(callLaunchUri)) {
      await launcher.launchUrl(callLaunchUri);
    } else {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("FAILED"),
          content: const Text("Unable make phone call."),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"))
          ],
        ),
      );
    }
  }

  static Future<void> sendEmail(BuildContext context, String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await launcher.canLaunchUrl(emailLaunchUri)) {
      await launcher.launchUrl(emailLaunchUri);
    } else {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("FAILED"),
          content: const Text(
              "Unable to launch mail app. Provided email may not be valid."),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"))
          ],
        ),
      );
    }
  }
}