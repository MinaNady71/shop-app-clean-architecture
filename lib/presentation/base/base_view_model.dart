import 'dart:async';

import 'package:rxdart/subjects.dart';

import '../common/state_renderer/state_renderer_impl.dart';




abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs{
  // shared variables and functions that will  be used through any view model
  final StreamController _flowStateStreamController = BehaviorSubject<FlowState>();

  @override
  Sink get inputStates => _flowStateStreamController.sink;

  @override
  Stream<FlowState> get outputStates => _flowStateStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _flowStateStreamController.close();
  }

}

abstract class BaseViewModelInputs{
void start(); // start view model job

void dispose(); // will be called when view model dies

Sink get inputStates;
}
abstract class BaseViewModelOutputs{
Stream<FlowState> get outputStates;
}