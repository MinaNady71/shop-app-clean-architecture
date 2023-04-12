import 'package:dio/dio.dart';
import 'package:flutter_advanced_clean_architecture/app/app_prefs.dart';
import 'package:flutter_advanced_clean_architecture/data/data_source/remote_data_source.dart';
import 'package:flutter_advanced_clean_architecture/data/network/app_api.dart';
import 'package:flutter_advanced_clean_architecture/data/network/dio_factory.dart';
import 'package:flutter_advanced_clean_architecture/data/network/network_info.dart';
import 'package:flutter_advanced_clean_architecture/data/repository/repository_impl.dart';
import 'package:flutter_advanced_clean_architecture/domain/repository/repository.dart';
import 'package:flutter_advanced_clean_architecture/domain/usecase/login_usecase.dart';
import 'package:flutter_advanced_clean_architecture/domain/usecase/register_usecase.dart';
import 'package:flutter_advanced_clean_architecture/domain/usecase/reset_password_usecase.dart';
import 'package:flutter_advanced_clean_architecture/domain/usecase/store_details_usecase.dart';
import 'package:flutter_advanced_clean_architecture/presentation/forget_password/view_model/reset_password_viewmodel.dart';
import 'package:flutter_advanced_clean_architecture/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:flutter_advanced_clean_architecture/presentation/store_details/stores_bloc/stores_bloc.dart';
import 'package:flutter_advanced_clean_architecture/presentation/store_details/view_model/sotre_details_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_source/local_data_source.dart';
import '../domain/usecase/home_usecase.dart';
import '../presentation/main/pages/home/view_model/home_view_model.dart';
import '../presentation/register/viewmodel/register_viewmodel.dart';

final instance = GetIt.instance;

Future<void> initAppModule()async{
  // app module its a module where we put all generic dependencies

  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

  //Dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();
  // app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(instance()));
  // local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
  // Repository
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance(),instance(), instance()));


}

 initLoginModule(){
  if(!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));

  }
}
  initRegisterModule(){
  if(!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(() => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());

  }
}
  initResetPasswordModule(){
  if(!GetIt.I.isRegistered<ResetPasswordUseCase>()) {
    instance.registerFactory<ResetPasswordUseCase>(() => ResetPasswordUseCase(instance()));
    instance.registerFactory<ResetPasswordViewModel>(() => ResetPasswordViewModel(instance()));
  }
}

initHomeModule(){
  if(!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}

initStoreDetailsModule(){
  if(!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
    instance.registerFactory<StoreDetailsUseCase>(() => StoreDetailsUseCase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(() => StoreDetailsViewModel(instance()));
  }
}

initStoreDetailsBloc(){
  if(!GetIt.I.isRegistered<StoresBloc>()) {
    //use case
    instance.registerLazySingleton<StoreDetailsUseCase>(() => StoreDetailsUseCase(instance()));
    // Bloc stores
    instance.registerLazySingleton<StoresBloc>(() => StoresBloc(instance()));

  }
}