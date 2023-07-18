# Moon Design System
<p>
  <a href="https://conventionalcommits.org">
    <img alt="Conventional Commits" src="https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg">
  </a>
</p>



<img width="644" alt="Moon Design System" src="https://user-images.githubusercontent.com/232199/133601344-e63bd62f-dd0f-47a1-9d1e-b5cb065e5a90.png">

_Note: This project uses **[Release Please](https://github.com/googleapis/release-please)** and **[Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)** spec, please follow the conventions or consider using **[Commitizen](https://github.com/commitizen/cz-cli)**
to write commit messages._


## Resources

- 📱 [Playground](https://flutter.moon.io)


## Applying theming and overrides

- Declare tokens variable and optionally override values:

```dart
final lightTokens = MoonTokens.light.copyWith(
  colors: MoonColors.light.copyWith(
    piccolo: Colors.blue,
    bodyTextPrimary: Colors.amber,
  ),
  typography: MoonTypography.typography.copyWith(
    heading: MoonTypography.typography.heading.apply(fontFamily: "KumbhSans"),
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
      title: 'MDS example',
      theme: lightTheme,
      home: const HomePage(),
 );
```
