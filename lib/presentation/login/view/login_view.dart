import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_advanced_clean_architecture/app/di.dart';
import 'package:flutter_advanced_clean_architecture/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/color_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/values_manager.dart';

import '../../../app/app_prefs.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final TextEditingController _usernameController =TextEditingController();
  final TextEditingController _passwordController =TextEditingController();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final _formKey = GlobalKey<FormState>();
  _bind(){
    _viewModel.start();
    _usernameController.addListener(()=> _viewModel.setUsername(_usernameController.text));
    _passwordController.addListener(()=> _viewModel.setPassword(_passwordController.text));
    _viewModel.isUserLoggedSuccessfullyStreamController.stream.listen((isLoggedIn) {
      if(isLoggedIn) {
        //navigate to main screen
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setUserLoggedInOrRegistered();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }

    });
  }
  @override
  void initState() {
    _bind();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
          stream:_viewModel.outputStates ,
          builder: (context,snapshot){
            return snapshot.data?.getScreenWidget(context,_getContentWidget(),(){
              _viewModel.login();
            }) ?? _getContentWidget();
          }
      ),
    );
  }
  _getContentWidget(){
    return  Container(
        padding: const EdgeInsets.only(top:AppPadding.p100),
        child: SingleChildScrollView(
          child: Form(
            key:_formKey ,
              child: Column(
                children: [
                  const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
                   const SizedBox(height: AppSize.s28,),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                    child:StreamBuilder<bool>(
                       stream: _viewModel.outputIsUserNameValid,
                        builder:(context,snapshot){
                         return TextFormField(
                           keyboardType: TextInputType.emailAddress,
                           controller: _usernameController,
                           decoration: InputDecoration(
                             hintText: AppStrings.username.tr(),
                             labelText: AppStrings.username.tr(),
                             errorText: (snapshot.data ?? true) ? null : AppStrings.usernameError.tr()
                           ),

                         );
                        } ,
                    ) ,
                  ),
                  const SizedBox(height: AppSize.s28,),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                    child:StreamBuilder<bool>(
                      stream: _viewModel.outputIsPasswordValid,
                      builder:(context,snapshot){
                        return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              hintText: AppStrings.password.tr(),
                              labelText: AppStrings.password.tr(),
                              errorText: (snapshot.data ?? true) ? null : AppStrings.passwordError.tr()
                          ),

                        );
                      } ,
                    ) ,
                  ),
                  const SizedBox(height: AppSize.s28,),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                    child:StreamBuilder<bool>(
                      stream: _viewModel.outputsAreAllOutputsValid,
                      builder:(context,snapshot){
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                              onPressed:(snapshot.data ?? false) ? (){
                                _viewModel.login();
                              }
                                : null,
                              child: Text(AppStrings.login.tr()),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSize.s28,),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28,vertical: AppPadding.p8),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: (){
                              Navigator.pushNamed(context, Routes.resetPasswordRoute);
                            },
                            child:  Text(
                              AppStrings.forgetPassword.tr(),
                              textAlign: TextAlign.end,
                              style: Theme.of(context).textTheme.titleMedium,
                            )),
                        TextButton(
                            onPressed: (){
                              Navigator.pushNamed(context, Routes.registerRoute);
                            },
                            child:  Text(
                              AppStrings.registerText.tr(),
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,  // TODO remove it later
                              style: Theme.of(context).textTheme.titleMedium,
                            ))
                      ],
                    ),
                  ),
                ],
              )
          ),
        ),
      );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
