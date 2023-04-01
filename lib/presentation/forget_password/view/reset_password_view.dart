import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_clean_architecture/app/di.dart';
import 'package:flutter_advanced_clean_architecture/presentation/forget_password/view_model/reset_password_viewmodel.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/color_manager.dart';

import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
 final _formKey = GlobalKey<FormState>();
 final TextEditingController _emailTextController = TextEditingController();
 final ResetPasswordViewModel _viewModel = instance<ResetPasswordViewModel>();
 bind(){
   _viewModel.start();
   _emailTextController.addListener(() { 
     _viewModel.setEmail(_emailTextController.text);
   });
 }

 @override
  void initState() {
      bind();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body:StreamBuilder<FlowState>(
          stream:_viewModel.outputStates ,
          builder: (context,snapshot){
            return snapshot.data?.getScreenWidget(context, _getContentWidget(), (){_viewModel.resetPassword();}) ?? _getContentWidget();
          }),
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
                    stream: _viewModel.outputIsEmailValid,
                    builder:(context,snapshot){
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailTextController,
                        decoration: InputDecoration(
                            hintText: AppStrings.email.tr(),
                            labelText: AppStrings.email.tr(),
                            errorText: (snapshot.data ?? true) ? null : AppStrings.emailInvalid.tr()
                        ),

                      );
                    } ,
                  ) ,
                ),
                const SizedBox(height: AppSize.s28,),
                Padding(padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child:StreamBuilder<bool>(
                    stream: _viewModel.outputIsInputValid,
                    builder:(context,snapshot){
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                          onPressed:(snapshot.data ?? false) ? (){
                            _viewModel.resetPassword();
                          }
                              : null,
                          child: Text(AppStrings.resetPassword.tr()),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSize.s28,),
                Padding(padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28,vertical: AppPadding.p8),
                  child:TextButton(
                      onPressed: (){
                     //   Navigator.pushNamed(context, Routes.resetPasswordRoute);
                      },
                      child:  Text(
                        AppStrings.resendPassword.tr(),
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.titleMedium,
                      )),
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