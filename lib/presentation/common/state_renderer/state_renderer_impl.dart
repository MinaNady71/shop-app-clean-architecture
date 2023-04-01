import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_clean_architecture/app/constants.dart';
import 'package:flutter_advanced_clean_architecture/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/strings_manager.dart';

abstract class FlowState{
  StateRendererType getStateRendererType();
  String getMessage();
}
// loading state
class LoadingState extends FlowState{
  StateRendererType stateRendererType;
  String message;
  LoadingState({this.message = AppStrings.loading, required this.stateRendererType});
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}
// error state
class ErrorState extends FlowState{
  StateRendererType stateRendererType;
  String message;
  ErrorState(this.message,this.stateRendererType);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// Success state
class SuccessState extends FlowState{
  String message;
  SuccessState(this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.popupSuccessState;
}
//content state
class ContentState extends FlowState{
  ContentState();
  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}
//emptyState
class EmptyState extends FlowState{
  String message;
  EmptyState(this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.fullScreenEmptyState;
}


extension FlowStateExtesion on FlowState{
  Widget getScreenWidget(BuildContext context,Widget contentScreenWidget,Function retryActionFunction){
     switch(runtimeType){
       case LoadingState:
         {
           if(getStateRendererType() == StateRendererType.popupLoadingState){
                // show popup loading
             showPopup(context, getStateRendererType(), getMessage());
             //show content of the  screen
             return contentScreenWidget;
           }else{
            return StateRenderer(
                stateRendererType: getStateRendererType(),
                message: getMessage(),
                retryActionFunction: retryActionFunction);
           }
         }
       case ErrorState:
         {
           dismissDialog(context);
           if(getStateRendererType() == StateRendererType.popupErrorState){
             // show popup error
             showPopup(context, getStateRendererType(), getMessage());
             //show content of the  screen
             return contentScreenWidget;
           }else{
             return StateRenderer(
                 stateRendererType: getStateRendererType(),
                 message: getMessage(),
                 retryActionFunction: retryActionFunction);
           }
         }
       case SuccessState:
         {
           // we should check if we are showing loading popup to remove it before showing success popup
              dismissDialog(context);
             // show popup success
             showPopup(context, getStateRendererType(), getMessage(),title:AppStrings.success.tr());
             //show content of the  screen
             return contentScreenWidget;

         }
       case ContentState:
         {
           dismissDialog(context);
           return contentScreenWidget;
         }
       case EmptyState:
         {
           return  StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: (){});
         }
         default:
           {
             dismissDialog(context);
             return contentScreenWidget;
           }
     }
  }

  _isCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context){
    if(_isCurrentDialogShowing(context)){
      Navigator.of(context,rootNavigator: true).pop(true);
    }
  }

  showPopup(BuildContext context , StateRendererType stateRendererType,String message,
      {String title = Constants.empty}){
    WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(context: context,
            builder: (context) => StateRenderer(stateRendererType: stateRendererType,
              retryActionFunction: (){},
              title: title ,
              message: message,));
    });

  }
}