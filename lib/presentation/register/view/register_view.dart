import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_advanced_clean_architecture/app/app_prefs.dart';
import 'package:flutter_advanced_clean_architecture/app/di.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/color_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/values_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';
import '../viewmodel/register_viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();

  final TextEditingController _usernameController =TextEditingController();
  final TextEditingController _passwordController =TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _numberController =TextEditingController();
  AppPreferences _appPreferences = instance<AppPreferences>();
  final _formKey = GlobalKey<FormState>();
  _bind(){
    _viewModel.start();
    _usernameController.addListener(()=> _viewModel.setUsername(_usernameController.text));
    _passwordController.addListener(()=> _viewModel.setPassword(_passwordController.text));
    _emailController.addListener(()=> _viewModel.setEmail(_emailController.text));
    _numberController.addListener(()=> _viewModel.setMobileNumber(_numberController.text));

    _viewModel.isUserRegisterSuccessfullyStreamController.stream.listen((isRegistered) {
      if(isRegistered) {

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
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor:ColorManager.white,
        iconTheme: IconThemeData(
          color: ColorManager.primary
        ),
      ),
      body: StreamBuilder<FlowState>(
          stream:_viewModel.outputStates ,
          builder: (context,snapshot){
            return snapshot.data?.getScreenWidget(context,_getContentWidget(),(){
              _viewModel.register();
            }) ?? _getContentWidget();
          }
      ),
    );
  }
  _getContentWidget(){
    return  Container(
        padding: const EdgeInsets.only(top:AppPadding.p18),
        child: SingleChildScrollView(
          child: Form(
            key:_formKey ,
              child: Column(
                children: [
                   Center(
                       child:StreamBuilder<File>(
                    stream:_viewModel.outputIsProfilePicture ,
                    builder: (context,snapshot){
                        return  _imagePickedByUser(snapshot.data);
                    },
                  ),),

                   const SizedBox(height: AppSize.s18,),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                    child:StreamBuilder<String?>(
                       stream: _viewModel.outputErrorUsername,
                        builder:(context,snapshot){
                         return TextFormField(
                           keyboardType: TextInputType.name,
                           controller: _usernameController,
                           decoration: InputDecoration(
                             hintText: AppStrings.username.tr(),
                             labelText: AppStrings.username.tr(),
                             errorText: snapshot.data
                           ),

                         );
                        } ,
                    ) ,
                  ),
                  const SizedBox(height: AppSize.s18,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                    child:Center(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                          child: CountryCodePicker(
                            padding: EdgeInsets.zero,
                            initialSelection: "+20",
                            favorite: const ['US','FR',"EG"],
                            showCountryOnly: true,
                            hideMainText: true,
                            showOnlyCountryWhenClosed: true,
                            onChanged: (countryCode){
                              _viewModel.setCountryCode(countryCode.dialCode ?? AppStrings.countryCodeDefault);
                          }
                           ),
                          ),
                          Expanded(
                            flex: 4,
                            child: StreamBuilder<String?>(
                              stream: _viewModel.outputErrorNumber,
                              builder:(context,snapshot){
                                return TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _numberController,
                                  decoration: InputDecoration(
                                      hintText: AppStrings.mobileNumber.tr(),
                                      labelText: AppStrings.mobileNumber.tr(),
                                      errorText: snapshot.data
                                  ),

                                );
                              } ,
                            ),
                          ),
                        ],
                      ),
                    ) ,
                  ),
                  const SizedBox(height: AppSize.s18,),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                    child:StreamBuilder<String?>(
                      stream: _viewModel.outputErrorEmail,
                      builder:(context,snapshot){
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(
                              hintText: AppStrings.email.tr(),
                              labelText: AppStrings.email.tr(),
                              errorText: snapshot.data
                          ),
                        );
                      } ,
                    ) ,
                  ),
                  const SizedBox(height: AppSize.s18,),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                    child:StreamBuilder<String?>(
                      stream: _viewModel.outputErrorPassword,
                      builder:(context,snapshot){
                        return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              hintText: AppStrings.password.tr(),
                              labelText: AppStrings.password.tr(),
                              errorText: snapshot.data
                          ),
                        );
                      } ,
                    ) ,
                  ),
                  const SizedBox(height: AppSize.s18,),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                    child:Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
                        border:Border.all(color: ColorManager.grey),
                      ),
                      child: GestureDetector(
                        child: _getMediaWidget(),
                        onTap: (){
                          _showPicker(context);
                        },
                      ),
                    )
                    ) ,
                  const SizedBox(height: AppSize.s40,),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                    child:StreamBuilder<bool>(
                      stream: _viewModel.outputAreAllInputsValid,
                      builder:(context,snapshot){
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                              onPressed:(snapshot.data ?? false) ? (){
                                _viewModel.register();
                              }
                                : null,
                              child: Text(AppStrings.register.tr()),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSize.s18,),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: AppPadding.p18,vertical: AppPadding.p8),
                    child:TextButton(
                        onPressed: (){
                           Navigator.of(context).pop();
                        },
                        child:  Text(
                          AppStrings.loginText.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                  ),
                ],
              )
          ),
        ),
      );
  }

  _showPicker(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return SafeArea(
              child: Wrap(
                children:  [
                  ListTile(
                    trailing: const Icon(Icons.arrow_forward),
                    leading: const Icon(Icons.camera),
                    title:  Text(AppStrings.photoGallery.tr()),
                    onTap: (){
                      _imageFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    trailing: const Icon(Icons.arrow_forward),
                    leading: const Icon(Icons.camera_alt_outlined),
                    title:  Text(AppStrings.photoCamera.tr()),
                    onTap: (){
                      _imageFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
          );
        }
    );
  }
  _imageFromGallery()async{
  var iamge = await _imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(iamge?.path ?? ""));
  }

  _imageFromCamera()async{
    var iamge = await _imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(iamge?.path ?? ""));
  }
  _getMediaWidget(){
  return Padding(padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
        child:SizedBox(
          height: 45,
          child: Row(mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Flexible(child: Text(AppStrings.profilePicture.tr())),
            Flexible(child:SvgPicture.asset(ImageAssets.photoCameraIc)),
          ]),
        ) ,
  );
  }

  _imagePickedByUser(File? image){

    if(image != null && image.path.isNotEmpty){
      return CircleAvatar(backgroundImage: Image.file(image,fit: BoxFit.cover).image,radius: AppSize.s70,);
    }else{
      return const Image(image: AssetImage(ImageAssets.splashLogo));
    }
  }


  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
