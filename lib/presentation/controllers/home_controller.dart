import 'package:get/get.dart';
import 'package:my_portfolio/core/utils/url_launcher_service.dart';
import 'package:my_portfolio/data/models/education_model.dart';
import 'package:my_portfolio/data/models/experience_model.dart';
import 'package:my_portfolio/data/models/project_model.dart';
import 'package:my_portfolio/data/models/skill_model.dart';
import 'package:my_portfolio/data/repositories/portfolio_repository.dart';

class HomeController extends GetxController {
  final PortfolioRepository _repository = PortfolioRepository();
  final UrlLauncherService _urlLauncherService = Get.find<UrlLauncherService>();

  // Observables
  final RxString name = ''.obs;
  final RxString title = ''.obs;
  final RxString subtitle = ''.obs;
  final RxString email = ''.obs;
  final RxString phone = ''.obs;
  final RxString location = ''.obs;
  final RxString githubUrl = ''.obs;
  final RxString linkedInUrl = ''.obs;

  final RxList<String> aboutParagraphs = <String>[].obs;

  final RxList<SkillModel> primarySkills = <SkillModel>[].obs;
  final RxList<SkillModel> secondarySkills = <SkillModel>[].obs;
  final RxList<String> softSkills = <String>[].obs;

  final RxList<ProjectModel> projects = <ProjectModel>[].obs;
  final RxList<ExperienceModel> experiences = <ExperienceModel>[].obs;
  final RxList<EducationModel> education = <EducationModel>[].obs;
  final RxList<Map<String, String>> achievements = <Map<String, String>>[].obs;

  // Active section for scrolling
  final RxString activeSection = 'home'.obs;

  // Form controllers
  final RxBool isSubmitting = false.obs;
  final RxBool contactSuccess = false.obs;
  final RxString contactError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    // Developer information
    name.value = _repository.getName();
    title.value = _repository.getTitle();
    subtitle.value = _repository.getSubtitle();
    email.value = _repository.getEmail();
    phone.value = _repository.getPhone();
    location.value = _repository.getLocation();
    githubUrl.value = _repository.getGithubUrl();
    linkedInUrl.value = _repository.getLinkedInUrl();

    // About section
    aboutParagraphs.value = _repository.getAboutParagraphs();

    // Skills
    primarySkills.value = _repository.getPrimarySkills();
    secondarySkills.value = _repository.getSecondarySkills();
    softSkills.value = _repository.getSoftSkills();

    // Projects
    projects.value = _repository.getProjects();

    // Experience
    experiences.value = _repository.getExperiences();

    // Education
    education.value = _repository.getEducation();

    // Achievements
    achievements.value = _repository.getAchievements();
  }

  void launchUrl(String url) {
    _urlLauncherService.launchMyUrl(url);
  }

  void launchEmail(String email) {
    _urlLauncherService.launchEmail(email);
  }

  void launchPhone(String phone) {
    _urlLauncherService.launchPhone(phone);
  }

  void setActiveSection(String section) {
    activeSection.value = section;
  }

  Future<void> submitContactForm(
      String name, String email, String message) async {
    isSubmitting.value = true;
    contactError.value = '';

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Success response
      contactSuccess.value = true;
      isSubmitting.value = false;
    } catch (e) {
      contactError.value = 'Failed to send message. Please try again later.';
      isSubmitting.value = false;
    }
  }
}
