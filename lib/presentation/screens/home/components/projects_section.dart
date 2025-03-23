import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/core/utils/responsive_utils.dart';
import 'package:my_portfolio/core/widgets/section_header.dart';
import 'package:my_portfolio/data/models/project_model.dart';
import 'package:my_portfolio/presentation/controllers/home_controller.dart';

class ProjectsSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const ProjectsSection({
    required this.sectionKey,
  }) : super(key: sectionKey);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final isMobile = ResponsiveUtils.isMobile(context);

    final mainProjects = controller.projects.take(2).toList();
    final moreProjects = controller.projects.skip(2).toList();

    return Container(
        padding: ResponsiveUtils.getScreenPadding(context),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SectionHeader(title: 'My Projects'),
          Column(
            children: mainProjects.asMap().entries.map((entry) {
              final index = entry.key;
              final project = entry.value;
              final isReversed = index % 2 == 1;

              return Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: isMobile
                    ? ProjectCardMobile(project: project)
                    : ProjectCard(project: project, isReversed: isReversed),
              );
            }).toList(),
          ),
          if (moreProjects.isNotEmpty) ...[
            const SizedBox(height: 20),
            Text(
              'More Projects',
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 20 : 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: isMobile ? 450 : 600,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: moreProjects.length,
                itemBuilder: (context, index) {
                  return HorizontalProjectCard(
                    project: moreProjects[index],
                    width: isMobile ? 280 : 350,
                  );
                },
              ),
            ),
          ],
        ]));
  }
}

class ProjectDetailModal extends StatefulWidget {
  final ProjectModel project;

  const ProjectDetailModal({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  State<ProjectDetailModal> createState() => _ProjectDetailModalState();
}

class _ProjectDetailModalState extends State<ProjectDetailModal> {
  int _currentImageIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final isMobile = ResponsiveUtils.isMobile(context);
    final screenSize = MediaQuery.of(context).size;
    final modalWidth =
        isMobile ? screenSize.width * 0.95 : screenSize.width * 0.8;
    final modalHeight =
        isMobile ? screenSize.height * 0.9 : screenSize.height * 0.85;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: (screenSize.width - modalWidth) / 2,
        vertical: (screenSize.height - modalHeight) / 2,
      ),
      child: Container(
        width: modalWidth,
        height: modalHeight,
        decoration: BoxDecoration(
          gradient: AppColors.surfaceGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Modal header with close button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: AppColors.background.withOpacity(0.8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.project.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 20 : 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // Content area
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Screenshots carousel
                      Container(
                        height: isMobile ? 250 : 400,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black.withOpacity(0.3),
                          //     blurRadius: 20,
                          //     offset: const Offset(0, 10),
                          //   ),
                          // ],
                        ),
                        child: Stack(
                          children: [
                            CarouselSlider(
                              carouselController: _carouselController,
                              options: CarouselOptions(
                                height: isMobile ? 250 : 400,
                                viewportFraction: 1.0,
                                enlargeCenterPage: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 4),
                                onPageChanged: (index, _) {
                                  setState(() {
                                    _currentImageIndex = index;
                                  });
                                },
                              ),
                              items:
                                  widget.project.screenshots.map((screenshot) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    screenshot,
                                    fit: BoxFit.contain,
                                  ),
                                );
                              }).toList(),
                            ),

                            // Navigation arrows
                            Positioned.fill(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Left arrow
                                  GestureDetector(
                                    onTap: () =>
                                        _carouselController.previousPage(),
                                    child: Container(
                                      width: 40,
                                      height: double.infinity,
                                      color: Colors.transparent,
                                      child: Center(
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Right arrow
                                  GestureDetector(
                                    onTap: () => _carouselController.nextPage(),
                                    child: Container(
                                      width: 40,
                                      height: double.infinity,
                                      color: Colors.transparent,
                                      child: Center(
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Indicators
                            if (widget.project.screenshots.length > 1)
                              Positioned(
                                bottom: 15,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: widget.project.screenshots
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    final index = entry.key;
                                    return Container(
                                      width: 8,
                                      height: 8,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _currentImageIndex == index
                                            ? AppColors.primary
                                            : Colors.white.withOpacity(0.5),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Description section
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.background.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'About This Project',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              widget.project.description,
                              style: const TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 16,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Technologies section
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.background.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Technologies Used',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: widget.project.technologies
                                  .map<Widget>((tech) => Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: AppColors.background,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: AppColors.primary,
                                              width: 1),
                                        ),
                                        child: Text(
                                          tech,
                                          style: const TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Action buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.project.playStoreLink != null)
                            ElevatedButton.icon(
                              onPressed: () => controller
                                  .launchUrl(widget.project.playStoreLink!),
                              icon: const Icon(Icons.android),
                              label: const Text('View on Play Store'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.background,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          if (widget.project.playStoreLink != null &&
                              widget.project.githubLink != null)
                            const SizedBox(width: 15),
                          if (widget.project.githubLink != null)
                            OutlinedButton.icon(
                              onPressed: () => controller
                                  .launchUrl(widget.project.githubLink!),
                              icon: const Icon(Icons.code),
                              label: const Text('View Source Code'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(
                                    color: Colors.white, width: 1),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HorizontalProjectCard extends StatelessWidget {
  final ProjectModel project;
  final double width;

  const HorizontalProjectCard({
    Key? key,
    required this.project,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => ProjectDetailModal(project: project),
        );
      },
      child: Container(
        width: width,
        margin: const EdgeInsets.only(right: 20, bottom: 10),
        decoration: BoxDecoration(
          gradient: AppColors.surfaceGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Screenshot Preview
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: SizedBox(
                height: isMobile ? 150 : 250,
                width: double.infinity,
                child: project.screenshots.length > 1
                    ? Stack(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: isMobile ? 150 : 250,
                              viewportFraction: 0.3,
                              enableInfiniteScroll: true,
                              autoPlay: false,
                              enlargeCenterPage: true,
                            ),
                            items: project.screenshots.map((screenshot) {
                              return Image.asset(
                                screenshot,
                                fit: BoxFit.contain,
                              );
                            }).toList(),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            height: 30,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Image.asset(
                        project.screenshots.first,
                        fit: BoxFit.cover,
                      ),
              ),
            ),

            // Project details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project title
                    Text(
                      project.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 18 : 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Description - Scrollable
                    Expanded(
                      flex: 2,
                      child: Text(
                        project.description,
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: isMobile ? 13 : 14,
                          height: 1.5,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Technologies section
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: project.technologies
                          .take(3) // Limit to 3 technologies
                          .map<Widget>((tech) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: AppColors.primary, width: 1),
                                ),
                                child: Text(
                                  tech,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: isMobile ? 10 : 12,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),

                    if (project.technologies.length > 3)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          '+ ${project.technologies.length - 3} more',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: isMobile ? 10 : 12,
                          ),
                        ),
                      ),

                    const SizedBox(height: 12),

                    // View details button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                ProjectDetailModal(project: project),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.background,
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('View Details'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final bool isReversed;

  const ProjectCard({
    Key? key,
    required this.project,
    this.isReversed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTab = ResponsiveUtils.isTablet(context);

    final contentSection = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppColors.surfaceGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Text(
              project.description,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 16,
                height: 1.6,
              ),
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: project.technologies
                .take(5) // Limit to 5 technologies
                .map<Widget>((tech) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.primary, width: 1),
                      ),
                      child: Text(
                        tech,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ProjectDetailModal(project: project),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'View Project Details',
                  style: TextStyle(
                    color: AppColors.background,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final imageSection = Expanded(
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => ProjectDetailModal(project: project),
          );
        },
        child: CarouselSlider(
          options: CarouselOptions(
              height: isTab ? 300 : 400,
              aspectRatio: 16 / 9,
              viewportFraction: isTab ? 0.4 : 0.3,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              pauseAutoPlayOnTouch: true),
          items: project.screenshots.map((screenshot) {
            return Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  screenshot,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );

    return Container(
      height: 500,
      child: Row(
        children: isReversed
            ? [imageSection, const SizedBox(width: 40), contentSection]
            : [contentSection, const SizedBox(width: 40), imageSection],
      ),
    );
  }
}

class ProjectCardMobile extends StatelessWidget {
  final ProjectModel project;

  const ProjectCardMobile({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => ProjectDetailModal(project: project),
            );
          },
          child: CarouselSlider(
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              viewportFraction: 0.3,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: project.screenshots.map((screenshot) {
              return Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    screenshot,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          project.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: AppColors.surfaceGradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Text(
            project.description,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 15,
              height: 1.6,
            ),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.technologies
              .take(4) // Limit to 4 technologies
              .map<Widget>((tech) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary, width: 1),
                    ),
                    child: Text(
                      tech,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ProjectDetailModal(project: project),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'View Project Details',
              style: TextStyle(
                color: AppColors.background,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
