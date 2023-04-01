import 'package:flutter_advanced_clean_architecture/data/network/failure.dart';
import 'package:flutter_advanced_clean_architecture/data/network/requests.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_advanced_clean_architecture/domain/model/models.dart';

abstract class Repository{
 Future<Either<Failure,Authentication>>  login(LoginRequest loginRequest);
 Future<Either<Failure,String>>  resetPassword(String email);
 Future<Either<Failure,Authentication>>  register(RegisterRequest registerRequest);
 Future<Either<Failure,HomeObject>>  getHomeData();
 Future<Either<Failure,StoresDetails>>  getStoresDetailsData();

}