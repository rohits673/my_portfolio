class ProjectModel {
  final String title;
  final String description;
  final List<String> technologies;
  final String? imageUrl;
  final String? playStoreLink;
  final String? appStoreLink;
  final String? websiteLink;
  final String? githubLink;
  final List<String> screenshots;

  ProjectModel({
    required this.title,
    required this.description,
    required this.technologies,
    this.imageUrl,
    this.playStoreLink,
    this.appStoreLink,
    this.websiteLink,
    this.githubLink,
    required this.screenshots,
  });
}
