// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

Future<void> downloadResume() async {
  final resumeUrl = Uri.base.resolve('assets/resume.pdf').toString();
  final anchor = html.AnchorElement(href: resumeUrl)
    ..download = 'Vasanth_Kumar_Resume.pdf'
    ..target = '_blank';
  anchor.click();
}
