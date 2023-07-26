import 'dart:async';

import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/widgets/bottom_sheet/bottom_sheet.dart';

/// Shows a modal Moon Design bottom sheet.
Future<T?> showMoonModalBottomSheet<T>({
  required BuildContext context,
  bool enableDrag = true,
  bool isExpanded = false,
  bool isDismissible = true,
  bool useRootNavigator = false,
  BorderRadiusGeometry? borderRadius,
  Color? backgroundColor,
  Color? barrierColor,
  Decoration? decoration,
  double? closeProgressThreshold,
  double? height,
  Duration? transitionDuration,
  Curve? transitionCurve,
  RouteSettings? settings,
  String? semanticLabel,
  AnimationController? animationController,
  required WidgetBuilder builder,
}) async {
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));

  final hasMaterialLocalizations = Localizations.of<MaterialLocalizations>(context, MaterialLocalizations) != null;
  final barrierLabel = hasMaterialLocalizations ? MaterialLocalizations.of(context).modalBarrierDismissLabel : '';

  final CapturedThemes themes = InheritedTheme.capture(
    from: context,
    to: Navigator.of(context, rootNavigator: useRootNavigator).context,
  );

  final Color effectiveBarrierColor =
      barrierColor ?? context.moonTheme?.bottomSheetTheme.colors.barrierColor ?? MoonColors.light.zeno;

  final Duration effectiveTransitionDuration = transitionDuration ??
      context.moonTheme?.bottomSheetTheme.properties.transitionDuration ??
      const Duration(milliseconds: 350);

  final Curve effectiveTransitionCurve = transitionCurve ??
      context.moonTheme?.bottomSheetTheme.properties.transitionCurve ??
      const Cubic(0.0, 0.0, 0.2, 1.0);

  final result = await Navigator.of(context, rootNavigator: useRootNavigator).push(
    MoonModalBottomSheetRoute<T>(
      enableDrag: enableDrag,
      isExpanded: isExpanded,
      isDismissible: isDismissible,
      borderRadius: borderRadius,
      themes: themes,
      backgroundColor: backgroundColor,
      modalBarrierColor: effectiveBarrierColor,
      decoration: decoration,
      closeProgressThreshold: closeProgressThreshold,
      height: height,
      animationDuration: effectiveTransitionDuration,
      animationCurve: effectiveTransitionCurve,
      settings: settings,
      semanticLabel: semanticLabel,
      barrierLabel: barrierLabel,
      animationController: animationController,
      builder: builder,
    ),
  );

  return result;
}

class MoonModalBottomSheetRoute<T> extends PageRoute<T> {
  final bool enableDrag;
  final bool isExpanded;
  final bool isDismissible;
  final BorderRadiusGeometry? borderRadius;
  final CapturedThemes? themes;
  final Color? backgroundColor;
  final Color modalBarrierColor;
  final Decoration? decoration;
  final double? closeProgressThreshold;
  final double? height;
  final Duration animationDuration;
  final Curve animationCurve;
  final String? semanticLabel;
  final AnimationController? animationController;
  final ScrollController? scrollController;
  final WidgetBuilder builder;

  MoonModalBottomSheetRoute({
    super.settings,
    this.enableDrag = true,
    this.isExpanded = false,
    this.isDismissible = true,
    this.borderRadius,
    this.themes,
    this.backgroundColor,
    required this.modalBarrierColor,
    this.decoration,
    this.closeProgressThreshold,
    this.height,
    required this.animationDuration,
    required this.animationCurve,
    this.barrierLabel,
    this.semanticLabel,
    this.animationController,
    this.scrollController,
    required this.builder,
  });

  AnimationController? _animationController;

  bool get _hasScopedWillPopCallback => hasScopedWillPopCallback;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => isDismissible;

  @override
  Color get barrierColor => modalBarrierColor;

  @override
  Duration get transitionDuration => animationDuration;

  @override
  final String? barrierLabel;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);

    _animationController = MoonBottomSheet.createAnimationController(
      navigator!.overlay!,
      transitionDuration,
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
        enableDrag: enableDrag,
        isExpanded: isExpanded,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor,
        decoration: decoration,
        closeProgressThreshold: closeProgressThreshold,
        height: height,
        transitionDuration: animationDuration,
        transitionCurve: animationCurve,
        semanticLabel: semanticLabel,
        animationController: animationController,
        route: this,
      ),
    );

    return themes?.wrap(bottomSheet) ?? bottomSheet;
  }
}

class _ModalBottomSheet<T> extends StatefulWidget {
  final bool enableDrag;
  final bool isExpanded;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Decoration? decoration;
  final double? closeProgressThreshold;
  final double? height;
  final Duration? transitionDuration;
  final Curve? transitionCurve;
  final String? semanticLabel;
  final AnimationController? animationController;
  final MoonModalBottomSheetRoute<T> route;

  const _ModalBottomSheet({
    super.key,
    this.enableDrag = true,
    this.isExpanded = false,
    this.borderRadius,
    this.backgroundColor,
    this.decoration,
    this.closeProgressThreshold,
    this.height,
    this.transitionDuration,
    this.transitionCurve,
    this.semanticLabel,
    this.animationController,
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

    // Used to relay the state of bottom sheet internal animation controller.
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
    widget.animationController?.dispose();
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
                enableDrag: widget.enableDrag,
                isExpanded: widget.route.isExpanded,
                borderRadius: widget.borderRadius,
                backgroundColor: widget.backgroundColor,
                decoration: widget.decoration,
                closeProgressThreshold: widget.closeProgressThreshold,
                height: widget.height,
                transitionDuration: widget.transitionDuration,
                transitionCurve: widget.transitionCurve,
                semanticLabel: widget.semanticLabel,
                onClosing: () => {if (widget.route.isCurrent) Navigator.of(context).pop()},
                shouldClose: widget.route._hasScopedWillPopCallback ? () => _handleShouldClose() : null,
                animationController: widget.route._animationController!,
                scrollController: scrollController,
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
