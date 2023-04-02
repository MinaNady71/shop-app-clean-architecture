import 'package:flutter_advanced_clean_architecture/presentation/base/base_view_model.dart';
import 'package:flutter_advanced_clean_architecture/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_advanced_clean_architecture/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/strings_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

 class WebViewViewModel extends BaseViewModel with WebViewViewModelInput,WebViewViewModelOutput {
    late WebViewController _controller;
  // input
  @override
  void start(){

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            if(isLoadingState) {
              inputStates.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
              isLoadingState = false;
            }
          },
          onPageFinished: (String url)async {
            inputStates.add(ContentState());
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(AppStrings.webViewUrl));

  }
  @override
  void dispose() {
    _controller.clearCache();
    isLoadingState = true;
    super.dispose();
  }


    @override
    WebViewController get webViewControllerInput => _controller;

  @override
  goBack()async {
    _controller.goBack();
  }

  @override
  goForward() {
    _controller.goForward();
  }
  //manage loading

 bool  isLoadingState = true;


}

abstract class WebViewViewModelInput{
  WebViewController get webViewControllerInput;
  goBack();
  goForward();
}
abstract class WebViewViewModelOutput{

}
