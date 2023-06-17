import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/repository.dart';
import '../Service/api_service.dart';

class RepositoryController extends GetxController {
  final repositories = <Repository>[].obs;
  final isLoading = false.obs;
  final sortOption = SortOption.lastUpdated.obs;

  @override
  void onInit() {
    super.onInit();
    loadCachedRepositories();
  }

void searchRepositories(String keyword) async {
  try {
    isLoading.value = true;
    final List<Repository> fetchedRepositories = await ApiService.searchRepositories(keyword);
    final List<Repository> limitedRepositories = fetchedRepositories.take(50).toList();
    repositories.assignAll(limitedRepositories);
    sortRepositories(); // Sort repositories after fetching
    isLoading.value = false;

    if (limitedRepositories.isEmpty) {
      Get.dialog(
        AlertDialog(
          title: const Text('No Results Found'),
          content: const Text('No repositories were found for the provided keyword.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      );
    }
  } catch (e) {
    isLoading.value = false;
    Get.snackbar('Error', 'Failed to load repositories');
  }
}


  void loadCachedRepositories() async {
    final List<Repository> cachedRepositories = await ApiService.getCachedRepositories();
    repositories.assignAll(cachedRepositories);
    sortRepositories(); // Sort repositories after loading cached data
  }

  void setSortOption(SortOption option) {
    sortOption.value = option;
    sortRepositories(); // Sort repositories when the sort option changes
  }

  void sortRepositories() {
    repositories.sort((a, b) {
      switch (sortOption.value) {
        case SortOption.lastUpdated:
          return b.lastUpdated.compareTo(a.lastUpdated);
        case SortOption.stars:
          return b.stargazersCount.compareTo(a.stargazersCount);
        default:
          return 0;
      }
    });
  }
}

enum SortOption {
  lastUpdated,
  stars,
}
