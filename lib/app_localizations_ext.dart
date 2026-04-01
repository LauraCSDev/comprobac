import 'package:flutter/widgets.dart';

import 'generated/l10n.dart';

extension AppLocalizationsX on BuildContext {
  S get localizations {
    try {
      final s = S.maybeOf(this);
      if (s == null) {
        throw Exception('Localizations not found. Make sure S.delegate is added to MaterialApp localizationsDelegates.');
      }
      return s;
    } catch (e) {
      throw Exception('Error accessing localizations: $e');
    }
  }
}
