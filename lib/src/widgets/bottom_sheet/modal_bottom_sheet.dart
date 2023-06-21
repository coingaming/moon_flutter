import 'dart:async';

import 'package:flutter/material.dart';

import 'package:moon_design/moon_design.dart';

/// Shows a modal Moon Design bottom sheet.
Future<T?> showMoonModalBottomSheet<T>({
  AnimationController? secondAnimation,
  bool hasBounce = false,
  bool enableDrag = true,
  bool isExpanded = false,
  bool isDismissible = true,
  bool useRootNavigator = false,
  Clip? clipBehavior,
  Color? backgroundColor,
  Color? barrierColor,
  Curve? transitionCurve,
  double? closeProgressThreshold,
  double? elevation,
  Duration? duration,
  RouteSettings? settings,
  ShapeBorder? shape,
  required BuildContext context,
  required WidgetBuilder builder,
  required WidgetWithChildBuilder containerBuilder,
}) async {
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));

  final hasMaterialLocalizations = Localizations.of<MaterialLocalizations>(context, MaterialLocalizations) != null;
  final barrierLabel = hasMaterialLocalizations ? MaterialLocalizations.of(context).modalBarrierDismissLabel : "";

  final CapturedThemes themes = InheritedTheme.capture(
    from: context,
    to: Navigator.of(context, rootNavigator: useRootNavigator).context,
  );

  final result = await Navigator.of(context, rootNavigator: useRootNavigator).push(
    MoonModalBottomSheetRoute<T>(
      transitionCurve: transitionCurve,
      barrierLabel: barrierLabel,
      hasBounce: hasBounce,
      builder: builder,
      closeProgressThreshold: closeProgressThreshold,
      containerBuilder: containerBuilder,
      duration: duration,
      enableDrag: enableDrag,
      expanded: isExpanded,
      isDismissible: isDismissible,
      modalBarrierColor: barrierColor,
      secondAnimationController: secondAnimation,
      settings: settings,
      themes: themes,
    ),
  );

  return result;
}

const Duration _bottomSheetDuration = Duration(milliseconds: 200);

class MoonModalBottomSheetRoute<T> extends PageRoute<T> {
  final bool enableDrag;
  final bool expanded;
  final bool hasBounce;
  final bool isDismissible;
  final bool useSafeArea;
  final CapturedThemes? themes;
  final Color? modalBarrierColor;
  final Curve? transitionCurve;
  final double? closeProgressThreshold;
  final Duration duration;
  final AnimationController? secondAnimationController;
  final ScrollController? scrollController;
  final WidgetBuilder builder;
  final WidgetWithChildBuilder? containerBuilder;

  MoonModalBottomSheetRoute({
    this.closeProgressThreshold,
    this.containerBuilder,
    required this.builder,
    this.scrollController,
    this.barrierLabel,
    this.secondAnimationController,
    this.modalBarrierColor,
    this.isDismissible = true,
    this.enableDrag = true,
    required this.expanded,
    this.hasBounce = false,
    this.useSafeArea = true,
    this.transitionCurve,
    Duration? duration,
    super.settings,
    this.themes,
  }) : duration = duration ?? _bottomSheetDuration;

  AnimationController? _animationController;

  bool get _hasScopedWillPopCallback => hasScopedWillPopCallback;

  @override
  final String? barrierLabel;

  @override
  Duration get transitionDuration => duration;

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
        transitionCurve: transitionCurve,
        hasBounce: hasBounce,
        closeProgressThreshold: closeProgressThreshold,
        enableDrag: enableDrag,
        expanded: expanded,
        route: this,
        secondAnimationController: secondAnimationController,
      ),
    );

    return themes?.wrap(bottomSheet) ?? bottomSheet;
  }
}

class _ModalBottomSheet<T> extends StatefulWidget {
  final AnimationController? secondAnimationController;
  final bool hasBounce;
  final bool enableDrag;
  final bool expanded;
  final Curve? transitionCurve;
  final double? closeProgressThreshold;
  final MoonModalBottomSheetRoute<T> route;

  const _ModalBottomSheet({
    super.key,
    this.secondAnimationController,
    this.hasBounce = false,
    this.enableDrag = true,
    this.expanded = false,
    this.transitionCurve,
    this.closeProgressThreshold,
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

  @override
  void initState() {
    widget.route.animation?.addListener(updateController);
    super.initState();
  }

  @override
  void dispose() {
    widget.route.animation?.removeListener(updateController);
    _scrollController?.dispose();
    super.dispose();
  }

  void updateController() {
    final animation = widget.route.animation;
    if (animation != null) {
      widget.secondAnimationController?.value = animation.value;
    }
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
              scopesRoute: true,
              namesRoute: true,
              label: _getRouteLabel(),
              explicitChildNodes: true,
              child: MoonBottomSheet(
                closeProgressThreshold: widget.closeProgressThreshold,
                isExpanded: widget.route.expanded,
                containerBuilder: widget.route.containerBuilder,
                animationController: widget.route._animationController!,
                shouldClose: widget.route._hasScopedWillPopCallback
                    ? () async {
                        final willPop = await widget.route.willPop();
                        return willPop != RoutePopDisposition.doNotPop;
                      }
                    : null,
                onClosing: () {
                  if (widget.route.isCurrent) {
                    Navigator.of(context).pop();
                  }
                },
                enableDrag: widget.enableDrag,
                hasBounce: widget.hasBounce,
                scrollController: scrollController,
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
