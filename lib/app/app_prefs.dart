import 'package:flutter/material.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG ="PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED ="PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String PREFS_KEY_IS_USER_LOGGED_IN ="PREFS_KEY_IS_USER_LOGGED_IN";
class AppPreferences{
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);
  Future<String> getAppLanguage()async{
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
    if(language != null && language.isNotEmpty){
      return language;
    }else{
      // return default language
      return LanguageType.ENGLISH.getValue();
    }
  }

Future<void> changeAppLanguage()async{
  String currentLanguage = await getAppLanguage();
  if(currentLanguage == LanguageType.ARABIC.getValue()){
    //set english
    _sharedPreferences.setString(PREFS_KEY_LANG,LanguageType.ENGLISH.getValue());
  }else {
    //set arabic
    _sharedPreferences.setString(PREFS_KEY_LANG,LanguageType.ARABIC.getValue());

  }
}

  Future<Locale> getLocale()async{
    String currentLanguage = await getAppLanguage();
    if(currentLanguage == LanguageType.ARABIC.getValue()){
      //set english
      return ARABIC_LOCALE;
    }else {
      //set arabic
      return ENGLISH_LOCALE;

    }
  }


  // onBoarding
Future<void> setOnBoardingViewed()async{
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true);
}
  Future<bool> isOnBoardingViewed()async{
   return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED)?? false;
  }
  // login Screen
  Future<void> setUserLoggedInOrRegistered()async{
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }
  Future<bool> istUserLoggedInOrRegistered()async{
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN)?? false;
  }

  // logout Screen
  Future<void> setUserLogout()async{
    _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
  }

}