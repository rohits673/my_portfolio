class ExperienceModel {
  final String role;
  final String company;
  final String location;
  final String duration;
  final List<String> responsibilities;
  final String? logoUrl;

  ExperienceModel({
    required this.role,
    required this.company,
    required this.location,
    required this.duration,
    required this.responsibilities,
    this.logoUrl,
  });
}

