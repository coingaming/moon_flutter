enum HomePageContentType {
  headerTitle,
  headerSubtitle,
  bodyTitle;

  String get text => switch (this) {
        headerTitle => 'Moon Design System',
        headerSubtitle => 'Moon is Yolo Group product design system that helps'
            ' us maintain the integrity of their user experience and optimize '
            'design and development resources.',
        bodyTitle => 'Accelerate your mobile development journey with Flutter '
            'moon components.',
      };
}
