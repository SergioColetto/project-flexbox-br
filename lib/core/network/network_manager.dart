import 'package:vexana/vexana.dart';

class NetworkRequestManager {
  static NetworkRequestManager privado;
  final String _uri_local = "http://location-delivery.herokuapp.com";

  static NetworkRequestManager instace;
  final String _uri = "http://api.ideal-postcodes.co.uk";

  static NetworkRequestManager get build {
    if (instace == null) instace = NetworkRequestManager._init();
    return instace;
  }

  INetworkManager service;
  NetworkRequestManager._init() {
    service = NetworkManager(options: BaseOptions(baseUrl: _uri));
  }

  static NetworkRequestManager get buildPrivado {
    if (privado == null) privado = NetworkRequestManager._local();
    return privado;
  }

  INetworkManager servicePrivado;
  NetworkRequestManager._local() {
    servicePrivado = NetworkManager(options: BaseOptions(baseUrl: _uri_local));
  }
}
