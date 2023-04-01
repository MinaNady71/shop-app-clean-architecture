import 'package:json_annotation/json_annotation.dart';
part 'responses_data.g.dart';


// flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class BaseResponse{
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'messages')
  String? messages;

}

@JsonSerializable()
class CustomerResponse{
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'numOfNotification')
  int? numOfNotification;
  CustomerResponse(this.id,this.name,this.numOfNotification);
  // from json
    factory CustomerResponse.fromJson(Map<String,dynamic> json) => _$CustomerResponseFromJson(json);
  // to json
    Map<String,dynamic> toJson() => _$CustomerResponseToJson(this);
}


@JsonSerializable()
class ContactsResponse{
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'link')
  String? link;
  ContactsResponse(this.phone,this.email,this.link);
  // from json
  factory ContactsResponse.fromJson(Map<String,dynamic> json) => _$ContactsResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$ContactsResponseToJson(this);
}


@JsonSerializable()
class AuthenticationResponse extends BaseResponse{
  @JsonKey(name: 'customer')
  CustomerResponse? customer;
  @JsonKey(name: 'contacts')
  ContactsResponse? contacts;
  AuthenticationResponse(this.customer,this.contacts,);

  // from json
factory AuthenticationResponse.fromJson(Map<String,dynamic> json) => _$AuthenticationResponseFromJson(json);
// to json
Map<String,dynamic> toJson() => _$AuthenticationResponseToJson(this);

}


// reset password response
@JsonSerializable()
class ResetPasswordResponse extends BaseResponse {
  @JsonKey(name:'support')
  String? support;
  ResetPasswordResponse(this.support);
  // from json
  factory ResetPasswordResponse.fromJson(Map<String,dynamic> json) => _$ResetPasswordResponseFromJson(json);
  // to json
  Map<String,dynamic> toJson() =>_$ResetPasswordResponseToJson(this);
}

// home page []
@JsonSerializable()
class ServicesResponse{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  ServicesResponse(this.id,this.title,this.image,);

  // from json
  factory ServicesResponse.fromJson(Map<String,dynamic> json) => _$ServicesResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$ServicesResponseToJson(this);

}

@JsonSerializable()
class BannersResponse{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'link')
  String? link;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  BannersResponse(this.id,this.link,this.title,this.image,);

  // from json
  factory BannersResponse.fromJson(Map<String,dynamic> json) => _$BannersResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$BannersResponseToJson(this);

}
@JsonSerializable()
class StoresResponse{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  StoresResponse(this.id,this.title,this.image,);

  // from json
  factory StoresResponse.fromJson(Map<String,dynamic> json) => _$StoresResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$StoresResponseToJson(this);

}

@JsonSerializable()
class HomeDataResponse{
  @JsonKey(name: 'banners')
  List<BannersResponse>? banners;

  @JsonKey(name: 'services')
  List<ServicesResponse>? services;

  @JsonKey(name: 'stores')
  List<StoresResponse>? stores;

  HomeDataResponse(this.banners,this.stores,this.services,);

  // from json
  factory HomeDataResponse.fromJson(Map<String,dynamic> json) => _$HomeDataResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$HomeDataResponseToJson(this);

}


@JsonSerializable()
class HomeResponse extends BaseResponse{
  @JsonKey(name: 'data')
  HomeDataResponse? data;

  HomeResponse(this.data);

  // from json
  factory HomeResponse.fromJson(Map<String,dynamic> json) => _$HomeResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$HomeResponseToJson(this);

}


// Stores details response
@JsonSerializable()
class StoresDetailsResponse extends BaseResponse{
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "details")
  String? details;
  @JsonKey(name: "services")
  String? services;
  @JsonKey(name: "about")
  String? about;

  StoresDetailsResponse(this.image,this.id,this.title,this.details,this.services,this.about);
  // from json
  factory StoresDetailsResponse.fromJson(Map<String,dynamic> json) => _$StoresDetailsResponseFromJson(json);

  //to json
  Map<String,dynamic> toJson() => _$StoresDetailsResponseToJson(this);

}