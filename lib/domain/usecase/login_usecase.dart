import 'package:dartz/dartz.dart';
import 'package:flutter_advanced_clean_architecture/data/network/failure.dart';
import 'package:flutter_advanced_clean_architecture/data/network/requests.dart';
import 'package:flutter_advanced_clean_architecture/domain/model/models.dart';
import 'package:flutter_advanced_clean_architecture/domain/repository/repository.dart';
import 'package:flutter_advanced_clean_architecture/domain/usecase/base_usecase.dart';

// UseCase it is like a bridge from domain layer to data layer
// So we will create UseCase.dart in domain layer and it will take data from presentation then send it to data layer and vice versa

class LoginUseCase implements BaseUseCase<LoginUseCaseInput,Authentication>{
  final Repository _repository;

  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input)async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(this.email,this.password);
}