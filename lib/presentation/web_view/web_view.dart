import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_clean_architecture/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_advanced_clean_architecture/presentation/web_view/web_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../resources/strings_manager.dart';


class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  void initState(){
    _viewModel.start();

    super.initState();
  }

    final WebViewViewModel _viewModel =WebViewViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.contactUs.tr()),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: (){
                setState(() {
                  _viewModel.goBack();
                });
              },
              icon: Icon(Icons.arrow_back_ios)
          ),
          IconButton(
              onPressed: (){
                setState(() {
                  _viewModel.goForward();
                });
              },
              icon: Icon(Icons.arrow_forward_ios)
          )
        ],
      ),
      body: StreamBuilder<FlowState>(
       stream: _viewModel.outputStates,
        builder: (context,snapshot){
         if(snapshot.data != null) {
         return  snapshot.data!.getScreenWidget(context, contentScreenWidget(), (){
           _viewModel.start();
         });
         }else{
           return contentScreenWidget();
         }
        },
      ),
    );

  }
 Widget contentScreenWidget(){
    return Container(
      child:WebViewWidget(controller: _viewModel.webViewControllerInput),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
