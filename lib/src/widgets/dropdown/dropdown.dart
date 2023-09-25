import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/theme/tokens/shadows.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';

enum MoonDropdownAnchorPosition {
  top,
  topLeft,
  topRight,
  bottom,
  bottomLeft,
  bottomRight,
  left,
  right,
  vertical,
  horizontal,
}

class MoonDropdown extends StatefulWidget {
  /// Sets the dropdown anchor position on dropdown content (follower).
  ///
  /// Note: this will override [MoonDropdownAnchorPosition] property.
  final Alignment? followerAnchor;

  /// Sets the dropdown anchor position on the child (target).
  ///
  /// Note: this will override [MoonDropdownAnchorPosition] property.
  final Alignment? targetAnchor;

  /// If true, the dropdown will be constrained to the width of its child (target).
  final bool constrainWidthToChild;

  /// Controls the dropdown visibility.
  final bool show;

  /// The border radius of the dropdown.
  final BorderRadiusGeometry? borderRadius;

  /// The color of the dropdown background.
  final Color? backgroundColor;

  /// The color of the dropdown border.
  final Color borderColor;

  /// Custom decoration for the dropdown.
  final Decoration? decoration;

  /// The width of the dropdown border.
  final double borderWidth;

  /// The distance from the tip of the dropdown arrow (tail) to the target widget.
  ///
  /// Note: this will be overriden by the [offset] property.
  final double? distanceToTarget;

  /// Optional size constraint. If a constraint is not set the size will adjust to the content.
  final double? minHeight;

  /// Optional size constraint. If a constraint is not set the size will adjust to the content.
  final double? minWidth;

  /// Optional size constraint. If a constraint is not set the size will adjust to the content.
  final double? maxHeight;

  /// Optional size constraint. If a constraint is not set the size will adjust to the content.
  final double? maxWidth;

  /// Dropdown transition duration (fade in or out animation).
  final Duration? transitionDuration;

  /// Dropdown transition curve (fade in or out animation).
  final Curve? transitionCurve;

  /// Padding around the dropdown content.
  final EdgeInsetsGeometry? contentPadding;

  /// The margin around dropdown. Used to prevent the dropdown from touching the edges of the viewport.
  final EdgeInsetsGeometry? dropdownMargin;

  /// List of dropdown shadows.
  final List<BoxShadow>? dropdownShadows;

  /// Sets the dropdown anchor position on the child (target). Defaults to [MoonDropdownAnchorPosition.bottom]
  ///
  /// Note: this is a convenience property whose parameters either will be overriden or ignored when using
  /// [followerAnchor], [targetAnchor], [offset] or [maxWidth] properties.
  final MoonDropdownAnchorPosition dropdownAnchorPosition;

  /// The offset of the dropdown.
  ///
  /// Note: this will override [distanceToTarget] property.
  final Offset? offset;

  /// `RouteObserver` used to listen for route changes that will hide the dropdown when the widget's route is not active.
  final RouteObserver<PageRoute<dynamic>>? routeObserver;

  /// The group id of the dropdown. Used to prevent the dropdown from closing when tapping inside nested dropdowns with
  /// the same group id.
  final String? groupId;

  /// The semantic label for the dropdown.
  final String? semanticLabel;

  /// Callback that is called when the user taps outside the dropdown.
  final VoidCallback? onTapOutside;

  /// The child (target) of the dropdown.
  final Widget child;

  /// The widget that its placed inside the dropdown and functions as its content.
  final Widget content;

  /// MDS dropdown widget.
  const MoonDropdown({
    super.key,
    required this.show,
    this.followerAnchor,
    this.targetAnchor,
    this.constrainWidthToChild = false,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor = Colors.transparent,
    this.decoration,
    this.borderWidth = 0,
    this.distanceToTarget,
    this.minHeight,
    this.minWidth,
    this.maxHeight,
    this.maxWidth,
    this.transitionDuration,
    this.transitionCurve,
    this.contentPadding,
    this.dropdownMargin,
    this.dropdownShadows,
    this.dropdownAnchorPosition = MoonDropdownAnchorPosition.bottom,
    this.offset,
    this.routeObserver,
    this.groupId,
    this.semanticLabel,
    this.onTapOutside,
    required this.child,
    required this.content,
  });

  @override
  _MoonDropdownState createState() => _MoonDropdownState();
}

class _MoonDropdownState extends State<MoonDropdown> with RouteAware, SingleTickerProviderStateMixin {
  late final Key _regionKey = widget.groupId != null ? ValueKey(widget.groupId) : ObjectKey(widget);
  final LayerLink _layerLink = LayerLink();

  AnimationController? _animationController;
  CurvedAnimation? _curvedAnimation;

  OverlayEntry? _overlayEntry;

  bool _routeIsShowing = true;

  bool get shouldShowdropdown => widget.show && _routeIsShowing;

  void _showDropdown() {
    _overlayEntry = OverlayEntry(builder: (BuildContext context) => _createOverlayContent());
    Overlay.of(context).insert(_overlayEntry!);

    _animationController!.value = 0;
    _animationController!.forward();
  }

  void _updateDropdown() {
    _overlayEntry?.markNeedsBuild();
  }

  void _removeDropdown({bool immediately = false}) {
    if (immediately) {
      _clearOverlayEntry();
    } else {
      _animationController!.value = 1;
      _animationController!.reverse().then((value) => _clearOverlayEntry());
    }
  }

  void _handleTapOutside() {
    widget.onTapOutside?.call();
  }

  void _clearOverlayEntry() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  _DropdownPositionProperties _resolveDropdownPositionParameters({
    required MoonDropdownAnchorPosition dropdownAnchorPosition,
    required double distanceToTarget,
    required double overlayWidth,
    required double dropdownTargetGlobalLeft,
    required double dropdownTargetGlobalCenter,
    required double dropdownTargetGlobalRight,
    required EdgeInsets dropdownMargin,
  }) {
    switch (dropdownAnchorPosition) {
      case MoonDropdownAnchorPosition.top:
        return _DropdownPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topCenter,
          followerAnchor: Alignment.bottomCenter,
          dropdownMaxWidth:
              overlayWidth - ((overlayWidth / 2 - dropdownTargetGlobalCenter) * 2).abs() - dropdownMargin.horizontal,
        );

      case MoonDropdownAnchorPosition.bottom:
        return _DropdownPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomCenter,
          followerAnchor: Alignment.topCenter,
          dropdownMaxWidth:
              overlayWidth - ((overlayWidth / 2 - dropdownTargetGlobalCenter) * 2).abs() - dropdownMargin.horizontal,
        );

      case MoonDropdownAnchorPosition.left:
        return _DropdownPositionProperties(
          offset: Offset(-distanceToTarget, 0),
          targetAnchor: Alignment.centerLeft,
          followerAnchor: Alignment.centerRight,
          dropdownMaxWidth: dropdownTargetGlobalLeft - distanceToTarget - dropdownMargin.left,
        );

      case MoonDropdownAnchorPosition.right:
        return _DropdownPositionProperties(
          offset: Offset(distanceToTarget, 0),
          targetAnchor: Alignment.centerRight,
          followerAnchor: Alignment.centerLeft,
          dropdownMaxWidth: overlayWidth - dropdownTargetGlobalRight - distanceToTarget - dropdownMargin.right,
        );

      case MoonDropdownAnchorPosition.topLeft:
        return _DropdownPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topLeft,
          followerAnchor: Alignment.bottomLeft,
          dropdownMaxWidth: overlayWidth - dropdownTargetGlobalLeft - dropdownMargin.left,
        );

      case MoonDropdownAnchorPosition.topRight:
        return _DropdownPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topRight,
          followerAnchor: Alignment.bottomRight,
          dropdownMaxWidth: dropdownTargetGlobalRight - dropdownMargin.right,
        );

      case MoonDropdownAnchorPosition.bottomLeft:
        return _DropdownPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          dropdownMaxWidth: overlayWidth - dropdownTargetGlobalLeft - dropdownMargin.left,
        );

      case MoonDropdownAnchorPosition.bottomRight:
        return _DropdownPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomRight,
          followerAnchor: Alignment.topRight,
          dropdownMaxWidth: dropdownTargetGlobalRight - dropdownMargin.right,
        );

      default:
        throw AssertionError("No match: $dropdownAnchorPosition");
    }
  }

  @override
  void didPush() {
    _routeIsShowing = true;
    // Route was pushed onto navigator and is now topmost route.
    if (shouldShowdropdown) {
      _removeDropdown();

      WidgetsBinding.instance.addPostFrameCallback((Duration _) {
        if (!mounted) return;

        _showDropdown();
      });
    }
  }

  @override
  void didPushNext() {
    _routeIsShowing = false;

    _removeDropdown();
  }

  @override
  Future<void> didPopNext() async {
    _routeIsShowing = true;

    if (shouldShowdropdown) {
      // Covering route was popped off the navigator.
      _removeDropdown();

      await Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) _showDropdown();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      widget.routeObserver?.subscribe(this, ModalRoute.of(context)! as PageRoute<dynamic>);
    });
  }

  @override
  void didUpdateWidget(MoonDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.routeObserver != widget.routeObserver) {
      oldWidget.routeObserver?.unsubscribe(this);
      widget.routeObserver?.subscribe(this, ModalRoute.of(context)! as PageRoute<dynamic>);
    }

    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      if (!_routeIsShowing) return;

      if (oldWidget.dropdownAnchorPosition != widget.dropdownAnchorPosition) {
        _removeDropdown(immediately: true);
        _showDropdown();
      } else if (shouldShowdropdown && _overlayEntry == null) {
        _showDropdown();
      } else if (!shouldShowdropdown && _overlayEntry != null) {
        _removeDropdown();
      }

      _updateDropdown();
    });
  }

  @override
  void deactivate() {
    if (_overlayEntry != null) _removeDropdown(immediately: true);

    super.deactivate();
  }

  @override
  void dispose() {
    if (_overlayEntry != null) _removeDropdown(immediately: true);

    widget.routeObserver?.unsubscribe(this);

    super.dispose();
  }

  Widget _createOverlayContent() {
    final BorderRadiusGeometry effectiveBorderRadius =
        widget.borderRadius ?? context.moonTheme?.dropdownTheme.properties.borderRadius ?? BorderRadius.circular(12);

    final Color effectiveBackgroundColor =
        widget.backgroundColor ?? context.moonTheme?.dropdownTheme.colors.backgroundColor ?? MoonColors.light.goku;

    final Color effectiveTextColor = context.moonTheme?.dropdownTheme.colors.textColor ?? MoonColors.light.textPrimary;

    final Color effectiveIconColor = context.moonTheme?.dropdownTheme.colors.iconColor ?? MoonColors.light.iconPrimary;

    final TextStyle effectiveTextStyle =
        context.moonTheme?.dropdownTheme.properties.textStyle ?? MoonTypography.typography.body.textDefault;

    final double effectiveDistanceToTarget =
        widget.distanceToTarget ?? context.moonTheme?.dropdownTheme.properties.distanceToTarget ?? MoonSizes.sizes.x4s;

    final EdgeInsetsGeometry effectiveContentPadding =
        widget.contentPadding ?? context.moonTheme?.dropdownTheme.properties.contentPadding ?? const EdgeInsets.all(4);

    final EdgeInsets resolvedContentPadding = effectiveContentPadding.resolve(Directionality.of(context));

    final EdgeInsetsGeometry effectiveDropdownMargin =
        widget.dropdownMargin ?? context.moonTheme?.dropdownTheme.properties.dropdownMargin ?? const EdgeInsets.all(8);

    final EdgeInsets resolvedDropdownMargin = effectiveDropdownMargin.resolve(Directionality.of(context));

    final List<BoxShadow> effectivedropdownShadows =
        widget.dropdownShadows ?? context.moonTheme?.dropdownTheme.shadows.dropdownShadows ?? MoonShadows.light.sm;

    MoonDropdownAnchorPosition dropdownAnchorPosition = widget.dropdownAnchorPosition;

    final RenderBox overlayRenderBox = Overlay.of(context).context.findRenderObject()! as RenderBox;

    final RenderBox targetRenderBox = context.findRenderObject()! as RenderBox;

    final Offset dropdownTargetGlobalCenter =
        targetRenderBox.localToGlobal(targetRenderBox.size.center(Offset.zero), ancestor: overlayRenderBox);

    final Offset dropdownTargetGlobalLeft =
        targetRenderBox.localToGlobal(targetRenderBox.size.centerLeft(Offset.zero), ancestor: overlayRenderBox);

    final Offset dropdownTargetGlobalRight =
        targetRenderBox.localToGlobal(targetRenderBox.size.centerRight(Offset.zero), ancestor: overlayRenderBox);

    if (Directionality.of(context) == TextDirection.rtl ||
        dropdownAnchorPosition == MoonDropdownAnchorPosition.horizontal ||
        dropdownAnchorPosition == MoonDropdownAnchorPosition.vertical) {
      switch (dropdownAnchorPosition) {
        case MoonDropdownAnchorPosition.left:
          dropdownAnchorPosition = MoonDropdownAnchorPosition.right;
        case MoonDropdownAnchorPosition.right:
          dropdownAnchorPosition = MoonDropdownAnchorPosition.left;
        case MoonDropdownAnchorPosition.topLeft:
          dropdownAnchorPosition = MoonDropdownAnchorPosition.topRight;
        case MoonDropdownAnchorPosition.topRight:
          dropdownAnchorPosition = MoonDropdownAnchorPosition.topLeft;
        case MoonDropdownAnchorPosition.bottomLeft:
          dropdownAnchorPosition = MoonDropdownAnchorPosition.bottomRight;
        case MoonDropdownAnchorPosition.bottomRight:
          dropdownAnchorPosition = MoonDropdownAnchorPosition.bottomLeft;
        case MoonDropdownAnchorPosition.vertical:
          dropdownAnchorPosition = dropdownTargetGlobalCenter.dy < overlayRenderBox.size.center(Offset.zero).dy
              ? MoonDropdownAnchorPosition.bottom
              : MoonDropdownAnchorPosition.top;
        case MoonDropdownAnchorPosition.horizontal:
          dropdownAnchorPosition = dropdownTargetGlobalCenter.dx < overlayRenderBox.size.center(Offset.zero).dx
              ? MoonDropdownAnchorPosition.right
              : MoonDropdownAnchorPosition.left;
        default:
          break;
      }
    }

    final _DropdownPositionProperties dropdownAnchorPositionParameters = _resolveDropdownPositionParameters(
      dropdownAnchorPosition: dropdownAnchorPosition,
      distanceToTarget: effectiveDistanceToTarget,
      overlayWidth: overlayRenderBox.size.width,
      dropdownTargetGlobalLeft: dropdownTargetGlobalLeft.dx,
      dropdownTargetGlobalCenter: dropdownTargetGlobalCenter.dx,
      dropdownTargetGlobalRight: dropdownTargetGlobalRight.dx,
      dropdownMargin: resolvedDropdownMargin,
    );

    final double targetWidth = targetRenderBox.size.width;

    final double effectiveDropdownWidth = widget.constrainWidthToChild
        ? targetWidth
        : widget.maxWidth != null
            ? widget.maxWidth!
            : dropdownAnchorPositionParameters.dropdownMaxWidth;

    return Semantics(
      label: widget.semanticLabel,
      child: UnconstrainedBox(
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: widget.offset ?? dropdownAnchorPositionParameters.offset,
          followerAnchor: widget.followerAnchor ?? dropdownAnchorPositionParameters.followerAnchor,
          targetAnchor: widget.targetAnchor ?? dropdownAnchorPositionParameters.targetAnchor,
          child: TapRegion(
            groupId: _regionKey,
            behavior: HitTestBehavior.translucent,
            onTapOutside: (PointerDownEvent _) => _handleTapOutside(),
            child: RepaintBoundary(
              child: FadeTransition(
                opacity: _curvedAnimation!,
                child: IconTheme(
                  data: IconThemeData(color: effectiveIconColor),
                  child: DefaultTextStyle(
                    style: effectiveTextStyle.copyWith(color: effectiveTextColor),
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: widget.minHeight ?? 0,
                        maxHeight: widget.maxHeight ?? double.infinity,
                        minWidth: widget.minWidth ?? 0,
                        maxWidth: effectiveDropdownWidth,
                      ),
                      padding: resolvedContentPadding,
                      decoration: widget.decoration ??
                          ShapeDecorationWithPremultipliedAlpha(
                            color: effectiveBackgroundColor,
                            shadows: effectivedropdownShadows,
                            shape: MoonSquircleBorder(
                              borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
                              side: BorderSide(color: widget.borderColor),
                            ),
                          ),
                      child: Directionality(
                        textDirection: Directionality.of(context),
                        child: widget.content,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.dropdownTheme.properties.transitionDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveTransitionCurve = widget.transitionCurve ??
        context.moonTheme?.dropdownTheme.properties.transitionCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    _animationController ??= AnimationController(
      duration: effectiveTransitionDuration,
      vsync: this,
    );

    _curvedAnimation ??= CurvedAnimation(
      parent: _animationController!,
      curve: effectiveTransitionCurve,
    );

    return TapRegion(
      groupId: _regionKey,
      behavior: HitTestBehavior.translucent,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: widget.child,
      ),
    );
  }
}

class _DropdownPositionProperties {
  final Alignment followerAnchor;
  final Alignment targetAnchor;
  final double dropdownMaxWidth;
  final Offset offset;

  _DropdownPositionProperties({
    required this.followerAnchor,
    required this.targetAnchor,
    required this.dropdownMaxWidth,
    required this.offset,
  });
}
