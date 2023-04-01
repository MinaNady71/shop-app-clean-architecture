

import 'package:dartz/dartz.dart';
import 'package:flutter_advanced_clean_architecture/data/network/failure.dart';
import 'package:flutter_advanced_clean_architecture/domain/repository/repository.dart';
import 'package:flutter_advanced_clean_architecture/domain/usecase/base_usecase.dart';


// UseCase it is like a bridge from domain layer to data layer
// So we will create UseCase.dart in domain layer and it will take data from presentation then send it to data layer and vice versa

class ResetPasswordUseCase implements BaseUseCase<String,String>{
  final Repository _repository;

  ResetPasswordUseCase(this._repository);
  @override
  Future<Either<Failure, String>> execute(String email)async {
    return await _repository.resetPassword(email);
  }
  
}