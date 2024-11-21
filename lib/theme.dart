import "package:flutter/material.dart";

// ignore_for_file: use_full_hex_values_for_flutter_colors
class CustomMaterialTheme {
  final TextTheme textTheme;

  const CustomMaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4283390866),
      surfaceTint: Color(4283390866),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4292731391),
      onPrimaryContainer: Color(4278589003),
      secondary: Color(4280379981),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4289327821),
      onSecondaryContainer: Color(4278198548),
      tertiary: Color(4287189279),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294958275),
      onTertiaryContainer: Color(4281275648),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294703359),
      onSurface: Color(4279966497),
      onSurfaceVariant: Color(4282730063),
      outline: Color(4285953664),
      outlineVariant: Color(4291216848),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282614),
      inversePrimary: Color(4290299135),
      primaryFixed: Color(4292731391),
      onPrimaryFixed: Color(4278589003),
      primaryFixedDim: Color(4290299135),
      onPrimaryFixedVariant: Color(4281811833),
      secondaryFixed: Color(4289327821),
      onSecondaryFixed: Color(4278198548),
      secondaryFixedDim: Color(4287485362),
      onSecondaryFixedVariant: Color(4278210871),
      tertiaryFixed: Color(4294958275),
      onTertiaryFixed: Color(4281275648),
      tertiaryFixedDim: Color(4294948735),
      onTertiaryFixedVariant: Color(4285282824),
      surfaceDim: Color(4292598240),
      surfaceBright: Color(4294703359),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294308602),
      surfaceContainer: Color(4293914100),
      surfaceContainerHigh: Color(4293519343),
      surfaceContainerHighest: Color(4293124585),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4281548660),
      surfaceTint: Color(4283390866),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4284838570),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278209844),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4282089827),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4284954116),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4288898611),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294703359),
      onSurface: Color(4279966497),
      onSurfaceVariant: Color(4282466891),
      outline: Color(4284374631),
      outlineVariant: Color(4286216835),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282614),
      inversePrimary: Color(4290299135),
      primaryFixed: Color(4284838570),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4283193744),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4282089827),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280182859),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4288898611),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4286991901),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292598240),
      surfaceBright: Color(4294703359),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294308602),
      surfaceContainer: Color(4293914100),
      surfaceContainerHigh: Color(4293519343),
      surfaceContainerHighest: Color(4293124585),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4279180626),
      surfaceTint: Color(4283390866),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4281548660),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278200345),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4278209844),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281932288),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4284954116),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294703359),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280427307),
      outline: Color(4282466891),
      outlineVariant: Color(4282466891),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282614),
      inversePrimary: Color(4293520383),
      primaryFixed: Color(4281548660),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4279970141),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4278209844),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4278203426),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4284954116),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4282917632),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292598240),
      surfaceBright: Color(4294703359),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294308602),
      surfaceContainer: Color(4293914100),
      surfaceContainerHigh: Color(4293519343),
      surfaceContainerHighest: Color(4293124585),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4290299135),
      surfaceTint: Color(4290299135),
      onPrimary: Color(4280233057),
      primaryContainer: Color(4281811833),
      onPrimaryContainer: Color(4292731391),
      secondary: Color(4287485362),
      onSecondary: Color(4278204453),
      secondaryContainer: Color(4278210871),
      onSecondaryContainer: Color(4289327821),
      tertiary: Color(4294948735),
      onTertiary: Color(4283311616),
      tertiaryContainer: Color(4285282824),
      onTertiaryContainer: Color(4294958275),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279374616),
      onSurface: Color(4293124585),
      onSurfaceVariant: Color(4291216848),
      outline: Color(4287664282),
      outlineVariant: Color(4282730063),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293124585),
      inversePrimary: Color(4283390866),
      primaryFixed: Color(4292731391),
      onPrimaryFixed: Color(4278589003),
      primaryFixedDim: Color(4290299135),
      onPrimaryFixedVariant: Color(4281811833),
      secondaryFixed: Color(4289327821),
      onSecondaryFixed: Color(4278198548),
      secondaryFixedDim: Color(4287485362),
      onSecondaryFixedVariant: Color(4278210871),
      tertiaryFixed: Color(4294958275),
      onTertiaryFixed: Color(4281275648),
      tertiaryFixedDim: Color(4294948735),
      onTertiaryFixedVariant: Color(4285282824),
      surfaceDim: Color(4279374616),
      surfaceBright: Color(4281874751),
      surfaceContainerLowest: Color(4279045651),
      surfaceContainerLow: Color(4279966497),
      surfaceContainer: Color(4280229669),
      surfaceContainerHigh: Color(4280887855),
      surfaceContainerHighest: Color(4281611322),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4290627839),
      surfaceTint: Color(4290299135),
      onPrimary: Color(4278259782),
      primaryContainer: Color(4286680776),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4287814326),
      onSecondary: Color(4278197008),
      secondaryContainer: Color(4283997822),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294950282),
      onTertiary: Color(4280750080),
      tertiaryContainer: Color(4291068491),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279374616),
      onSurface: Color(4294769407),
      onSurfaceVariant: Color(4291480276),
      outline: Color(4288848556),
      outlineVariant: Color(4286743180),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293124585),
      inversePrimary: Color(4281877882),
      primaryFixed: Color(4292731391),
      onPrimaryFixed: Color(4278192955),
      primaryFixedDim: Color(4290299135),
      onPrimaryFixedVariant: Color(4280627815),
      secondaryFixed: Color(4289327821),
      onSecondaryFixed: Color(4278195467),
      secondaryFixedDim: Color(4287485362),
      onSecondaryFixedVariant: Color(4278206250),
      tertiaryFixed: Color(4294958275),
      onTertiaryFixed: Color(4280290304),
      tertiaryFixedDim: Color(4294948735),
      onTertiaryFixedVariant: Color(4283837184),
      surfaceDim: Color(4279374616),
      surfaceBright: Color(4281874751),
      surfaceContainerLowest: Color(4279045651),
      surfaceContainerLow: Color(4279966497),
      surfaceContainer: Color(4280229669),
      surfaceContainerHigh: Color(4280887855),
      surfaceContainerHighest: Color(4281611322),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294769407),
      surfaceTint: Color(4290299135),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4290627839),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4293853171),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4287814326),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294966008),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4294950282),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279374616),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294769407),
      outline: Color(4291480276),
      outlineVariant: Color(4291480276),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293124585),
      inversePrimary: Color(4279772762),
      primaryFixed: Color(4293125631),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4290627839),
      onPrimaryFixedVariant: Color(4278259782),
      secondaryFixed: Color(4289590993),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4287814326),
      onSecondaryFixedVariant: Color(4278197008),
      tertiaryFixed: Color(4294959565),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4294950282),
      onTertiaryFixedVariant: Color(4280750080),
      surfaceDim: Color(4279374616),
      surfaceBright: Color(4281874751),
      surfaceContainerLowest: Color(4279045651),
      surfaceContainerLow: Color(4279966497),
      surfaceContainer: Color(4280229669),
      surfaceContainerHigh: Color(4280887855),
      surfaceContainerHighest: Color(4281611322),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
