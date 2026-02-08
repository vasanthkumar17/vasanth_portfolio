import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/strings.dart';
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
      return AppStrings.validationNameRequired;
    }
    if (value.trim().length < 2) {
      return AppStrings.validationNameShort;
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.validationEmailRequired;
    }
    final email = value.trim();
    final emailRegex = RegExp(AppStrings.emailRegexPattern);
    if (!emailRegex.hasMatch(email)) {
      return AppStrings.validationEmailInvalid;
    }
    return null;
  }

  String? _validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.validationMessageRequired;
    }
    if (value.trim().length < 10) {
      return AppStrings.validationMessageShort;
    }
    return null;
  }

  Future<bool> _sendEmail() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    final subject = '${AppStrings.emailSubjectPrefix} $name';
    final body = '${AppStrings.emailBodyPrefix} $name <$email>\n\n$message';
    final query =
        '${AppStrings.mailtoSubjectKey}=${Uri.encodeQueryComponent(subject)}'
        '&${AppStrings.mailtoBodyKey}=${Uri.encodeQueryComponent(body)}';

    final mailto = Uri(
      scheme: AppStrings.mailtoScheme,
      path: AppStrings.contactEmail,
      query: query,
    );

    if (await canLaunchUrl(mailto)) {
      return launchUrl(
        mailto,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: AppStrings.externalTargetSelf,
      );
    }

    return false;
  }

  Future<void> _launchSimpleMailto() async {
    final mailto = Uri(
      scheme: AppStrings.mailtoScheme,
      path: AppStrings.contactEmail,
    );
    if (await canLaunchUrl(mailto)) {
      await launchUrl(
        mailto,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: AppStrings.externalTargetSelf,
      );
    }
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
              AppStrings.contactTitle,
              style: Theme.of(context).textTheme.displaySmall,
            ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0.0),
            const SizedBox(height: 16),
            SizedBox(
              width: isMobile ? double.infinity : 600,
              child:
                  Text(
                        AppStrings.contactIntro,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 120.ms)
                      .slideY(begin: 0.2, end: 0.0),
            ),
            const SizedBox(height: 28),
            if (isMobile)
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ElevatedButton.icon(
                    onPressed: _launchSimpleMailto,
                    icon: const Icon(Icons.mail),
                    label: const Text(AppStrings.mailtoSimpleLabel),
                  ),
                  OutlinedButton.icon(
                    onPressed: () async {
                      await Clipboard.setData(
                        const ClipboardData(text: AppStrings.contactEmail),
                      );
                      if (!mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(AppStrings.snackEmailCopied),
                        ),
                      );
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text(AppStrings.mailtoCopyLabel),
                  ),
                ],
              ).animate().fadeIn(duration: 500.ms, delay: 160.ms),
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
                                labelText: AppStrings.formNameLabel,
                                hintText: AppStrings.formNameHint,
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
                                labelText: AppStrings.formEmailLabel,
                                hintText: AppStrings.formEmailHint,
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
                                labelText: AppStrings.formMessageLabel,
                                hintText: AppStrings.formMessageHint,
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
                                  final messenger = ScaffoldMessenger.of(
                                    context,
                                  );
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
                                      messenger.showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            AppStrings.snackEmailAppFail,
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    messenger.showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          AppStrings.snackEmailReady,
                                        ),
                                      ),
                                    );
                                    setState(() => _showErrors = false);
                                    _nameController.clear();
                                    _emailController.clear();
                                    _messageController.clear();
                                  }
                                },
                                child: const Text(AppStrings.sendMessage),
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
