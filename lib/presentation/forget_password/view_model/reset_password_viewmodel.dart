import 'dart:async';

import 'package:flutter_advanced_clean_architecture/domain/usecase/reset_password_usecase.dart';
import 'package:flutter_advanced_clean_architecture/presentation/base/base_view_model.dart';

import '../../../app/functions.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class ResetPasswordViewModel extends BaseViewModel with ResetPasswordInput,ResetPasswordOutput{
  final StreamController _resetPasswordStreamController = StreamController.broadcast();
  final StreamController _isInputValidStreamController = StreamController.broadcast();
  final ResetPasswordUseCase _resetPasswordUseCase;
  var email= "";

  ResetPasswordViewModel(this._resetPasswordUseCase);
  // input

  @override
  void dispose(){
    _resetPasswordStreamController.close();
    _isInputValidStreamController.close();
}
  @override
  void start() {
    inputStates.add(ContentState());
  }

  @override
  Sink get inputEmail => _resetPasswordStreamController.sink;
  @override
  Sink get isInputValid => _isInputValidStreamController.sink;

  @override
  resetPassword()async {
    inputStates.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _resetPasswordUseCase.execute(email))
        .fold((failure) => inputStates.add(ErrorState(failure.message, StateRendererType.popupErrorState)),
            (supportMessage) => inputStates.add(SuccessState(supportMessage,)));
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

// output
  @override
  Stream<bool> get outputIsEmailValid => _resetPasswordStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outputIsInputValid => _isInputValidStreamController.stream.map((isInputValid) => _isInputValid());

  bool _isInputValid(){
    return isEmailValid(email);
  }

  _validate(){
    isInputValid.add(null);
  }



}

abstract class ResetPasswordInput{
  setEmail(String enterEmail);
  resetPassword();

  Sink get inputEmail;
  Sink get isInputValid;
}

abstract class ResetPasswordOutput{
Stream<bool> get outputIsEmailValid;
Stream<bool> get outputIsInputValid;

}