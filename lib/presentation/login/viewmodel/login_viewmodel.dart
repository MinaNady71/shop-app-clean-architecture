import 'dart:async';

import 'package:flutter_advanced_clean_architecture/domain/usecase/login_usecase.dart';
import 'package:flutter_advanced_clean_architecture/presentation/base/base_view_model.dart';

import '../../common/freezed_data_classes.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';


class LoginViewModel extends BaseViewModel with LoginViewModelInput ,LoginViewModelOutput{

  final StreamController _userStreamController =StreamController<String>.broadcast();
  final StreamController _passwordStreamController =StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =StreamController<void>.broadcast();
  final StreamController isUserLoggedSuccessfullyStreamController =StreamController<bool>();
  var loginObject = LoginObject('', '');
 final LoginUseCase _loginUseCase;

 LoginViewModel(this._loginUseCase);

  // input

  @override
  void dispose() {
    super.dispose();
    _userStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  void start() {
    // view model should tell view please show content state
    inputStates.add(ContentState());
  }

  @override
  login()async {
    inputStates.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
   (await _loginUseCase.execute(LoginUseCaseInput(loginObject.username, loginObject.password))).
   fold((failure) {
     inputStates.add(ErrorState(failure.message, StateRendererType.popupErrorState));
   },
        (data) {
          //content
         inputStates.add(ContentState());
         // you have to show main screen
         isUserLoggedSuccessfullyStreamController.add(true);
        }
   );
  }
  @override
  setPassword(String password) {
   inputPassword.add(password);
   loginObject = loginObject.copyWith(password: password);
   _validate();
  }

  @override
  setUsername(String username) {
   inputUserName.add(username);
   loginObject = loginObject.copyWith(username:username);
   _validate();
  }
  @override
  Sink get inputUserName => _userStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputsAreAllInputsValid => _areAllInputsValidStreamController.sink ;

  // output




  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream.map((password) => isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userStreamController.stream.map((username) => isUsernameValid(username));

  @override
  Stream<bool> get outputsAreAllOutputsValid => _areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());
  
  bool isPasswordValid(String password){
    return password.isNotEmpty;
  }
  bool isUsernameValid(String username){
    return username.isNotEmpty;
  }

  bool _areAllInputsValid(){
    return isPasswordValid(loginObject.password) && isUsernameValid(loginObject.username);
  }

    _validate(){
      inputsAreAllInputsValid.add(null);
    }
}

abstract class LoginViewModelInput{
  setUsername(String username);
  setPassword(String password);
  login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputsAreAllInputsValid;
}

abstract class LoginViewModelOutput {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputsAreAllOutputsValid;
}