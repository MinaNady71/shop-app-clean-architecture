part of 'stores_bloc.dart';

@immutable
abstract class StoresState {}

class StoresInitial extends StoresState {}
class LoadingStoreDetailsState extends StoresState {}

class SuccessStoreDetailsState extends StoresState {
  final StoresDetails storeDetails;
  SuccessStoreDetailsState(this.storeDetails);
}
class ErrorStoreDetailsState extends StoresState {
  final ErrorState errorState;

  ErrorStoreDetailsState(this.errorState);
}
