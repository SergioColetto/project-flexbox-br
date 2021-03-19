import 'exception/route_path_not_found.dart';

enum NetworkPath { PRIVADO }

extension NetworkPathValue on NetworkPath {
  String get rawValue {
    switch (this) {
      case NetworkPath.PRIVADO:
        return "/api/location";
      default:
        throw RoutePathNotFound();
    }
  }
}
