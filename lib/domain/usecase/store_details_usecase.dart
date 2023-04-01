import 'package:dartz/dartz.dart';
import 'package:flutter_advanced_clean_architecture/data/network/failure.dart';
import 'package:flutter_advanced_clean_architecture/data/network/requests.dart';
import 'package:flutter_advanced_clean_architecture/domain/model/models.dart';
import 'package:flutter_advanced_clean_architecture/domain/repository/repository.dart';
import 'package:flutter_advanced_clean_architecture/domain/usecase/base_usecase.dart';

// UseCase it is like a bridge from domain layer to data layer
// So we will create UseCase.dart in domain layer and it will take data from presentation then send it to data layer and vice versa

class StoreDetailsUseCase implements BaseUseCase<void,StoresDetails>{
  final Repository _repository;

  StoreDetailsUseCase(this._repository);
  @override
  Future<Either<Failure, StoresDetails>> execute(void input)async {
    return _repository.getStoresDetailsData();

  }
}

