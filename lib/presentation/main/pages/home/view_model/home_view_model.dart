import 'dart:async';
import 'dart:ffi';

import 'package:flutter_advanced_clean_architecture/domain/model/models.dart';
import 'package:flutter_advanced_clean_architecture/presentation/base/base_view_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../domain/usecase/home_usecase.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';


class HomeViewModel extends BaseViewModel with HomeViewModelInput,HomeViewModelOutput{
    final StreamController _homeViewObject = BehaviorSubject<HomeViewObject>();


  final HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);

  // input
  @override
  void start(){
    _getHomeData();
  }

  _getHomeData()async{
    inputStates.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUseCase.execute(Void)).
    fold((failure) {
      inputStates.add(ErrorState(failure.message, StateRendererType.fullScreenLoadingState));
    },
            (homeObject) {
          //content
              inputHomeViewObject.add(HomeViewObject(homeObject.data.services, homeObject.data.banners, homeObject.data.stores));

          // you have to show main screen
              inputStates.add(ContentState());
        }
    );

  }

  @override
  void dispose() {
    _homeViewObject.close();
    super.dispose();
  }

  @override
  Sink get inputHomeViewObject => _homeViewObject.sink;


  // Output
  @override
  Stream<HomeViewObject> get outputSHomeViewObject => _homeViewObject.stream.map((homeViewObject) => homeViewObject);

}


abstract class HomeViewModelInput{
Sink get inputHomeViewObject;


}

abstract class HomeViewModelOutput{
  Stream<HomeViewObject> get outputSHomeViewObject;
}
class HomeViewObject{
  List<Store> store;
  List<BannerAd> bannerAd;
  List<Service> service;
  HomeViewObject(this.service,this.bannerAd,this.store);


}