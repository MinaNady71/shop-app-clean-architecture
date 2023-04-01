// onboarding models

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title,
      this.subTitle,
      this.image,);
}

class SliderViewObject {
  SliderObject sliderObject;
  int numbOfSlides;
  int currentIndex;

  SliderViewObject({required this.sliderObject,
    required this.numbOfSlides,
    required this.currentIndex});
}

// login models

class Customer {
  String id;
  String name;
  int numOfNotification;

  Customer(this.id, this.name, this.numOfNotification);
}

class Contacts {
  String phone;
  String email;
  String link;

  Contacts(this.phone, this.email, this.link);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer,
      this.contacts,);
}

class Service {
  int id;
  String title;
  String image;

  Service(this.id,
      this.title,
      this.image,);
}

class BannerAd {
  int id;
  String link;
  String title;
  String image;

  BannerAd(this.id,
      this.link,
      this.title,
      this.image,);
}

class Store {
  int id;
  String title;
  String image;

  Store(this.id,
      this.title,
      this.image,);
}

class HomeData {
  List<BannerAd> banners;
  List<Service> services;
  List<Store> stores;

  HomeData(this.banners,
      this.stores,
      this.services,);
}

class HomeObject {
  HomeData data;

  HomeObject(this.data);
}

class StoresDetails {
  String image;
  int id;
  String title;
  String details;
  String services;
  String about;

  StoresDetails(
    this.image,
    this.id,
    this.title,
    this.details,
    this.services,
    this.about,
  );
}