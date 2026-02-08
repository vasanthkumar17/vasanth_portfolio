// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

Future<void> downloadResume() async {
  final base = Uri.base;
  final resumeUrl = base.host.contains('localhost')
      ? base.resolve('assets/resume.pdf').toString()
      : base.resolve('resume.pdf').toString();
  final anchor = html.AnchorElement(href: resumeUrl)
    ..download = 'Vasanth_Kumar_Resume.pdf'
    ..target = '_blank';
  anchor.click();
}
