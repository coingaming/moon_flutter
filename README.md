# Moon Design System

[![Version](https://img.shields.io/pub/v/moon_design.svg)](https://pub.dev/packages/moon_design) ![Build](https://github.com/coingaming/moon_flutter/actions/workflows/analyze_and_test.yml/badge.svg) [![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)

<img width="644" alt="Moon Design System" src="https://user-images.githubusercontent.com/232199/133601344-e63bd62f-dd0f-47a1-9d1e-b5cb065e5a90.png">

_Note: This project uses **[Release Please](https://github.com/googleapis/release-please)** and **[Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)** spec, please follow the conventions or consider using **[Commitizen](https://github.com/commitizen/cz-cli)**
to write commit messages._

## Disclaimer

The current major release, v1.0.0, will be maintained as-is and will not receive further updates, except for patches. The v1 theming is based on the soon-to-be deprecated Moon Design Figma v1 and lacks flexibility. For greater control over theming with v1 of moon_flutter, it is recommended to create custom wrapper widgets around the moon_flutter widgets that align with your project's specific theming requirements.

There is ongoing background work for v2 which aims to be more modular, scalable and themable.

## Resources

- 📱 [Playground](https://flutter.moon.io)

## Applying theming and overrides

- Declare tokens variable and optionally override values:

```dart
final lightTokens = MoonTokens.light.copyWith(
  colors: MoonColors.light.copyWith(
    piccolo: Colors.blue,
    textPrimary: Colors.amber,
  ),
  typography: MoonTypography.typography.copyWith(
    heading: MoonTypography.typography.heading.apply(
      // Using variable font and bumping down the font weight compared to the
      // baseline 600 for heading.
      fontFamily: "DMSans",
      fontWeightDelta: -1,
      fontVariations: [const FontVariation('wght', 500)],
    ),
  ),
);

final lightTheme = ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[MoonTheme(tokens: lightTokens)],
  );
```

- Or if needed override widget theming:

```dart
final lightTheme = ThemeData.light().copyWith(
  extensions: <ThemeExtension<dynamic>>[
    MoonTheme(tokens: lightTokens).copyWith(
      accordionTheme: MoonAccordionTheme(tokens: lightTokens).copyWith(
        colors: MoonAccordionTheme(tokens: lightTokens).colors.copyWith(
              backgroundColor: Colors.green,
            ),
      ),
    ),
  ],
);
```

- Apply the declared theme:

```dart
return MaterialApp(
      title: 'Moon Design System example',
      theme: lightTheme,
      home: const HomePage(),
 );
```
