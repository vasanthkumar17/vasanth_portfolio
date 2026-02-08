import 'package:web/web.dart' as web;
import '../constants/strings.dart';

Future<void> downloadResume() async {
  final resumeUrl = Uri.base.resolve(AppStrings.resumeAssetPath).toString();
  final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
  anchor.href = resumeUrl;
  anchor.download = AppStrings.resumeFileName;
  anchor.target = AppStrings.externalTargetSelf;
  anchor.click();
}
