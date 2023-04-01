import 'package:flutter/material.dart';

enum LanguageType{
 ENGLISH,
 ARABIC
}
const String ENGLISH = 'en';
const String ARABIC = 'ar';
const String ASSTE_PATH_LOCALISATION = "assets/translations";
const Locale ENGLISH_LOCALE = Locale('en','US');
const Locale ARABIC_LOCALE = Locale('ar','EG');

extension LanguageTypeExtension on LanguageType{
 String getValue(){
  switch(this){
    case LanguageType.ENGLISH:
      return ENGLISH;
    case LanguageType.ARABIC:
     return ARABIC;
  }
 }
}