import 'dart:async';
import 'dart:ffi';

import 'package:flutter_advanced_clean_architecture/domain/model/models.dart';
import 'package:flutter_advanced_clean_architecture/domain/usecase/store_details_usecase.dart';
import 'package:flutter_advanced_clean_architecture/presentation/base/base_view_model.dart';
import 'package:flutter_advanced_clean_architecture/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_advanced_clean_architecture/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewModel extends BaseViewModel with InputStoreDetailsViewModel,OutputStoreDetailsViewModel {
  final StreamController _storeDetailsStreamController = BehaviorSubject<StoresDetails>();
  final StoreDetailsUseCase _storeDetailsUseCase;
  StoreDetailsViewModel(this._storeDetailsUseCase);

  // input

  @override
  void start()async {
    _getStoreDetailsData();
  }

  _getStoreDetailsData()async{
    inputStates.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));

    (await _storeDetailsUseCase.execute(Void))
        .fold((error){
      inputStates.add(ErrorState(error.message, StateRendererType.fullScreenErrorState));
    },
            (storeDetails)async{
              //content
              inputStoreDetails.add(storeDetails);
              //Show store details screen
              inputStates.add(ContentState());
            }
    );


  }


  @override
  void dispose() {
    _storeDetailsStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;



// output
  @override
  Stream<StoresDetails> get outputStoreDetails => _storeDetailsStreamController.stream.map((storeDetails) => storeDetails);

}

// input
abstract class InputStoreDetailsViewModel {
  Sink get inputStoreDetails;
}
// output
abstract class OutputStoreDetailsViewModel {
  Stream<StoresDetails> get outputStoreDetails;

}
