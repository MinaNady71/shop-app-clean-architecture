import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_clean_architecture/presentation/main/pages/home/view/home_page.dart';
import 'package:flutter_advanced_clean_architecture/presentation/main/pages/notification_page.dart';
import 'package:flutter_advanced_clean_architecture/presentation/main/pages/search_page.dart';
import 'package:flutter_advanced_clean_architecture/presentation/main/pages/setttings/settings_pages.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/color_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationPage(),
    const SettingsPage()
  ];

  List<String> titles = [
    AppStrings.homePage.tr(),
    AppStrings.searchPage.tr(),
    AppStrings.notificationPage.tr(),
    AppStrings.settingsPage.tr(),
  ];

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_currentIndex],style: Theme.of(context).textTheme.titleSmall,),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: ColorManager.black,spreadRadius: AppSize.s0_5),]
        ),
        child: BottomNavigationBar(
            selectedItemColor: ColorManager.primary,
            unselectedItemColor:ColorManager.grey ,
            currentIndex: _currentIndex,
            onTap: onTap,
            items:  [
              BottomNavigationBarItem(icon: const Icon(Icons.home_outlined),label: AppStrings.homePage.tr()),
              BottomNavigationBarItem(icon: const Icon(Icons.search),label: AppStrings.searchPage.tr()),
              BottomNavigationBarItem(icon: const Icon(Icons.notifications_active_outlined),label: AppStrings.notificationPage.tr()),
              BottomNavigationBarItem(icon: const Icon(Icons.settings),label: AppStrings.settingsPage.tr()),
            ],
        ),
      ),
    );
  }

  onTap(int index){
    setState(() {
      _currentIndex = index;
    });
  }

}
