import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_advanced_clean_architecture/domain/model/models.dart';
import 'package:flutter_advanced_clean_architecture/presentation/base/base_view_model.dart';

import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs,OnBoardingViewModelOutputs{
  //Stream Controller
   final StreamController _streamController = StreamController<SliderViewObject>();
   late final  List<SliderObject> _list;
   int _currentPageIndex = 0;


   // OnBoarding view model inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    // view model Let's go
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = ++ _currentPageIndex;
    if(nextIndex == _list.length ){
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int preciousIndex = -- _currentPageIndex;
    if(preciousIndex == -1 ){
      preciousIndex = _list.length -1;
    }
    return preciousIndex;
  }

  @override
  void onPageChanged(int index) {
      _currentPageIndex = index;
      _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;


      // on boarding view model outputs


  @override
  Stream<SliderViewObject> get outputSliderViwObject => _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // onboarding private functions
  void _postDataToView(){
    inputSliderViewObject.add(SliderViewObject(
        sliderObject: _list[_currentPageIndex],
        numbOfSlides:_list.length,
        currentIndex:_currentPageIndex
    ));
  }



  List<SliderObject> _getSliderData() => [
    SliderObject(
        AppStrings.onBoardingTitle1.tr(),
        AppStrings.onBoardingSubTitle1.tr(),
        ImageAssets.onBoardingLogo1
    ),
    SliderObject(
        AppStrings.onBoardingTitle2.tr(),
        AppStrings.onBoardingSubTitle2.tr(),
        ImageAssets.onBoardingLogo2
    ),
    SliderObject(
        AppStrings.onBoardingTitle3.tr(),
        AppStrings.onBoardingSubTitle3.tr(),
        ImageAssets.onBoardingLogo3
    ),
    SliderObject(
        AppStrings.onBoardingTitle4.tr(),
        AppStrings.onBoardingSubTitle4.tr(),
        ImageAssets.onBoardingLogo4
    ),
  ];

}



abstract class OnBoardingViewModelInputs{
  int goNext(); // when user clicks on right arrow or swipe life;
  int goPrevious(); // when user clicks on left arrow or swipe right;
  void onPageChanged(int index); // Change Current page


  // stream controller input

  Sink get inputSliderViewObject;

}


abstract class OnBoardingViewModelOutputs{
  // stream controller output

   Stream<SliderViewObject> get outputSliderViwObject;
}

