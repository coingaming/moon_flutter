// ignore_for_file: annotate_overrides, overridden_fields

import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/sizes.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/extensions.dart';

const double _singleLineVerticalPadding = 14.0;
const Duration _snackBarTransitionDuration = Duration(milliseconds: 250);
const Duration _snackBarDisplayDuration = Duration(milliseconds: 4000);
const Curve _snackBarHeightCurve = Curves.fastOutSlowIn;
const Curve _snackBarM3HeightCurve = Curves.easeInOutQuart;

const Curve _snackBarFadeInCurve = Interval(0.4, 1.0);
const Curve _snackBarM3FadeInCurve = Interval(0.4, 0.6, curve: Curves.easeInCirc);
const Curve _snackBarFadeOutCurve = Interval(0.72, 1.0, curve: Curves.fastOutSlowIn);

class MoonSnackbar extends SnackBar {
  /// The primary content of the snackbar.
  ///
  /// Typically a [Text] widget.
  final Widget content;

  /// The snackbar's background color.
  final Color? backgroundColor;

  /// Empty space to surround the snackbar.
  ///
  /// This property is only used when [behavior] is [SnackBarBehavior.floating].
  /// It can not be used if [width] is specified.
  final EdgeInsetsGeometry? margin;

  /// The amount of padding to apply to the snackbar's content and optional action.
  final EdgeInsets? padding;

  /// The gap between the children of the snackbar.
  final double? gap;

  /// The width of the snackbar.
  ///
  /// If width is specified, the snackbar will be centered horizontally in the available space. This property is only
  /// used when [behavior] is [SnackBarBehavior.floating]. It can not be used if [margin] is specified.
  final double? width;

  /// The border radius of the snackbar.
  final BorderRadius? borderRadius;

  /// This defines the behavior and location of the snackbar.
  ///
  /// Defines where a [MoonSnackbar] should appear within a [Scaffold] and how its location should be adjusted when the
  /// scaffold also includes a [FloatingActionButton] or a [BottomNavigationBar]
  ///
  /// If this property is null, then [SnackBarThemeData.behavior] of [SnackBarBehavior.fixed] is used.
  ///
  /// If this value is [SnackBarBehavior.floating], the length of the bar is defined by either [width] or [margin].
  final SnackBarBehavior? behavior;

  /// (optional) An action that the user can take based on the snackbar.
  ///
  /// For example, the snackbar might let the user undo the operation that prompted the snackbar. Snack bars can have
  /// at most one action.
  ///
  /// The action should not be "dismiss" or "cancel".
  final SnackBarAction? action;

  /// (optional) Whether to include a "close" icon widget.
  ///
  /// Tapping the icon will close the snackbar.
  final bool? showCloseIcon;

  /// (optional) An optional color for the close icon, if [showCloseIcon] is true.
  final Color? closeIconColor;

  /// The amount of time the snackbar should be displayed.
  ///
  /// Defaults to 4.0s.
  ///
  /// See also:
  ///
  ///  * [ScaffoldMessengerState.removeCurrentSnackBar], which abruptly hides the
  ///    currently displayed snackbar, if any, and allows the next to be
  ///    displayed.
  ///  * <https://material.io/design/components/snackbars.html>
  final Duration? displayDuration;

  /// Snackbar transition duration
  final Duration? transitionDuration;

  /// Snackbar transition duration
  final Curve? transitionCurve;

  /// The animation driving the entrance and exit of the snackbar.
  final Animation<double>? animation;

  /// Called the first time that the snackbar is visible within a [Scaffold].
  final VoidCallback? onVisible;

  /// The direction in which the MoonSnackbar can be dismissed.
  ///
  /// Cannot be null, defaults to [DismissDirection.down].
  final DismissDirection dismissDirection;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge], and must not be null.
  final Clip clipBehavior;

  /// Creates a snackbar.
  ///
  /// The [content] argument must be non-null. The [elevation] must be null or
  /// non-negative.
  const MoonSnackbar({
    super.key,
    required this.content,
    this.backgroundColor,
    this.margin,
    this.padding,
    this.gap,
    this.width,
    this.borderRadius,
    this.behavior,
    this.action,
    this.showCloseIcon,
    this.closeIconColor,
    this.displayDuration,
    this.transitionDuration,
    this.transitionCurve,
    this.animation,
    this.onVisible,
    this.dismissDirection = DismissDirection.down,
    this.clipBehavior = Clip.hardEdge,
  })  : assert(
          width == null || margin == null,
          'Width and margin can not be used together',
        ),
        super(content: const SizedBox.shrink());

  // API for ScaffoldMessengerState.showSnackBar():

  /// Creates an animation controller useful for driving a snackbar's entrance and exit animation.
  static AnimationController createAnimationController({required TickerProvider vsync}) {
    return AnimationController(
      duration: _snackBarTransitionDuration,
      debugLabel: 'MoonSnackbar',
      vsync: vsync,
    );
  }

  /// Creates a copy of this snackbar but with the animation replaced with the given animation.
  ///
  /// If the original snackbar lacks a key, the newly created snackbar will use the given fallback key.
  MoonSnackbar withAnimation(Animation<double> newAnimation, {Key? fallbackKey}) {
    return MoonSnackbar(
      key: key ?? fallbackKey,
      content: content,
      backgroundColor: backgroundColor,
      margin: margin,
      padding: padding,
      gap: gap,
      width: width,
      borderRadius: borderRadius,
      behavior: behavior,
      action: action,
      showCloseIcon: showCloseIcon,
      closeIconColor: closeIconColor,
      displayDuration: duration,
      animation: newAnimation,
      onVisible: onVisible,
      dismissDirection: dismissDirection,
      clipBehavior: clipBehavior,
    );
  }

  @override
  State<MoonSnackbar> createState() => _SnackBarState();
}

class _SnackBarState extends State<MoonSnackbar> {
  bool _wasVisible = false;

  @override
  void initState() {
    super.initState();
    widget.animation!.addStatusListener(_onAnimationStatusChanged);
  }

  @override
  void didUpdateWidget(MoonSnackbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animation != oldWidget.animation) {
      oldWidget.animation!.removeStatusListener(_onAnimationStatusChanged);
      widget.animation!.addStatusListener(_onAnimationStatusChanged);
    }
  }

  @override
  void dispose() {
    widget.animation!.removeStatusListener(_onAnimationStatusChanged);
    super.dispose();
  }

  void _onAnimationStatusChanged(AnimationStatus animationStatus) {
    switch (animationStatus) {
      case AnimationStatus.dismissed:
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
        break;
      case AnimationStatus.completed:
        if (widget.onVisible != null && !_wasVisible) {
          widget.onVisible!();
        }
        _wasVisible = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveBackgroundColor = widget.backgroundColor ??
        context.moonTheme?.snackbarTheme.colors.lightVariantBackgroundColor ??
        MoonColors.light.gohan;

    final BorderRadius effectiveBorderRadius = widget.borderRadius ??
        context.moonTheme?.snackbarTheme.properties.borderRadius ??
        MoonBorders.borders.surfaceSm;

    final EdgeInsets effectiveContentPadding = widget.padding ??
        context.moonTheme?.snackbarTheme.properties.contentPadding ??
        EdgeInsets.all(MoonSizes.sizes.x2s);

    final double effectiveGap = widget.gap ?? context.moonTheme?.snackbarTheme.properties.gap ?? MoonSizes.sizes.x2s;

    final Duration effectiveDisplayDuration = widget.displayDuration ??
        context.moonTheme?.snackbarTheme.properties.displayDuration ??
        const Duration(seconds: 5);

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.snackbarTheme.properties.transitionDuration ??
        const Duration(milliseconds: 200);

    final Curve effectiveTransitionCurve =
        widget.transitionCurve ?? context.moonTheme?.snackbarTheme.properties.transitionCurve ?? Curves.easeInOutCubic;

    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    final SnackBarBehavior snackBarBehavior = widget.behavior ?? SnackBarBehavior.fixed;
    final double? width = widget.width ?? 150;

    final bool showCloseIcon = widget.showCloseIcon ?? true;

    final bool isFloatingSnackBar = snackBarBehavior == SnackBarBehavior.floating;
    final double horizontalPadding = isFloatingSnackBar ? 16.0 : 24.0;
    final EdgeInsetsGeometry padding = widget.padding ??
        EdgeInsetsDirectional.only(
            start: horizontalPadding, end: widget.action != null || showCloseIcon ? 0 : horizontalPadding);

    final double actionHorizontalMargin = (widget.padding?.resolve(TextDirection.ltr).right ?? horizontalPadding) / 2;
    final double iconHorizontalMargin = (widget.padding?.resolve(TextDirection.ltr).right ?? horizontalPadding) / 12.0;

    final CurvedAnimation heightAnimation = CurvedAnimation(parent: widget.animation!, curve: _snackBarHeightCurve);
    final CurvedAnimation fadeInAnimation = CurvedAnimation(parent: widget.animation!, curve: _snackBarFadeInCurve);
    final CurvedAnimation fadeInM3Animation = CurvedAnimation(parent: widget.animation!, curve: _snackBarM3FadeInCurve);

    final CurvedAnimation fadeOutAnimation = CurvedAnimation(
      parent: widget.animation!,
      curve: _snackBarFadeOutCurve,
      reverseCurve: const Threshold(0.0),
    );
    // Material 3 Animation has a height animation on entry, but a direct fade out on exit.
    final CurvedAnimation heightM3Animation = CurvedAnimation(
      parent: widget.animation!,
      curve: _snackBarM3HeightCurve,
      reverseCurve: const Threshold(0.0),
    );

    final IconButton? iconButton = showCloseIcon
        ? IconButton(
            icon: const Icon(Icons.close),
            iconSize: 24.0,
            color: widget.closeIconColor ?? Colors.black,
            onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss),
          )
        : null;

    // Calculate combined width of Action, Icon, and their padding, if they are present.
    final TextPainter actionTextPainter = TextPainter(
        text: TextSpan(
          text: widget.action?.label ?? '',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout();
    final double actionAndIconWidth = actionTextPainter.size.width +
        (widget.action != null ? actionHorizontalMargin : 0) +
        (showCloseIcon ? (iconButton?.iconSize ?? 0 + iconHorizontalMargin) : 0);

    final EdgeInsets margin = EdgeInsets.all(8);

    final double snackBarWidth = widget.width ?? 150;
    // Action and Icon will overflow to a new line if their width is greater
    // than one quarter of the total Snack Bar width.
    final bool actionLineOverflow = actionAndIconWidth / snackBarWidth > 0.25;

    final List<Widget> maybeActionAndIcon = <Widget>[
      if (widget.action != null)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: actionHorizontalMargin),
          child: TextButtonTheme(
            data: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              ),
            ),
            child: widget.action!,
          ),
        ),
      if (showCloseIcon)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: iconHorizontalMargin),
          child: iconButton,
        ),
    ];

    Widget snackBar = Padding(
      padding: padding,
      child: Wrap(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding:
                      widget.padding == null ? const EdgeInsets.symmetric(vertical: _singleLineVerticalPadding) : null,
                  child: DefaultTextStyle(
                    style: TextStyle(),
                    child: widget.content,
                  ),
                ),
              ),
              if (!actionLineOverflow) ...maybeActionAndIcon,
              if (actionLineOverflow) SizedBox(width: snackBarWidth * 0.4),
            ],
          ),
          if (actionLineOverflow)
            Padding(
              padding: const EdgeInsets.only(bottom: _singleLineVerticalPadding),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: maybeActionAndIcon),
            ),
        ],
      ),
    );

    if (!isFloatingSnackBar) {
      snackBar = SafeArea(
        top: false,
        child: snackBar,
      );
    }

    snackBar = Theme(
      data: ThemeData(),
      child: mediaQueryData.accessibleNavigation
          ? snackBar
          : FadeTransition(
              opacity: fadeOutAnimation,
              child: snackBar,
            ),
    );

    if (isFloatingSnackBar) {
      // If width is provided, do not include horizontal margins.
      if (width != null) {
        snackBar = Container(
          margin: EdgeInsets.only(top: margin.top, bottom: margin.bottom),
          width: width,
          child: snackBar,
        );
      } else {
        snackBar = Padding(
          padding: margin,
          child: snackBar,
        );
      }
      snackBar = SafeArea(
        top: false,
        bottom: false,
        child: snackBar,
      );
    }

    snackBar = Semantics(
      container: true,
      liveRegion: true,
      onDismiss: () {
        ScaffoldMessenger.of(context).removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
      },
      child: Dismissible(
        key: const Key('dismissible'),
        direction: widget.dismissDirection,
        resizeDuration: null,
        onDismissed: (DismissDirection direction) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar(reason: SnackBarClosedReason.swipe);
        },
        child: snackBar,
      ),
    );

    final Widget snackBarTransition;
    if (mediaQueryData.accessibleNavigation) {
      snackBarTransition = snackBar;
    } else if (isFloatingSnackBar) {
      snackBarTransition = FadeTransition(
        opacity: fadeInAnimation,
        child: snackBar,
      );
      // Is Material 3 Floating Snack Bar.
    } else if (isFloatingSnackBar) {
      snackBarTransition = FadeTransition(
        opacity: fadeInM3Animation,
        child: AnimatedBuilder(
          animation: heightM3Animation,
          builder: (BuildContext context, Widget? child) {
            return Align(
              alignment: AlignmentDirectional.bottomStart,
              heightFactor: heightM3Animation.value,
              child: child,
            );
          },
          child: snackBar,
        ),
      );
    } else {
      snackBarTransition = AnimatedBuilder(
        animation: heightAnimation,
        builder: (BuildContext context, Widget? child) {
          return Align(
            alignment: AlignmentDirectional.topStart,
            heightFactor: heightAnimation.value,
            child: child,
          );
        },
        child: snackBar,
      );
    }

    return Hero(
      tag: '<MoonSnackbar Hero tag - ${widget.content}>',
      transitionOnUserGestures: true,
      child: ClipRect(
        clipBehavior: widget.clipBehavior,
        child: snackBarTransition,
      ),
    );
  }
}
