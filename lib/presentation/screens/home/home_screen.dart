import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/utils/responsive_utils.dart';
import 'package:my_portfolio/core/widgets/custom_appbar.dart';
import 'package:my_portfolio/core/widgets/custom_drawer.dart';
// import 'package:my_portfolio/core/utils/url_launcher_service.dart';
import 'package:my_portfolio/presentation/controllers/home_controller.dart';
import 'package:my_portfolio/presentation/screens/home/components/about_section.dart';
import 'package:my_portfolio/presentation/screens/home/components/contact_section.dart';
import 'package:my_portfolio/presentation/screens/home/components/experience_section.dart';
import 'package:my_portfolio/presentation/screens/home/components/footer_section.dart';
import 'package:my_portfolio/presentation/screens/home/components/home_section.dart';
import 'package:my_portfolio/presentation/screens/home/components/projects_section.dart';
import 'package:my_portfolio/presentation/screens/home/components/skills_section.dart';
import 'package:my_portfolio/presentation/screens/home/components/social_sidebar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        onMenuTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        scrollController: _scrollController,
        onHomePressed: () => _scrollToKey(_homeKey),
        onAboutPressed: () => _scrollToKey(_aboutKey),
        onSkillsPressed: () => _scrollToKey(_skillsKey),
        onProjectsPressed: () => _scrollToKey(_projectsKey),
        onExperiencePressed: () => _scrollToKey(_experienceKey),
        onContactPressed: () => _scrollToKey(_contactKey),
      ),
      drawer: CustomDrawer(
        onHomePressed: () {
          Get.back();
          _scrollToKey(_homeKey);
        },
        onAboutPressed: () {
          Get.back();
          _scrollToKey(_aboutKey);
        },
        onSkillsPressed: () {
          Get.back();
          _scrollToKey(_skillsKey);
        },
        onProjectsPressed: () {
          Get.back();
          _scrollToKey(_projectsKey);
        },
        onExperiencePressed: () {
          Get.back();
          _scrollToKey(_experienceKey);
        },
        onContactPressed: () {
          Get.back();
          _scrollToKey(_contactKey);
        },
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HomeSection(
                    sectionKey: _homeKey,
                    onViewWorkPressed: () => _scrollToKey(_projectsKey)),
                AboutSection(sectionKey: _aboutKey),
                SkillsSection(sectionKey: _skillsKey),
                ProjectsSection(sectionKey: _projectsKey),
                ExperienceSection(sectionKey: _experienceKey),
                ContactSection(sectionKey: _contactKey),
                const FooterSection(),
              ],
            ),
          ),

          // Social Media Side Bar
          const Positioned(
            left: 20,
            bottom: 0,
            child: SocialSidebar(),
          ),
        ],
      ),
    );
  }
}
