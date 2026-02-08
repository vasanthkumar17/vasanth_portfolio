class AppStrings {
  static const appTitle = 'Vasanth Portfolio';

  static const heroGreeting = "Hey, I'm Vasanth Kumar K ";
  static const heroSparkle = '\u2728';
  static const heroRole = 'Mobile App Developer';
  static const heroSummary =
      'Mobile app developer with over 4.8 years of experience in Xamarin Native, iOS, and Android app development. Skilled in push notifications, Bluetooth Low Energy (BLE), Agora RTM, and app store/play store submission processes. Currently expanding expertise by learning Flutter Experienced across all stages of the Software Development Life Cycle (SDLC), from requirements analysis to deployment and documentation. Proven ability to develop apps from scratch through to production release.';

  static const contactEmail = 'vasanthkumar04398@example.com';
  static const githubUrl = 'https://github.com/vasanthkumar17';
  static const linkedInUrl =
      'https://www.linkedin.com/in/vasanth-kumar-4522a61a0';

  static const buttonContactMe = 'Contact Me';
  static const buttonViewProjects = 'View Projects';
  static const buttonGitHub = 'GitHub';
  static const buttonLinkedIn = 'LinkedIn';
  static const buttonViewMoreGitHub = 'View More on GitHub';

  static const navBrand = 'Vasanth.dev';
  static const navHome = 'Home';
  static const navProjects = 'Projects';
  static const navSkills = 'Skills';
  static const navContact = 'Contact';
  static const navResume = 'Resume';
  static const navToggleTheme = 'Toggle Theme';

  static const sectionCoreCompetencies = 'Core Competencies';
  static const sectionCoreCompetenciesIntro =
      'Comprehensive expertise across modern mobile development platforms, architectures, and tools:';

  static const sectionProfessionalExperience = 'Professional Experience';
  static const sectionProfessionalExperienceIntro =
      'Project details grouped by company and timeline.';

  static const projectResponsibilitiesTitle = 'Roles & Responsibilities';
  static const projectDetailBack = 'Back to Projects';
  static const projectDetailOverview = 'Project Overview';
  static const projectDetailResponsibilities = 'Key Responsibilities';
  static const projectDetailCtaTitle = 'Ready to work together?';
  static const projectDetailCtaBody =
      'Let\'s discuss how I can help bring your project to life.';
  static const projectDetailCtaButton = 'Get in Touch';

  static const contactTitle = 'Get In Touch';
  static const contactIntro =
      'Have a question or want to collaborate? Feel free to reach out!';

  static const formNameLabel = 'Name';
  static const formNameHint = 'Your name';
  static const formEmailLabel = 'Email';
  static const formEmailHint = 'your@email.com';
  static const formMessageLabel = 'Message';
  static const formMessageHint = 'Your message here...';
  static const sendMessage = 'Send Message';

  static const validationNameRequired = 'Please enter your name.';
  static const validationNameShort = 'Name must be at least 2 characters.';
  static const validationEmailRequired = 'Please enter your email.';
  static const validationEmailInvalid = 'Please enter a valid email.';
  static const validationMessageRequired = 'Please enter a message.';
  static const validationMessageShort =
      'Message must be at least 10 characters.';
  static const emailRegexPattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';

  static const snackEmailAppFail = 'Could not open your email app.';
  static const snackEmailReady = 'Message ready to send in your email app.';

  static const footerCopyright = '\u00A9 2026 Vasanth Kumar K';
  static const footerLinkedIn = 'LinkedIn';

  static const emailSubjectPrefix = 'Portfolio message from';
  static const emailBodyPrefix = 'From:';
  static const mailtoScheme = 'mailto';
  static const mailtoSubjectKey = 'subject';
  static const mailtoBodyKey = 'body';

  static const resumeAssetPath = 'assets/assets/resume.pdf';
  static const resumeFileName = 'Vasanth_Kumar_Resume.pdf';
  static const externalTargetBlank = '_blank';
}

class SkillCategory {
  final String title;
  final List<String> items;

  const SkillCategory({required this.title, required this.items});
}

class Project {
  final String name;
  final String technology;
  final String description;
  final List<String> responsibilities;

  const Project({
    required this.name,
    required this.technology,
    required this.description,
    required this.responsibilities,
  });
}

class ExperienceGroup {
  final String company;
  final String role;
  final String location;
  final String timeline;
  final List<Project> projects;

  const ExperienceGroup({
    required this.company,
    required this.role,
    required this.location,
    required this.timeline,
    required this.projects,
  });
}

class AppData {
  static const skillCategories = <SkillCategory>[
    SkillCategory(
      title: 'Frameworks',
      items: [
        'iOS (UIKit, SwiftUI)',
        'Android',
        'Xamarin.Native (iOS & Android)',
        'Flutter',
      ],
    ),
    SkillCategory(
      title: 'Programming Languages',
      items: ['Swift', 'Kotlin', 'Objective-C', 'C#', 'Dart'],
    ),
    SkillCategory(
      title: 'Architectures & Methodologies',
      items: ['MVVM', 'MVC', 'Dependency Injection', 'TDD', 'AGILE'],
    ),
    SkillCategory(
      title: 'Databases',
      items: ['Realm', 'SQL', 'CoreData', 'Room'],
    ),
    SkillCategory(
      title: 'Technologies & Services',
      items: [
        'Firebase',
        'Google Maps & MapKit',
        'Bluetooth Low Energy (BLE)',
        'Agora RTM',
        'WebSocket',
        'XMPP',
        'WebRTC',
      ],
    ),
    SkillCategory(
      title: 'Development Tools',
      items: ['Visual Studio', 'Xcode', 'Android Studio'],
    ),
  ];

  static const experienceGroups = <ExperienceGroup>[
    ExperienceGroup(
      company: 'Flyersoft pvt ltd',
      role: 'Software Engineer - Mobile',
      location: 'Chennai',
      timeline: 'February 2022 - Present',
      projects: [
        Project(
          name: 'C3PAY',
          technology: 'Xamarin.iOS & Xamarin.Android',
          description:
              'C3PAY (Xamarin.iOS & Xamarin.Android) is a mobile app for managing financial transactions, primarily designed for users with a C3Pay card. It allows users to view balances, send money, recharge mobile numbers, and receive SMS alerts.',
          responsibilities: [
            'Contributed to multiple modules, including C3Pay+, Mobile Recharge, and Money Transfer, Security SMS.',
            'Conducted user experiments and analyzed the impact of new features to enhance user experience.',
            'Participated in design reviews, UX discussions, and product ideation sessions.',
            'Developed dynamic UI screens for the Money Transfer flow (Bank Transfer and Wallet) based on API responses.',
            'Worked in an Agile development environment, collaborating with cross-functional teams.',
            'Started contributing to the Flutter migration, focusing on developing and optimizing UI components.',
          ],
        ),
        Project(
          name: 'XR COMPANION',
          technology: 'Android (Kotlin)',
          description:
              'XR COMPANION (Android - kotlin) helps to connect with a moziwear device. This device helps workers wear a glass and operate everything in voice over. This project is still under development.',
          responsibilities: [
            'Designed and developed agora RTM, white board with Back-end API integration and RESTFUL services.',
            'I worked with MVVM.',
            'Used Hilt Dependency injection.',
            'Used Room for database.',
            'Drawing Annotations.',
          ],
        ),
        Project(
          name: 'USEEBP',
          technology: 'Android (Kotlin)',
          description:
              'USEEBP (Android - kotlin) is a healthcare application which helps you to check BP, connect to nearby BLE devices and communicate with doctors via emails. It has a built-in chatbot functionality and helps to keep track of patient BP data and challenges.',
          responsibilities: [
            'Designed and developed chatbot features using Back-end API integration and RESTFUL services.',
            'I worked with BLE.',
            'Used Unity for Dependency Injection.',
            'I worked with MVVM.',
            'Bug fixing.',
          ],
        ),
        Project(
          name: 'DEVERON',
          technology: 'iPadOS (Swift UI)',
          description:
              'DEVERON (iPadOS - Swift UI) is a collection of soil and analysis app which help to support you with local experts to get the most out of your soil. Our single chain of custody - from field to lab - will ensure a streamlined process resulting in operational effectiveness and more efficient farm outcomes.',
          responsibilities: [
            'Designed and developed apps with Map Kit and Google Maps.',
            'I worked with SQLite.',
            'Developed library for managing Grid Layout for maps.',
            'Collaborated with the team and supported written standard code.',
            'Developed a custom UI component.',
          ],
        ),
      ],
    ),
    ExperienceGroup(
      company: 'Contus Support Interactive',
      role: 'Application Developer',
      location: 'Chennai',
      timeline: 'April 2021 - September 2021',
      projects: [
        Project(
          name: 'WONET',
          technology: 'iOS (Swift)',
          description:
              'WONET (iOS, Swift) is a leading mobile App with a friendly experience for chat, voice, and video communication in a highly secure way. It uses highly secured protocols to ensure highly secured and private communication among its users.',
          responsibilities: [
            'Designed and developed with two phases of tasks and successfully submitted to the App store.',
            'Integrated with signal protocol to send a secured encrypted and decrypted message.',
            'Worked on XMPP and WebRTC.',
            'Revamped the major feature code.',
            'Developed UI components.',
            'Bug fixing.',
            'Worked with push notification.',
          ],
        ),
      ],
    ),
    ExperienceGroup(
      company: 'W2S Solutions',
      role: 'iOS Developer',
      location: 'Chennai',
      timeline: 'February 2020 - March 2021',
      projects: [
        Project(
          name: 'MANAGETEAMZ DELIVERY',
          technology: 'iOS (Objective C)',
          description:
              'MANAGETEAMZ DELIVERY (iOS - Objective C) is a delivery management application where the delivery agent views the assigned tasks to deliver products to the customer at their location. It uses an optimized route for navigation to the customer location and gets acknowledgment for the delivered product from the customer. It has a web dashboard which enables the business owner to manage his delivery agents and keep track of their location.',
          responsibilities: [
            'Designed and developed one to one chat features using WebSocket with Back-end API integration and RESTFUL services.',
            'Support to develop core features with Google Map API and Google Place API.',
            'Integrated Phone number authentication with firebase.',
            'Implemented with MVVM design architecture.',
            'Bug fixing.',
          ],
        ),
      ],
    ),
  ];
}
