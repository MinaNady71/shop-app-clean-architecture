
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter_advanced_clean_architecture/domain/model/models.dart';
import 'package:meta/meta.dart';
import '../../../domain/usecase/store_details_usecase.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

part 'stores_event.dart';
part 'stores_state.dart';

class StoresBloc extends Bloc<StoresEvent, StoresState>{
  final StoreDetailsUseCase _storeDetailsUseCase;

  StoresBloc(this._storeDetailsUseCase) : super(StoresInitial()) {

    on<StoresEvent>((event, emit)async {
      if(event is GetStoreDetailsDataEvent){
        emit(LoadingStoreDetailsState());
        (await _storeDetailsUseCase.execute(Void))
            .fold((error){
          emit(ErrorStoreDetailsState(ErrorState(error.message, StateRendererType.fullScreenErrorState)));
        },
        (storeDetails)async{
          //Show store details screen.
          emit(SuccessStoreDetailsState(storeDetails));

        }
        );
      }
    });
  }
  @override
  void onTransition(Transition<StoresEvent, StoresState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
