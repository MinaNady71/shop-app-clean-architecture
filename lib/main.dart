import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_clean_architecture/app/app.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/language_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
      supportedLocales: const [ENGLISH_LOCALE, ARABIC_LOCALE],
      path: ASSTE_PATH_LOCALISATION,
      child: Phoenix(child:MyApp())));
}
