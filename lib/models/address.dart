import 'dart:convert';
import 'package:vexana/vexana.dart';

class Address extends INetworkModel<Address> {
  String description;
  String placeId;
  double longitude;
  double latitude;

  Address({this.description, this.placeId});

  Address.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    placeId = json['place_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Address.buildFromGoogle(Map<String, dynamic> json) {
    description = json['formatted_address'];
    latitude = json['geometry']['location']['lat'];
    longitude = json['geometry']['location']['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['place_id'] = this.placeId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }

  @override
  Address fromJson(Map<String, Object> json) => Address.fromJson(json);
}

List<Address> builderAddresses(List<dynamic> data) {
  return data.map((value) => new Address.fromJson(value)).toList();
}

String builderAddressesToJson(List<Address> addresses) =>
    json.encode(addresses);
