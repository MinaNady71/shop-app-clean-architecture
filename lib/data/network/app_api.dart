
import 'package:flutter_advanced_clean_architecture/app/constants.dart';
import 'package:flutter_advanced_clean_architecture/data/responses/responses_data.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'app_api.g.dart';

// flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs


@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient{
factory AppServiceClient(Dio dio,{String? baseUrl}) = _AppServiceClient;

@POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,@Field("password") String password
    );
@POST("/customers/forgotPassword")
Future<ResetPasswordResponse> resetPassword(@Field("email") String email);

@POST("/customers/register")
Future<AuthenticationResponse> register(
    @Field("user_name") String userName,
    @Field("county_mobile_code") String countyMobileCode,
    @Field("number") String number,
    @Field("email") String email,
    @Field("password") String password,
    @Field("profile_picture") String profilePicture,
    );

@GET("/home")
Future<HomeResponse> getHomeData();

@GET("/storeDetails/1")
Future<StoresDetailsResponse> getStoreDetailsData();

}

