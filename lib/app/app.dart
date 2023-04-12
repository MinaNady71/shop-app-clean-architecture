import 'package:flutter/material.dart';
import 'package:flutter_advanced_clean_architecture/app/app_prefs.dart';
import 'package:flutter_advanced_clean_architecture/app/di.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/routes_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/store_details/stores_bloc/stores_bloc.dart';

class MyApp extends StatefulWidget {
 // const MyApp({Key? key}) : super(key: key);
  // named Constructor
 const MyApp._internal();

 static const _instance = MyApp._internal();
 factory MyApp() => _instance;


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final AppPreferences _appPreferences =instance<AppPreferences>();
  @override
  void didChangeDependencies() {
    _appPreferences.getLocale().then((locale){
      context.setLocale(locale);
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       BlocProvider<StoresBloc>(create:(_)=> instance<StoresBloc>()..add(GetStoreDetailsDataEvent()))
      ],
      child: MaterialApp(
        localizationsDelegates:context.localizationDelegates ,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        onGenerateRoute: RouteGenerator.getRoute ,
          initialRoute: Routes.splashRoute,
          theme: getApplicationTheme(),
      ),
    );
  }
  
}

