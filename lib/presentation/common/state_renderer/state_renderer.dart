import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/assets_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/color_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/font_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/styles_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/values_manager.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType{
 //popup states(Dialog)
  popupLoadingState,
  popupErrorState,
  popupSuccessState,
 //Full screen states
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  // general
  contentState,
}


class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionFunction;

  StateRenderer({super.key, required this.stateRendererType ,this.message = AppStrings.loading, this.title = "",required this.retryActionFunction});

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);

  }
  Widget _getStateWidget(BuildContext context){
    switch(stateRendererType){

      case StateRendererType.popupLoadingState:
        return _getPopupDialog([
          _getAnimatedImage(JsonAssets.loading),
        ]);
      case StateRendererType.popupErrorState:
        return  _getPopupDialog([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.ok.tr(),context)
        ]);
      case StateRendererType.popupSuccessState:
        return  _getPopupDialog([
          _getAnimatedImage(JsonAssets.success),
          _getMessage(title),
          _getMessage(message),
          _getRetryButton(AppStrings.ok.tr(),context)
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemColumn([
          _getAnimatedImage(JsonAssets.loading),
          _getMessage(message)
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getItemColumn([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.reTryAgain.tr(),context)
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getItemColumn([
          _getAnimatedImage(JsonAssets.empty),
          _getMessage(message)]
        );
      case StateRendererType.contentState:
        return Container();
      default: return Container();
    }
  }
  Widget _getPopupDialog(List<Widget> children){
    return Dialog(
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ) ,
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(AppPadding.p14),
          shape: BoxShape.rectangle,
          boxShadow: const [BoxShadow(color: Colors.black26)],
        ),
          child:_getDialogContent(children)
      ),
    );
  }
  Widget  _getDialogContent(List<Widget> children){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
  Widget _getItemColumn(List<Widget> children){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
  Widget _getAnimatedImage(String animatedName){
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child:Lottie.asset(animatedName,fit: BoxFit.fill),//TODO add json image here
    );
}
Widget _getMessage(String message){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(message,style:getRegularStyle(color: ColorManager.black,fontSize: FontSize.s18),textAlign: TextAlign.center,),
      ),
    );
}
Widget _getRetryButton(String buttonTitle,context){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: (){
                if(stateRendererType == StateRendererType.fullScreenErrorState){
                  // call retry function
                  retryActionFunction.call();
                }else{
                  Navigator.of(context).pop();
                }
              },
              child: Text(buttonTitle,
              )
          ),
        ),
      ),
    );
}

}
