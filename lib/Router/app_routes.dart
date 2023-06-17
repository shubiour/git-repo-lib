import 'package:get/get.dart';
import '../Screen/details_screen.dart';
import '../Screen/search_screen.dart';

class AppRoutes {
  static const String search = '/';
  static const String details = '/details';

  static List<GetPage> routes() {
    return [
      GetPage(name: search, page: () => SearchScreen()),
      GetPage(name: details, page: () => DetailsScreen()),
    ];
  }
}
