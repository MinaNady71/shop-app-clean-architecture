import 'package:flutter_advanced_clean_architecture/app/constants.dart';
import 'package:flutter_advanced_clean_architecture/app/extensions.dart';

import '../../domain/model/models.dart';
import '../responses/responses_data.dart';

// we created mapper because we need to convert null to nonnull when to send data to domain layer

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.numOfNotification.orZero() ?? Constants.zero);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
        this?.phone.orEmpty() ?? Constants.empty,
        this?.email.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.customer.toDomain(), this?.contacts.toDomain());
  }
}

extension ResetPasswordResponseMapper on ResetPasswordResponse? {
  String toDomain() {
    return this?.support.orEmpty() ?? Constants.empty;
  }
}

extension ServiceResponseMapper on ServicesResponse? {
  Service toDomain() {
    return Service(
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty);
  }
}

extension StoresResponseMapper on StoresResponse? {
  Store toDomain() {
    return Store(
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty);
  }
}

extension BannersResponseMapper on BannersResponse? {
  BannerAd toDomain() {
    return BannerAd(
        this?.id.orZero() ?? Constants.zero,
        this?.link.orEmpty() ?? Constants.empty,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty);
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> services = (this
                ?.data
                ?.services
                ?.map((servicesResponse) => servicesResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Service>()
        .toList();

    List<Store> stores = (this
        ?.data
        ?.stores
        ?.map((storesResponse) => storesResponse.toDomain()) ??
        const Iterable.empty())
        .cast<Store>()
        .toList();

    List<BannerAd> banners = (this
        ?.data
        ?.banners
        ?.map((bannersResponse) => bannersResponse.toDomain()) ??
        const Iterable.empty())
        .cast<BannerAd>()
        .toList();

    var data = HomeData(banners, stores, services);
    return HomeObject(data);
  }
}


extension StoreDetailsResponseMapper on StoresDetailsResponse?{
  StoresDetails toDomain() {
    return StoresDetails(
      this?.image.orEmpty() ?? Constants.empty,
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty() ?? Constants.empty,
        this?.details.orEmpty() ?? Constants.empty,
        this?.services.orEmpty() ?? Constants.empty,
        this?.about.orEmpty() ?? Constants.empty,

    );
  }
}