import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

// flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
@freezed
class LoginObject with _$LoginObject{
  factory LoginObject(String username,String password) = _LoginObject;

}

@freezed
class RegisterObject with _$RegisterObject{
  factory RegisterObject(
      String userName,
      String countyMobileCode,
      String number,
      String email,
      String password,
      String profilePicture
      ) = _RegisterObject;

}