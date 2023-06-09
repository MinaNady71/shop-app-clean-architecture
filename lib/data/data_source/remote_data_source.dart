import 'package:flutter_advanced_clean_architecture/data/network/app_api.dart';
import 'package:flutter_advanced_clean_architecture/data/network/requests.dart';

import '../responses/responses_data.dart';

abstract class RemoteDataSource{
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<ResetPasswordResponse> resetPassword(String email);
  Future<HomeResponse> getHomeData();
  Future<StoresDetailsResponse> getStoreDetailsData();
}


class RemoteDataSourceImpl implements RemoteDataSource{
  final AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async{
    return await _appServiceClient.login(loginRequest.email, loginRequest.password);
  }

  @override
  Future<ResetPasswordResponse> resetPassword(String email)async {
    
    return await _appServiceClient.resetPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest) async{
    return await _appServiceClient.register(
        registerRequest.userName,
        registerRequest.countyMobileCode,
        registerRequest.number,
        registerRequest.email,
        registerRequest.password,
        "");
  }

  @override
  Future<HomeResponse> getHomeData()async {
    return await _appServiceClient.getHomeData();
  }

  @override
  Future<StoresDetailsResponse> getStoreDetailsData()async{
      return  await _appServiceClient.getStoreDetailsData();
  }

}