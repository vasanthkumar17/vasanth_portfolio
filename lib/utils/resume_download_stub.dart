import 'package:url_launcher/url_launcher.dart';
import '../constants/strings.dart';

Future<void> downloadResume() async {
  final url = Uri.base.resolve(AppStrings.resumeAssetPath);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.platformDefault);
  }
}
