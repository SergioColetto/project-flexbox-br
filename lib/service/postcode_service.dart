import 'package:flutter/material.dart';
import 'package:happy_postcode_flutter/core/constants/network_path.dart';
import 'package:happy_postcode_flutter/models/address.dart';
import 'package:vexana/vexana.dart';

import 'IPostcode_service.dart';

class PostcodeService extends IPostcodeService {
  PostcodeService(INetworkManager service, GlobalKey<ScaffoldState> scaffoldKey)
      : super(service, scaffoldKey);

  @override
  Future<List<Address>> getAllAddress(final String postcode) async {
    final response = await service.fetch<Address, List<Address>>(
        NetworkPath.PRIVADO.rawValue,
        queryParameters: {"postcode": postcode},
        parseModel: Address(),
        method: RequestType.GET);

    if (response.data != null) {
      return response.data;
    } else {
      showErrorMessage(response.error);
      return null;
    }
  }

  @override
  void sendPostcodes(List<Address> addresses) async {
    final response = await service.fetch<Address, List<Address>>(
        NetworkPath.PRIVADO.rawValue,
        method: RequestType.POST,
        parseModel: Address());
  }
}
