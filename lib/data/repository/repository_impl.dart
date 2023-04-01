import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_advanced_clean_architecture/data/data_source/remote_data_source.dart';
import 'package:flutter_advanced_clean_architecture/data/mapper/mapper.dart';
import 'package:flutter_advanced_clean_architecture/data/network/error_handler.dart';
import 'package:flutter_advanced_clean_architecture/data/network/failure.dart';
import 'package:flutter_advanced_clean_architecture/data/network/network_info.dart';
import 'package:flutter_advanced_clean_architecture/data/network/requests.dart';
import 'package:flutter_advanced_clean_architecture/domain/model/models.dart';
import 'package:flutter_advanced_clean_architecture/domain/repository/repository.dart';

import '../data_source/local_data_source.dart';

class RepositoryImpl implements Repository{
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo,this._localDataSource);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
      if(await _networkInfo.isConnected){
        // its connected call api
      try{
        final response = await _remoteDataSource.login(loginRequest);
        if(response.status == ApiInternalStatus.SUCCESS){
          //success
          // Either right
          //return data
          return Right(response.toDomain());
        }else{
          // failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE, response.messages ?? ResponseMessage.DEFAULT.tr()));

        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }
      }else{
        // return internet connection error
        return  Left(DataSource.NO_INTERNET_CONNECTION.getFailure());

      }
  }

  @override
  Future<Either<Failure, String>> resetPassword(String email)async {
    if(await _networkInfo.isConnected){
      try{
        final response = await _remoteDataSource.resetPassword(email);
        if(response.status == ApiInternalStatus.SUCCESS){
          return Right(response.toDomain());
        }else{
          return Left(Failure(response.status ?? ResponseCode.DEFAULT, response.messages ?? ResponseMessage.DEFAULT.tr()));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest) async{
    if(await _networkInfo.isConnected){
      // its connected call api
      try{
        final response = await _remoteDataSource.register(registerRequest);
        if(response.status == ApiInternalStatus.SUCCESS){
          //success
          // Either right
          //return data
          return Right(response.toDomain());
        }else{
          // failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE, response.messages ?? ResponseMessage.DEFAULT.tr()));

        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }
    }else{
      // return internet connection error
      return  Left(DataSource.NO_INTERNET_CONNECTION.getFailure());

    }
  }

  @override
  Future<Either<Failure,HomeObject>> getHomeData() async{
    try{
      //get response from cache
      final response = await _localDataSource.getHomeData();
      return Right(response.toDomain());
    }catch(_){
      // cache is not existing or cache is not valid
      //so get response form api
      if(await _networkInfo.isConnected){
        // its connected call api
        try{
          final response = await _remoteDataSource.getHomeData();
          if(response.status == ApiInternalStatus.SUCCESS){
            //success
            // Either right
            //return data
            // save home response in cache (local data source)
            _localDataSource.saveHomeCache(response);
            return Right(response.toDomain());
          }else{
            // failure
            //return either left
            return Left(Failure(ApiInternalStatus.FAILURE, response.messages ?? ResponseMessage.DEFAULT.tr()));

          }
        }catch(error){
          return Left(ErrorHandler.handle(error).failure);
        }
      }else{
        // return internet connection error
        return  Left(DataSource.NO_INTERNET_CONNECTION.getFailure());

      }
    }

  }

  @override
  Future<Either<Failure, StoresDetails>> getStoresDetailsData() async{
     try{
      final response = await _localDataSource.getStoreDetailsData();
               return Right(response.toDomain());
     }catch(_){
       // cache is not existing or cache is not valid
       //so get response form api
       if(await _networkInfo.isConnected){
         try{
           final response = await _remoteDataSource.getStoreDetailsData();
           if(response.status == ApiInternalStatus.SUCCESS){
             //success
             // Either right
             //return data
             // save home response in cache (local data source)
             _localDataSource.saveStoreDetailsCache(response);
             return Right(response.toDomain());

           }else{
             // failure
             //return either left
             return Left(Failure(ApiInternalStatus.FAILURE, response.messages ?? ResponseMessage.DEFAULT.tr()));
           }
         }catch(error){
           return Left(ErrorHandler.handle(error).failure);
         }
       }else{
         return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
       }
     }
  }
}