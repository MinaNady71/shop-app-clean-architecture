import 'package:dartz/dartz.dart';
import 'package:flutter_advanced_clean_architecture/data/network/failure.dart';
import 'package:flutter_advanced_clean_architecture/data/network/requests.dart';
import 'package:flutter_advanced_clean_architecture/domain/model/models.dart';
import 'package:flutter_advanced_clean_architecture/domain/repository/repository.dart';
import 'package:flutter_advanced_clean_architecture/domain/usecase/base_usecase.dart';

// UseCase it is like a bridge from domain layer to data layer
// So we will create UseCase.dart in domain layer and it will take data from presentation then send it to data layer and vice versa

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput,Authentication>{
  final Repository _repository;

  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(RegisterUseCaseInput input)async {
    return await _repository.register(RegisterRequest(
        input.userName,
        input.countyMobileCode,
        input.number,
        input.email,
        input.password,
        input.profilePicture));
  }
}

class RegisterUseCaseInput {
  String userName;
  String countyMobileCode;
  String number;
  String email;
  String password;
  String profilePicture;
  RegisterUseCaseInput(this.userName,this.countyMobileCode,this.number,this.email,this.password,this.profilePicture,);
}