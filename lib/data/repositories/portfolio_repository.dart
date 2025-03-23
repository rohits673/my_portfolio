import 'package:my_portfolio/data/models/education_model.dart';
import 'package:my_portfolio/data/models/experience_model.dart';
import 'package:my_portfolio/data/models/project_model.dart';
import 'package:my_portfolio/data/models/skill_model.dart';

class PortfolioRepository {
  // Developer information
  String getName() => 'Rohit Kumar';
  String getTitle() => 'Flutter Developer';
  String getSubtitle() =>
      'Experienced mobile developer with 3+ years in Flutter, specializing in cross-platform development for Android and iOS.';
  String getEmail() => 'Rohit673.mail@gmail.com';
  String getPhone() => '+91 9667369807';
  String getLocation() => 'Noida, UP, India';
  String getGithubUrl() => 'https://github.com/yourusername';
  String getLinkedInUrl() => 'https://www.linkedin.com/in/rohit-kumar673/';

  // About section
  List<String> getAboutParagraphs() {
    return [
      'I\'m a Flutter Developer with a passion for building beautiful, efficient, and user-friendly mobile applications. With over 3 years of experience, I specialize in creating cross-platform apps that deliver exceptional user experiences.',
      'My journey in mobile development has involved working on various projects that are now available on the Play Store and App Store. I focus on clean architecture, performance optimization, and implementing intuitive UI/UX designs.',
      'Beyond coding, I\'m passionate about staying updated with the latest Flutter developments and contributing to the developer community. I believe in continuous learning and improving my skills to deliver the best mobile experiences.',
    ];
  }

  // Skills
  List<SkillModel> getPrimarySkills() {
    return [
      SkillModel(
        title: 'Flutter & Dart',
        level: 'Advanced',
        percentage: 0.9,
      ),
      SkillModel(
        title: 'JavaScript & React',
        level: 'Intermediate',
        percentage: 0.75,
      ),
      SkillModel(
        title: 'Firebase & Backend',
        level: 'Advanced',
        percentage: 0.85,
      ),
      SkillModel(
        title: 'UI/UX Design',
        level: 'Intermediate',
        percentage: 0.8,
      ),
      SkillModel(
        title: 'Agile & Scrum',
        level: 'Intermediate',
        percentage: 0.75,
      ),
    ];
  }

  List<SkillModel> getSecondarySkills() {
    return [
      SkillModel(
        title: 'C++ (OOP)',
        level: 'Basic',
        percentage: 0.6,
      ),
      SkillModel(
        title: 'HTML/CSS',
        level: 'Intermediate',
        percentage: 0.7,
      ),
      SkillModel(
        title: 'Git',
        level: 'Intermediate',
        percentage: 0.75,
      ),
      SkillModel(
        title: 'CI/CD',
        level: 'Intermediate',
        percentage: 0.7,
      ),
    ];
  }

  List<String> getSoftSkills() {
    return [
      'Problem-solving',
      'Attention to detail',
      'Ownership',
      'Teamwork',
      'Collaboration',
    ];
  }

  // Projects
  List<ProjectModel> getProjects() {
    return [
      ProjectModel(
        title: 'Sparkt - Machinist App',
        description:
            'Developed Feed and Chat features with Getstream.io, improving user interaction by 30% and integrating advanced chat with Azure OpenAI. Designed dynamic functionalities using GetX and BLoC state management. Implemented reusable custom widgets and integrated third-party libraries.',
        technologies: [
          'Flutter',
          'GetX',
          'Getstream.io',
          'Azure OpenAI',
          'CI/CD',
          'Push Notifications',
          'Deep Linking'
        ],
        playStoreLink:
            'https://play.google.com/store/apps/details?id=com.phillipscorp.machinist',
        screenshots: [
          "assets/projects/machinist/1.jpg",
          "assets/projects/machinist/2.jpg",
          "assets/projects/machinist/3.jpg",
          "assets/projects/machinist/4.jpg",
          "assets/projects/machinist/5.jpg",
          "assets/projects/machinist/6.jpg",
        ],
      ),
      ProjectModel(
        title: 'Ucertify Learn App',
        description:
            'Led the development of Flutter-based mobile applications, introducing features like daily quizzes and video assessments, which boosted user engagement by 40%. Managed the entire application lifecycle, from concept to deployment, ensuring high performance and responsive UI.',
        technologies: [
          'Flutter',
          'Dart',
          'Firebase',
          'RESTful APIs',
          'Video Assessments'
        ],
        playStoreLink:
            'https://play.google.com/store/apps/details?id=com.flutter.ucertifyLearn',
        screenshots: [
          "assets/projects/ucertify/1.jpg",
          "assets/projects/ucertify/2.jpg",
          "assets/projects/ucertify/3.jpg",
          "assets/projects/ucertify/4.jpg",
          "assets/projects/ucertify/5.jpg",
        ],
      ),
      ProjectModel(
        title: 'Arya - AI Chat Assistant',
        description:
            "Arya is a secure AI chat assistant for task management, incentives, and HR queries. It features real-time responses, authentication, robust security, dynamic theming, push notifications, and deep linking for a smooth user experience.",
        technologies: [
          'Flutter',
          'Root/Jailbreak Detection',
          'Frida Detection',
          'Dynamic Theming',
          'Push Notifications',
          'Deep Linking',
        ],
        imageUrl: 'assets/images/arya_chat.png',
        playStoreLink:
            "https://play.google.com/store/apps/details?id=com.arya.piramal",
        screenshots: [
          "assets/projects/arya/1.png",
          "assets/projects/arya/2.png",
          "assets/projects/arya/3.png",
        ],
      ),
      ProjectModel(
        title: 'Sparkt - ATLAS',
        description:
            'ATLAS is An AI-driven platform for idea submission and insights. It features AI chat, Elai.io video generation, TTS, and radar charts for analytics, enabling users to engage with dynamic AI-driven content.',
        technologies: [
          'Flutter',
          'AI-Powered Insights',
          'Video Generation (Elai.io)',
          'Radar Charts',
          'Responsive Design',
        ],
        imageUrl: 'assets/images/atlas_insights.png',
        playStoreLink: "",
        screenshots: [
          "assets/projects/atlas/1.png",
          "assets/projects/atlas/2.png",
          "assets/projects/atlas/3.png",
          "assets/projects/atlas/4.png",
          "assets/projects/atlas/5.png",
        ],
      ),
      ProjectModel(
        title: 'Sparkt - Punch App',
        description:
            'A smart Flutter-based attendance system with real-time face detection, AI-powered productivity insights. Tracks work hours, ensures punctuality, and provides detailed performance analytics.',
        technologies: [
          'Flutter',
          'Face Detection',
          'RESTful APIs',
          'AI Integration',
          'Productivity Analytics',
        ],
        imageUrl: 'assets/images/employee_punching_app.png',
        playStoreLink: null,
        screenshots: [
          "assets/projects/punch/1.png",
          "assets/projects/punch/2.png",
          "assets/projects/punch/3.png",
        ],
      ),
      ProjectModel(
        title: 'RSS Feed Reader App',
        description:
            'A fast and customizable RSS reader that aggregates news from multiple sources. Supports real-time updates, seamless Twitter & Facebook integration, and an optimized in-app browsing experience.',
        technologies: [
          'Flutter',
          'RSS Feed',
          'Twitter Embed',
          'In-App WebView',
        ],
        playStoreLink: null,
        screenshots: [
          "assets/projects/trends/1.png",
          "assets/projects/trends/2.png",
          "assets/projects/trends/3.png",
          "assets/projects/trends/4.png",
        ],
      ),
      ProjectModel(
        title: 'Strata - Interactive Map',
        description:
            'An intuitive map exploration app with downloadable offline maps, interactive content, and seamless video integration.',
        technologies: [
          'Flutter',
          'Interactive Maps',
          'Video Integration',
          'File Management',
        ],
        imageUrl: 'assets/images/map_detail_app.png',
        playStoreLink: "http://strata.madebysparkt.com/",
        screenshots: [
          "assets/projects/strata/1.png",
          "assets/projects/strata/2.png",
          "assets/projects/strata/3.png",
        ],
      ),
    ];
  }

  // Experience
  List<ExperienceModel> getExperiences() {
    return [
      ExperienceModel(
        role: 'Software Engineer (Mobile)',
        company: 'Sparkt',
        location: 'Mumbai, India',
        duration: 'Jul 2022 - Present',
        responsibilities: [
          'Developed Feed and Chat features with Getstream.io, improving user interaction by 30% and integrating advanced chat with Azure OpenAI.',
          'Designed dynamic and complex functionalities using both GetX and BLoC state management tools, ensuring maintainability and scalability.',
          'Implemented reusable custom widgets and integrated third-party libraries for backend API interactions, accelerating development speed by 20%.',
          'Integrated CI/CD pipelines and Flutter testing, reducing deployment errors by 25% and improving release processes.',
          'Developed dynamic links and implemented analytics and push notifications, boosting app performance and user retention by 15%.',
        ],
      ),
      ExperienceModel(
        role: 'Application Developer',
        company: 'Ucertify',
        location: 'Noida, India',
        duration: 'Oct 2021 - June 2022',
        responsibilities: [
          'Led the development of Flutter-based mobile applications, introducing features like daily quizzes and video assessments, which boosted user engagement by 40%.',
          'Managed the entire application lifecycle, from concept to deployment, ensuring high performance and responsive UI.',
        ],
      ),
      ExperienceModel(
        role: 'Software Engineer Intern',
        company: 'Cadence Design System',
        location: 'Noida, India',
        duration: 'April 2021 - June 2021',
        responsibilities: [
          'Boosted event access with a 10x efficient C++ database, incorporating RegEx, C++ STL, and file handling.',
        ],
      ),
    ];
  }

  // Education
  List<EducationModel> getEducation() {
    return [
      EducationModel(
        degree: 'B.Tech in Computer Science',
        institution: 'Dr. A. P. J. Abdul Kalam Technical University',
        location: 'Lucknow, UP',
        year: '2022',
      ),
      EducationModel(
        degree: 'Class XII (BSEB)',
        institution: 'Jehanabad College',
        location: 'Jehanabad, Bihar',
        year: '2018',
      ),
    ];
  }

  // Achievements
  List<Map<String, String>> getAchievements() {
    return [
      {
        'title': 'Winner of Innovation Badge 2019',
        'description':
            'National Project Competition at Sharda University, developed an FDM 3D Printer.',
      },
      {
        'title': 'Winner of Crossroads 2019',
        'description': 'State level innovation competition.',
      },
    ];
  }
}
