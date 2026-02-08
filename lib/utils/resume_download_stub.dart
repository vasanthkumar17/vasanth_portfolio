import 'package:url_launcher/url_launcher.dart';

Future<void> downloadResume() async {
  final url = Uri.parse('assets/resume.pdf');
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.platformDefault);
  }
}
