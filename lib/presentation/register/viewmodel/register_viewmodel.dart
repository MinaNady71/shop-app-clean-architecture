
import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_advanced_clean_architecture/domain/usecase/register_usecase.dart';
import 'package:flutter_advanced_clean_architecture/presentation/base/base_view_model.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/strings_manager.dart';

import '../../../app/functions.dart';
import '../../common/freezed_data_classes.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';


class RegisterViewModel extends BaseViewModel with RegisterViewModelInput,RegisterViewModelOutput{
  StreamController usernameStreamController = StreamController<String>.broadcast();
  StreamController mobileNumberStreamController = StreamController<String>.broadcast();
  StreamController emailStreamController = StreamController<String>.broadcast();
  StreamController passwordStreamController = StreamController<String>.broadcast();
  StreamController profilePictureStreamController = StreamController<File>.broadcast();
  StreamController areAllInputValidStreamController = StreamController<bool>.broadcast();
  StreamController isUserRegisterSuccessfullyStreamController =StreamController<bool>();


  var registerObject = RegisterObject('', AppStrings.countryCodeDefault, '', '', '', '');
  final RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);


  @override
  void start() {
  inputStates.add(ContentState());
  }
  // input
  @override
  void dispose() {
    usernameStreamController.close();
    mobileNumberStreamController.close();
    emailStreamController.close();
    passwordStreamController.close();
    profilePictureStreamController.close();
    areAllInputValidStreamController.close();
    isUserRegisterSuccessfullyStreamController.close();
    super.dispose();
  }


  @override
  Sink get inputEmail => emailStreamController.sink;

  @override
  Sink get inputNumber => mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => profilePictureStreamController.sink;

  @override
  Sink get inputUsername => usernameStreamController.sink;

  @override
  Sink get inputAllInputsValid => areAllInputValidStreamController.sink;

  @override
  register()async {
    inputStates.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _registerUseCase.execute(RegisterUseCaseInput(
        registerObject.userName,
        registerObject.countyMobileCode,
        registerObject.number,
        registerObject.email,
        registerObject.password,
        registerObject.profilePicture
    ))).
    fold((failure) {
      inputStates.add(ErrorState(failure.message, StateRendererType.popupErrorState));
    },
            (data) {
          //content
          inputStates.add(ContentState());
          // you have to show main screen
          isUserRegisterSuccessfullyStreamController.add(true);
        }
    );
  }

  @override
  setUsername(String username) {
    inputUsername.add(username);
    if(_isUsernameValid(username)){
      registerObject = registerObject.copyWith(userName: username);
    }else{
      registerObject = registerObject.copyWith(userName: "");
    }
    _validate();
  }

  @override
  setCountryCode(String countryCode) {
    if(countryCode.isNotEmpty && countryCode != ""){
      //update
      registerObject = registerObject.copyWith(countyMobileCode: countryCode);
    }else{
      //reset
      registerObject = registerObject.copyWith(countyMobileCode: AppStrings.countryCodeDefault);
    }
    _validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if(isEmailValid(email)){
      //update
      registerObject = registerObject.copyWith(email: email);
    }else{
      //reset
      registerObject = registerObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputNumber.add(mobileNumber);
    if(_isMobileNumberValid(mobileNumber)){
      //update
      registerObject = registerObject.copyWith(number: mobileNumber);
    }else{
      //reset
      registerObject = registerObject.copyWith(number: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if(_isPasswordValid(password)){
      //update
      registerObject = registerObject.copyWith(password: password);
    }else{
      //reset
      registerObject = registerObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if(profilePicture.path.isNotEmpty){
      //update
      registerObject = registerObject.copyWith(profilePicture: profilePicture.path);
    }else{
      //reset
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    _validate();
  }


  //-- output


  @override
  Stream<bool> get outputIsUsernameValid => usernameStreamController.stream.map((username) => _isUsernameValid(username));
  @override
  Stream<String?> get outputErrorUsername => outputIsUsernameValid.map((isUsername) => isUsername? null :AppStrings.usernameInvalid.tr());

  @override
  Stream<bool> get outputIsEmailValid => emailStreamController.stream.map((email) => isEmailValid(email));
  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid.map((isEmail) => isEmail? null: AppStrings.emailInvalid.tr());

  @override
  Stream<bool> get outputIsPasswordValid => passwordStreamController.stream.map((password) => _isPasswordValid(password));
  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid.map((isPassword) => isPassword? null: AppStrings.passwordInvalid.tr());

  @override
  Stream<bool> get outputIsMobileNumberValid => mobileNumberStreamController.stream.map((mobileNumber) => _isMobileNumberValid(mobileNumber));
  @override
  Stream<String?> get outputErrorNumber => outputIsMobileNumberValid.map((isMobileNumber) => isMobileNumber? null: AppStrings.mobileNumberInvalid.tr());


  @override
  Stream<File> get outputIsProfilePicture => profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputAreAllInputsValid => areAllInputValidStreamController.stream.map((_) => _areAllInputsValid());

  //-- private function
  bool  _isUsernameValid(String username){
      return username.length >= 8;
  }
  bool  _isPasswordValid(String password){
      return password.length >= 6;
  }
  bool  _isMobileNumberValid(String mobileNumber){
    return mobileNumber.length >= 11;
  }
   bool  _areAllInputsValid(){
    return registerObject.userName.isNotEmpty &&
        registerObject.number.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
       // registerObject.countyMobileCode.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty;
   }
   _validate(){
    inputAllInputsValid.add(true);
   }
  }




abstract class RegisterViewModelInput{
  Sink get  inputUsername;
  Sink get  inputNumber;
  Sink get  inputEmail;
  Sink get  inputPassword;
  Sink get  inputProfilePicture;
  Sink get  inputAllInputsValid;


  setUsername(String username);
  setCountryCode(String countryCode);
  setMobileNumber(String mobileNumber);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File profilePicture);

  register();

}




abstract class RegisterViewModelOutput{
  Stream<bool>   get  outputIsUsernameValid;
  Stream<String?> get  outputErrorUsername;

  Stream<bool>   get  outputIsMobileNumberValid;
  Stream<String?> get  outputErrorNumber;

  Stream<bool>   get  outputIsEmailValid;
  Stream<String?> get  outputErrorEmail;

  Stream<bool>   get  outputIsPasswordValid;
  Stream<String?> get  outputErrorPassword;

  Stream<File>   get  outputIsProfilePicture;

  Stream<bool>   get  outputAreAllInputsValid;

}