import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_postcode_flutter/models/address.dart';
import 'package:vexana/vexana.dart';

abstract class IPostcodeService {
  final INetworkManager service;
  final GlobalKey<ScaffoldState> scaffoldKey;
  IPostcodeService(this.service, this.scaffoldKey);

  Future<List<Address>> getAllAddress(final String postcode);
  void sendPostcodes(List<Address> addresses);

  void showErrorMessage(IErrorModel response) {
    if (this.scaffoldKey != null) {
      scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(response.description)));
    }
  }
}
