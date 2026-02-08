// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

Future<void> downloadResume() async {
  final anchor = html.AnchorElement(href: 'assets/resume.pdf')
    ..download = 'Vasanth_Kumar_Resume.pdf'
    ..target = '_blank';
  anchor.click();
}
