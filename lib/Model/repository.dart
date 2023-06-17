class Repository {
  final String name;
  final String description;
  final String owner;
  final int stargazersCount;
  final DateTime lastUpdated;
  final String ownerAvatarUrl; // Added ownerAvatarUrl field

  Repository({
    required this.name,
    required this.description,
    required this.owner,
    required this.stargazersCount,
    required this.lastUpdated,
    required this.ownerAvatarUrl,
  });
}
