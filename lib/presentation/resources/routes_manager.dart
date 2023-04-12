import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_clean_architecture/presentation/forget_password/view/reset_password_view.dart';
import 'package:flutter_advanced_clean_architecture/presentation/login/view/login_view.dart';
import 'package:flutter_advanced_clean_architecture/presentation/main/main_view.dart';
import 'package:flutter_advanced_clean_architecture/presentation/onboarding/view/onboarding_view.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/splash/splash_view.dart';
import 'package:flutter_advanced_clean_architecture/presentation/store_details/view/store_details_view.dart';
import 'package:flutter_advanced_clean_architecture/presentation/web_view/web_view.dart';

import '../../app/di.dart';
import '../register/view/register_view.dart';

class Routes{
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String resetPasswordRoute = "/resetPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String webViewContactUsRoute = "/webViewContactUsRoute";
}

class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings settings){
    switch (settings.name){
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_)=> const SplashView());
        case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_)=> const OnBoardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_)=> const LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_)=> const RegisterView());
      case Routes.resetPasswordRoute:
        initResetPasswordModule();
        return MaterialPageRoute(builder: (_)=> const ResetPasswordView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_)=> const MainView());
      case Routes.storeDetailsRoute:
        //initStoreDetailsModule();
        initStoreDetailsBloc();
        return MaterialPageRoute(builder: (_)=>  const StoreDetailsView());
        case Routes.webViewContactUsRoute:
        return MaterialPageRoute(builder: (_)=> const WebViewPage());
      default:
        return unDefinedRoute();
    }
  }
  static Route<dynamic> unDefinedRoute(){
    return MaterialPageRoute(
      builder: (_)=>
       Scaffold(
        appBar: AppBar(
          title:  Text(AppStrings.noRouteFound.tr()), // todo move this string to strings manager
        ),
        body:  Center(child: Text(AppStrings.noRouteFound.tr())),
      ),
    );
  }
}