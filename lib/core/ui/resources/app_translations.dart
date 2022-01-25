import 'package:birthday_gift/generated/l10n.dart';
import 'package:flutter/widgets.dart';

extension TranslationsExtension on BuildContext {
  S get strings {
    return S.of(this);
  }
}
