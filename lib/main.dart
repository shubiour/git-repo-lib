import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './Controller/repository_controller.dart';
import './Router/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final RepositoryController repositoryController = Get.put(RepositoryController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GitHub Repositories',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.search,
      getPages: AppRoutes.routes(),
    );
  }
}
