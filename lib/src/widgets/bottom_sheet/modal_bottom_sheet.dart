import 'dart:async';

import 'package:flutter/material.dart';

import 'package:moon_design/moon_design.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';

/// Shows a modal Moon Design bottom sheet.
Future<T?> showMoonModalBottomSheet<T>({
  AnimationController? animationController,
  bool hasBounce = false,
  bool enableDrag = true,
  bool isExpanded = false,
  bool isDismissible = true,
  bool useRootNavigator = false,
  BorderRadiusGeometry? borderRadius,
  Color? backgroundColor,
  Color? barrierColor,
  Decoration? decoration,
  double? closeProgressThreshold,
  RouteSettings? settings,
  Duration? transitionDuration,
  Curve? transitionCurve,
  required BuildContext context,
  required WidgetBuilder builder,
}) async {
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));

  final hasMaterialLocalizations = Localizations.of<MaterialLocalizations>(context, MaterialLocalizations) != null;
  final barrierLabel = hasMaterialLocalizations ? MaterialLocalizations.of(context).modalBarrierDismissLabel : "";

  final CapturedThemes themes = InheritedTheme.capture(
    from: context,
    to: Navigator.of(context, rootNavigator: useRootNavigator).context,
  );

  final Color effectiveBarrierColor =
      barrierColor ?? context.moonTheme?.bottomSheetTheme.colors.barrierColor ?? MoonColors.light.zeno;

  final Duration effectiveTransitionDuration = transitionDuration ??
      context.moonTheme?.bottomSheetTheme.properties.transitionDuration ??
      MoonTransitions.transitions.defaultTransitionDuration;

  final Curve effectiveTransitionCurve = transitionCurve ??
      context.moonTheme?.bottomSheetTheme.properties.transitionCurve ??
      MoonTransitions.transitions.defaultTransitionCurve;

  final result = await Navigator.of(context, rootNavigator: useRootNavigator).push(
    MoonModalBottomSheetRoute<T>(
      barrierLabel: barrierLabel,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      decoration: decoration,
      themes: themes,
      animationController: animationController,
      hasBounce: hasBounce,
      enableDrag: enableDrag,
      isExpanded: isExpanded,
      isDismissible: isDismissible,
      modalBarrierColor: effectiveBarrierColor,
      closeProgressThreshold: closeProgressThreshold,
      settings: settings,
      animationDuration: effectiveTransitionDuration,
      animationCurve: effectiveTransitionCurve,
      builder: builder,
    ),
  );

  return result;
}

//const Duration _bottomSheetDuration = Duration(milliseconds: 200);

class MoonModalBottomSheetRoute<T> extends PageRoute<T> {
  final AnimationController? animationController;
  final bool enableDrag;
  final bool isExpanded;
  final bool hasBounce;
  final bool isDismissible;
  final BorderRadiusGeometry? borderRadius;
  final CapturedThemes? themes;
  final Color? backgroundColor;
  final Color? modalBarrierColor;
  final Decoration? decoration;
  final double? closeProgressThreshold;
  final ScrollController? scrollController;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final WidgetBuilder builder;

  MoonModalBottomSheetRoute({
    super.settings,
    this.barrierLabel,
    this.animationController,
    this.enableDrag = true,
    required this.isExpanded,
    this.hasBounce = false,
    this.isDismissible = true,
    this.borderRadius,
    this.themes,
    this.backgroundColor,
    this.modalBarrierColor,
    this.decoration,
    this.closeProgressThreshold,
    this.scrollController,
    this.animationDuration,
    this.animationCurve,
    required this.builder,
  });

  AnimationController? _animationController;

  bool get _hasScopedWillPopCallback => hasScopedWillPopCallback;

  @override
  final String? barrierLabel;

  @override
  Duration get transitionDuration => animationDuration ?? MoonTransitions.transitions.defaultTransitionDuration;

  @override
  bool get barrierDismissible => isDismissible;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Color get barrierColor => modalBarrierColor ?? Colors.black.withOpacity(0.35);

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);

    _animationController = MoonBottomSheet.createAnimationController(
      navigator!.overlay!,
      duration: transitionDuration,
    );

    return _animationController!;
  }

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) => nextRoute is MoonModalBottomSheetRoute;

  @override
  bool canTransitionFrom(TransitionRoute<dynamic> previousRoute) =>
      previousRoute is MoonModalBottomSheetRoute || previousRoute is PageRoute;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    // By definition, the bottom sheet is aligned to the bottom of the page
    // and isn't exposed to the top padding of the MediaQuery.
    final Widget bottomSheet = MediaQuery.removePadding(
      context: context,
      child: _ModalBottomSheet<T>(
        borderRadius: borderRadius,
        animationController: animationController,
        backgroundColor: backgroundColor,
        decoration: decoration,
        hasBounce: hasBounce,
        enableDrag: enableDrag,
        isExpanded: isExpanded,
        closeProgressThreshold: closeProgressThreshold,
        transitionDuration: animationDuration,
        transitionCurve: animationCurve,
        route: this,
      ),
    );

    return themes?.wrap(bottomSheet) ?? bottomSheet;
  }
}

class _ModalBottomSheet<T> extends StatefulWidget {
  final AnimationController? animationController;
  final BorderRadiusGeometry? borderRadius;
  final bool hasBounce;
  final bool enableDrag;
  final bool isExpanded;
  final Color? backgroundColor;
  final Decoration? decoration;
  final double? closeProgressThreshold;
  final Duration? transitionDuration;
  final Curve? transitionCurve;
  final MoonModalBottomSheetRoute<T> route;

  const _ModalBottomSheet({
    super.key,
    this.animationController,
    this.borderRadius,
    this.hasBounce = false,
    this.enableDrag = true,
    this.isExpanded = false,
    this.backgroundColor,
    this.decoration,
    this.closeProgressThreshold,
    this.transitionDuration,
    this.transitionCurve,
    required this.route,
  });

  @override
  _ModalBottomSheetState<T> createState() => _ModalBottomSheetState<T>();
}

class _ModalBottomSheetState<T> extends State<_ModalBottomSheet<T>> {
  ScrollController? _scrollController;

  String _getRouteLabel() {
    final platform = Theme.of(context).platform;
    switch (platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return '';
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        if (Localizations.of<MaterialLocalizations>(context, MaterialLocalizations) != null) {
          return MaterialLocalizations.of(context).dialogLabel;
        } else {
          return const DefaultMaterialLocalizations().dialogLabel;
        }
    }
  }

  Future<bool> _handleShouldClose() async {
    final willPop = await widget.route.willPop();
    return willPop != RoutePopDisposition.doNotPop;
  }

  void _updateController() {
    final animation = widget.route.animation;
    if (animation != null) {
      widget.animationController?.value = animation.value;
    }
  }

  @override
  void initState() {
    super.initState();
    widget.route.animation?.addListener(_updateController);
  }

  @override
  void dispose() {
    widget.route.animation?.removeListener(_updateController);
    _scrollController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    assert(widget.route._animationController != null);

    final scrollController = PrimaryScrollController.maybeOf(context) ?? (_scrollController ??= ScrollController());

    return PrimaryScrollController(
      controller: scrollController,
      child: Builder(
        builder: (context) => AnimatedBuilder(
          animation: widget.route._animationController!,
          builder: (BuildContext context, Widget? child) {
            assert(child != null);
            return Semantics(
              explicitChildNodes: true,
              label: _getRouteLabel(),
              namesRoute: true,
              scopesRoute: true,
              child: MoonBottomSheet(
                backgroundColor: widget.backgroundColor,
                decoration: widget.decoration,
                borderRadius: widget.borderRadius,
                animationController: widget.route._animationController!,
                enableDrag: widget.enableDrag,
                hasBounce: widget.hasBounce,
                isExpanded: widget.route.isExpanded,
                closeProgressThreshold: widget.closeProgressThreshold,
                onClosing: () => {if (widget.route.isCurrent) Navigator.of(context).pop()},
                shouldClose: widget.route._hasScopedWillPopCallback ? () => _handleShouldClose() : null,
                scrollController: scrollController,
                //transitionDuration: widget.transitionDuration,
                transitionCurve: widget.transitionCurve,
                child: child!,
              ),
            );
          },
          child: widget.route.builder(context),
        ),
      ),
    );
  }
}
