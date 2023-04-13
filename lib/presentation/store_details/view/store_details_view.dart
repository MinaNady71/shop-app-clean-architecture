import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_clean_architecture/app/di.dart';
import 'package:flutter_advanced_clean_architecture/domain/model/models.dart';
import 'package:flutter_advanced_clean_architecture/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_advanced_clean_architecture/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_advanced_clean_architecture/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced_clean_architecture/presentation/store_details/stores_bloc/stores_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/values_manager.dart';

class StoreDetailsView extends StatelessWidget {
   const StoreDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.storesDetails.tr(),
            style: Theme
                .of(context)
                .textTheme
                .titleSmall,
          ),
          leading: IconButton(onPressed: (){
             instance<StoresBloc>().close();
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back)),
         ),
        body: BlocBuilder<StoresBloc, StoresState>(
        builder: (context, state)
    {
      if (state is LoadingStoreDetailsState) {
        return Center(
          child: StateRenderer(stateRendererType: StateRendererType
              .fullScreenLoadingState, retryActionFunction: () {}),
        );
      } else if (state is SuccessStoreDetailsState) {
        return
          Center(
              child: SingleChildScrollView(
                  child: FlowStateExtesion(ContentState()).getScreenWidget(context, _getContentWidget(state.storeDetails,context), (){
                 //   GetStoreDetailsDataEvent();
                  }),
              )
          );
      }else{
        return Center(
          child: StateRenderer(
              stateRendererType: StateRendererType.fullScreenErrorState,
              retryActionFunction: () {}),
        );
      }
    }
    ));
  }

  Widget _getContentWidget(StoresDetails storesDetails,context) {
    return  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getStoreDetailsImage(storesDetails.image),
                _getSection(AppStrings.details.tr(),context),
                _getStoreDetailsWidget(storesDetails.details,context),
                _getSection(AppStrings.services.tr(),context),
                _getStoreDetailsWidget(storesDetails.services,context),
                _getSection(AppStrings.aboutStore.tr(),context),
                _getStoreDetailsWidget(storesDetails.about,context),
              ],
            );
          }

  Widget _getSection(String title,context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppPadding.p12,
          bottom: AppPadding.p2,
          left: AppPadding.p12,
          right: AppPadding.p12),
      child: Text(
        title,
        style: Theme
            .of(context)
            .textTheme
            .labelSmall,
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

  Widget _getStoreDetailsWidget(String? title,context) {
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
          style: Theme
              .of(context)
              .textTheme
              .headlineMedium,
        ),
      );
    } else {
      return Container();
    }
  }
}
