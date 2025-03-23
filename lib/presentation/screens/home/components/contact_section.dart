import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/core/utils/responsive_utils.dart';
import 'package:my_portfolio/core/widgets/animated_gradient_button.dart';
import 'package:my_portfolio/core/widgets/section_header.dart';
import 'package:my_portfolio/presentation/controllers/home_controller.dart';

class ContactSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const ContactSection({
    required this.sectionKey,
  }) : super(key: sectionKey);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      padding: ResponsiveUtils.getScreenPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SectionHeader(
            title: 'Get In Touch',
            centered: true,
            width: 150,
          ),
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 700),
              child: const Text(
                'I\'m currently open to new opportunities and collaborations. Whether you have a question or just want to say hi, I\'ll try my best to get back to you!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ContactForm(),
          ),
          const SizedBox(height: 80),
          isMobile
              ? _buildMobileContactInfo(controller)
              : _buildDesktopContactInfo(controller),
        ],
      ),
    );
  }

  Widget _buildDesktopContactInfo(HomeController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildContactItem(
          icon: Icons.email,
          title: 'Email',
          content: controller.email.value,
          onTap: () => controller.launchEmail(controller.email.value),
        ),
        const SizedBox(width: 40),
        _buildContactItem(
          icon: Icons.phone,
          title: 'Phone',
          content: controller.phone.value,
          onTap: () => controller.launchPhone(controller.phone.value),
        ),
        const SizedBox(width: 40),
        _buildContactItem(
          icon: Icons.location_on,
          title: 'Location',
          content: controller.location.value,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildMobileContactInfo(HomeController controller) {
    return Column(
      children: [
        _buildContactItem(
          icon: Icons.email,
          title: 'Email',
          content: controller.email.value,
          onTap: () => controller.launchEmail(controller.email.value),
        ),
        const SizedBox(height: 20),
        _buildContactItem(
          icon: Icons.phone,
          title: 'Phone',
          content: controller.phone.value,
          onTap: () => controller.launchPhone(controller.phone.value),
        ),
        const SizedBox(height: 20),
        _buildContactItem(
          icon: Icons.location_on,
          title: 'Location',
          content: controller.location.value,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String content,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: AppColors.surfaceGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 40,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final controller = Get.find<HomeController>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Your Name',
              labelStyle: const TextStyle(color: AppColors.textMuted),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.primary, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.textMuted.withOpacity(0.5), width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: AppColors.surfaceDark.withOpacity(0.5),
            ),
            style: const TextStyle(color: Colors.white),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Your Email',
              labelStyle: const TextStyle(color: AppColors.textMuted),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.primary, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.textMuted.withOpacity(0.5), width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: AppColors.surfaceDark.withOpacity(0.5),
            ),
            style: const TextStyle(color: Colors.white),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              // Basic email validation
              if (!value.contains('@') || !value.contains('.')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _messageController,
            decoration: InputDecoration(
              labelText: 'Your Message',
              labelStyle: const TextStyle(color: AppColors.textMuted),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.primary, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.textMuted.withOpacity(0.5), width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: AppColors.surfaceDark.withOpacity(0.5),
            ),
            style: const TextStyle(color: Colors.white),
            maxLines: 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your message';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          Obx(
            () => controller.contactSuccess.value
                ? Column(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: AppColors.primary,
                        size: 50,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Thanks for reaching out!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                : Column(
                    children: [
                      if (controller.contactError.value.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            controller.contactError.value,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      AnimatedGradientButton(
                        text: controller.isSubmitting.value
                            ? 'Sending...'
                            : 'Send Message',
                        onPressed: controller.isSubmitting.value
                            ? () {}
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  controller.submitContactForm(
                                    _nameController.text,
                                    _emailController.text,
                                    _messageController.text,
                                  );
                                }
                              },
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
