import 'package:easy_localization/easy_localization.dart';
import 'package:fast_app_base/common/theme/custom_theme_app.dart';
import 'package:fast_app_base/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart';

import 'app.dart';
import 'common/data/preference/app_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await AppPreferences.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setLocaleMessages('ko', KoMessages());
  runApp(
    EasyLocalization(
      // supportedLocales: const [Locale('en'), Locale('ko')],
      supportedLocales: const [Locale('ko'), Locale('en')],
      // fallbackLocale: const Locale('en'),
      fallbackLocale: const Locale('ko'),
      path: 'assets/translations',
      useOnlyLangCode: true,
      child: const CustomThemeApp(
        child: App(),
      ),
    ),
  );
}
