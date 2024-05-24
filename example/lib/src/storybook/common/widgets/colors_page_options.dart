enum ColorsPageSection {
  header,
  mainColors,
  supportiveColors;

  String get titleText => switch (this) {
        header => 'Colors',
        mainColors => 'Main colors',
        supportiveColors => 'Supportive colors',
      };

  String get bodyText => switch (this) {
        header =>
          'Moon Design System is decentralized and intended to support multiple '
              'products. The use of different-color naming conventions and '
              'numbers makes maintenance more difficult. We decided to give '
              'each of our colors a distinct name, adopting the Dragon Ball Z '
              'approach. Each color name is assigned for a specific purpose, '
              'and the values vary according to the product. Please do not use '
              'hex values; they will not change if you need theme support.',
        mainColors =>
          'The main colors serve a specific purpose. piccolo and hit are used '
              'for accent colors; beerus for borders and lines; goku and gohan '
              'for backgrounds; bulma and trunks for text and icons; goten and '
              'popo for forced theme-less colors; and jiren, heles, and zeno '
              'for semi-transparent overlays.',
        supportiveColors =>
          'Every HEX color in all supportive colors is represented by three '
              'shades. The difference between shades is in their transparency '
              'levels. Some colors may have a semantic purpose. krillin is '
              'usually used for warnings, chichi for errors, and roshi for '
              'success colors. Other colors are used for variety of secondary '
              'reasons.'
      };
}
