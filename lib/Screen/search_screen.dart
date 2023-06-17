import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/repository_controller.dart';

class SearchScreen extends StatelessWidget {
  final RepositoryController repositoryController =
      Get.find<RepositoryController>();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        actions: [
          PopupMenuButton<SortOption>(
            icon: Icon(Icons.sort),
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('Sort by Last Updated'),
                value: SortOption.lastUpdated,
              ),
              PopupMenuItem(
                child: Text('Sort by Stars'),
                value: SortOption.stars,
              ),
            ],
            onSelected: (SortOption selectedOption) {
              repositoryController.setSortOption(selectedOption);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search',
              ),
              onSubmitted: (value) {
                repositoryController.searchRepositories(value);
              },
            ),
            Obx(
              () => repositoryController.isLoading.value
                  ? const Expanded(
                    child: Center(
                        child: CircularProgressIndicator(),
                      ),
                  )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: repositoryController.repositories.length,
                        itemBuilder: (context, index) {
                          final repository =
                              repositoryController.repositories[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(repository.ownerAvatarUrl),
                            ),
                            title: Text(repository.name),
                            subtitle: Text(repository.description),
                            onTap: () {
                              Get.toNamed('/details', arguments: repository);
                            },
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
