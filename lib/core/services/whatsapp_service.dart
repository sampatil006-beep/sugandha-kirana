import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  const WhatsAppService();

  Future<bool> openChat({
    required String mobile,
    required String message,
  }) async {
    final number = _normalizeNumber(mobile);

    if (number == null) {
      return false;
    }

    final url = Platform.isAndroid
        ? Uri.parse(
      'https://wa.me/$number?text=${Uri.encodeComponent(message)}',
    )
        : Uri.parse(
      'https://wa.me/$number?text=${Uri.encodeComponent(message)}',
    );

    return launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  String? _normalizeNumber(String mobile) {
    var value = mobile.replaceAll(RegExp(r'\D'), '');

    if (value.isEmpty) {
      return null;
    }

    if (value.length == 10) {
      value = '91$value';
    }

    return value;
  }
}