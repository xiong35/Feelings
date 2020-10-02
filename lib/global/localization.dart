import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

//Locale资源类
class FeelingsLocalization {
  FeelingsLocalization(this.isZh);
  bool isZh = false;

  static FeelingsLocalization of(BuildContext context) {
    return Localizations.of<FeelingsLocalization>(
        context, FeelingsLocalization);
  }

  //Locale相关值，title为应用标题
  String get title {
    return isZh ? "Feelings" : "Feelings";
  }

  String get tabNameMine {
    return isZh ? "我的" : "Mine";
  }
}

class FeelingsLocalizationsDelegate
    extends LocalizationsDelegate<FeelingsLocalization> {
  const FeelingsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<FeelingsLocalization> load(Locale locale) {
    print("$locale");
    return SynchronousFuture<FeelingsLocalization>(
        FeelingsLocalization(locale.languageCode == "zh"));
  }

  @override
  bool shouldReload(FeelingsLocalizationsDelegate old) => false;
}
