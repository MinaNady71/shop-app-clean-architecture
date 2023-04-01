import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_clean_architecture/app/di.dart';
import 'package:flutter_advanced_clean_architecture/domain/model/models.dart';
import 'package:flutter_advanced_clean_architecture/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/store_details/view_model/sotre_details_view_model.dart';

import '../../resources/values_manager.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({Key? key}) : super(key: key);

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _viewModel = instance<StoreDetailsViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.storesDetails.tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: Center(
          child: SingleChildScrollView(
              child: StreamBuilder<FlowState>(
                  stream: _viewModel.outputStates,
                  builder: (context, snapshot) =>
                      snapshot.data
                          ?.getScreenWidget(context, _getContentWidget(), () {
                        _viewModel.start();
                      }) ??
                      _getContentWidget()))),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<StoresDetails>(
        stream: _viewModel.outputStoreDetails,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getStoreDetailsImage(snapshot.data?.image),
                _getSection(AppStrings.details.tr()),
                _getStoreDetailsWidget(snapshot.data?.details),
                _getSection(AppStrings.services.tr()),
                _getStoreDetailsWidget(snapshot.data?.services),
                _getSection(AppStrings.aboutStore.tr()),
                _getStoreDetailsWidget(snapshot.data?.about),
              ],
            );
          } else {
            return Container();
          }
        });
  }

  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppPadding.p12,
          bottom: AppPadding.p2,
          left: AppPadding.p12,
          right: AppPadding.p12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }

  Widget _getStoreDetailsImage(String? image) {
    if (image != null) {
      return Card(
        elevation: AppSize.s4,
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getStoreDetailsWidget(String? title) {
    if (title != null) {
      return Padding(
        padding: const EdgeInsets.only(
            right: AppPadding.p14,
            top: AppPadding.p8,
            left: AppPadding.p14,
            bottom: AppPadding.p8),
        child: Text(
          title,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
