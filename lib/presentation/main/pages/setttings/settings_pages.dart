import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_clean_architecture/app/app_prefs.dart';
import 'package:flutter_advanced_clean_architecture/app/di.dart';
import 'package:flutter_advanced_clean_architecture/data/data_source/local_data_source.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/color_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/routes_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/values_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../../../resources/language_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Center(
        child:ListView(
          padding: const EdgeInsets.all(AppPadding.p8),
          children:  [
             ListTile(
              title: Text(AppStrings.changeLanguage.tr(),style: Theme.of(context).textTheme.headlineMedium,),
              leading: Icon(Icons.settings,color: ColorManager.primary,),
              trailing: Icon(Icons.arrow_forward_ios_outlined,color: ColorManager.primary,),
              onTap: (){
                _changeLanguage();
              },
            ),
            ListTile(
              title: Text(AppStrings.contactUs.tr(),style: Theme.of(context).textTheme.headlineMedium,),
              leading: Icon(Icons.people_alt_outlined,color: ColorManager.primary,),
              trailing: Icon(Icons.arrow_forward_ios_outlined,color: ColorManager.primary,),
              onTap: (){
                _contactUs();
              },
            ),
            ListTile(
              title: Text(AppStrings.inviteYourFriends.tr(),style: Theme.of(context).textTheme.headlineMedium,),
              leading: Icon(Icons.share,color: ColorManager.primary,),
              trailing: Icon(Icons.arrow_forward_ios_outlined,color: ColorManager.primary,),
              onTap: (){
                _inviteFriends();
              },
            ),
            ListTile(
              title: Text(AppStrings.logout.tr(),style: Theme.of(context).textTheme.headlineMedium,),
              leading: Icon(Icons.logout,color: ColorManager.primary,),
              trailing: Icon(Icons.arrow_forward_ios_outlined,color: ColorManager.primary,),
              onTap: ()async{
                    _logOut();
              },
            ),
          ],
        )
    );
  }

_changeLanguage()async{
  _appPreferences.changeAppLanguage();
  Phoenix.rebirth(context);
}

_contactUs(){
  //TODO task to open webpage url
}

_inviteFriends(){
 // TODO share app name to friends
}
_logOut()async{
  // change login to false in Shared preference
  _appPreferences.setUserLogout();
  // clear cache
  _localDataSource.clearCache();
  // navigate to login screen
 Navigator.pushReplacementNamed(context, Routes.loginRoute);
}


}