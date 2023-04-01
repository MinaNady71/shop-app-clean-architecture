import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/assets_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/color_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/routes_manager.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../resources/constants_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay(){
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }
  _goNext(){
    _appPreferences.istUserLoggedInOrRegistered().then((istUserLoggedIn) {
      if(istUserLoggedIn){
        Navigator.pushReplacementNamed(context, Routes.mainRoute); //TODO change it later to main screen
      }else{
        _appPreferences.isOnBoardingViewed().then((isOnBoardingViewed){
          if(isOnBoardingViewed){
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          }else{
            Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
          }
        });
      }
    });
    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startDelay();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:ColorManager.primary,
      body: const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }
  @override
  void dispose() {
      _timer?.cancel();
    super.dispose();
  }
}
