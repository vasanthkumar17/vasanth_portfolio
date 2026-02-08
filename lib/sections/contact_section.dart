import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/animated_fade.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _showErrors = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name.';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters.';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email.';
    }
    final email = value.trim();
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email.';
    }
    return null;
  }

  String? _validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a message.';
    }
    if (value.trim().length < 10) {
      return 'Message must be at least 10 characters.';
    }
    return null;
  }

  Future<bool> _sendEmail() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    final mailto = Uri(
      scheme: 'mailto',
      path: 'vasanthkumar04398@example.com',
      queryParameters: {
        'subject': 'Portfolio message from $name',
        'body': 'From: $name <$email>\n\n$message',
      },
    );

    if (await canLaunchUrl(mailto)) {
      return launchUrl(mailto, mode: LaunchMode.externalApplication);
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return AnimatedFade(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 48,
          vertical: isMobile ? 60 : 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get In Touch',
              style: Theme.of(context).textTheme.displaySmall,
            ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0.0),
            const SizedBox(height: 16),
            SizedBox(
              width: isMobile ? double.infinity : 600,
              child:
                  Text(
                        'Have a question or want to collaborate? Feel free to reach out!',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 120.ms)
                      .slideY(begin: 0.2, end: 0.0),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: isMobile ? double.infinity : 500,
              child:
                  Form(
                        key: _formKey,
                        autovalidateMode: _showErrors
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              textInputAction: TextInputAction.next,
                              validator: _validateName,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                hintText: 'Your name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorStyle: const TextStyle(
                                  fontSize: 12,
                                  height: 1.2,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFD94F4F),
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFD94F4F),
                                    width: 1.4,
                                  ),
                                ),
                                prefixIcon: const Icon(Icons.person),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: _validateEmail,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'your@email.com',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorStyle: const TextStyle(
                                  fontSize: 12,
                                  height: 1.2,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFD94F4F),
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFD94F4F),
                                    width: 1.4,
                                  ),
                                ),
                                prefixIcon: const Icon(Icons.email),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _messageController,
                              maxLines: 5,
                              textInputAction: TextInputAction.newline,
                              validator: _validateMessage,
                              decoration: InputDecoration(
                                labelText: 'Message',
                                hintText: 'Your message here...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorStyle: const TextStyle(
                                  fontSize: 12,
                                  height: 1.2,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFD94F4F),
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFD94F4F),
                                    width: 1.4,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (!_showErrors) {
                                    setState(() => _showErrors = true);
                                  }
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    final launched = await _sendEmail();
                                    if (!mounted) {
                                      return;
                                    }
                                    if (!launched) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Could not open your email app.',
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Message ready to send in your email app.',
                                        ),
                                      ),
                                    );
                                    _nameController.clear();
                                    _emailController.clear();
                                    _messageController.clear();
                                  }
                                },
                                child: const Text('Send Message'),
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 240.ms)
                      .slideY(begin: 0.2, end: 0.0),
            ),
          ],
        ),
      ),
    );
  }
}
