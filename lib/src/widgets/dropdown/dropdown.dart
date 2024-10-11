import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/shadows.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_tokens/moon_tokens.dart';

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
  /// Sets the dropdown anchor position on dropdown [content] (follower).
  ///
  /// Overrides the [MoonDropdownAnchorPosition] property.
  final Alignment? followerAnchor;

  /// Sets the dropdown anchor position on the [child] (target).
  ///
  /// Overrides the [MoonDropdownAnchorPosition] property.
  final Alignment? targetAnchor;

  /// Whether to constrain the dropdown to the width of its [child] (target).
  final bool constrainWidthToChild;

  /// Whether to show the dropdown.
  final bool show;

  /// The border radius of the dropdown.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the dropdown.
  final Color? backgroundColor;

  /// The border color of the dropdown.
  final Color borderColor;

  /// The custom decoration of the dropdown.
  final Decoration? decoration;

  /// The border width of the dropdown.
  final double borderWidth;

  /// The distance between the dropdown and the [child] (target).
  ///
  /// Overridden by the [offset] property if set.
  final double? distanceToTarget;

  /// An optional size constraint for the dropdown [content] to define its
  /// minimum height.
  ///
  /// If a constraint is not provided, the size will automatically adjust to the
  /// [content].
  final double? minHeight;

  /// An optional size constraint for the dropdown [content] to define its
  /// minimum width.
  ///
  /// If a constraint is not provided, the size will automatically adjust to the
  /// [content].
  final double? minWidth;

  /// An optional size constraint for the dropdown [content] to define its
  /// maximum height.
  ///
  /// If a constraint is not provided, the size will automatically adjust to the
  /// [content].
  final double? maxHeight;

  /// An optional size constraint for the dropdown [content] to define its
  /// maximum width.
  ///
  /// If a constraint is not provided, the size will automatically adjust to the
  /// [content].
  final double? maxWidth;

  /// The duration of the dropdown transition animation (fade in or out).
  final Duration? transitionDuration;

  /// The curve of the dropdown transition animation (fade in or out).
  final Curve? transitionCurve;

  /// The padding of the dropdown [content].
  final EdgeInsetsGeometry? contentPadding;

  /// The margin of the dropdown. Prevents the dropdown from touching the edges
  /// of the viewport.
  final EdgeInsetsGeometry? dropdownMargin;

  /// The list of shadows applied to the dropdown.
  final List<BoxShadow>? dropdownShadows;

  /// Sets the dropdown anchor position on the [child] (target).
  ///
  /// This is a convenience shorthand for setting the anchor position.
  /// This will be overridden by the [followerAnchor], [targetAnchor], [offset],
  /// or [maxWidth] properties if set.
  final MoonDropdownAnchorPosition dropdownAnchorPosition;

  /// The offset of the dropdown.
  ///
  /// Overrides the [distanceToTarget] property.
  final Offset? offset;

  /// The observer to keep track of the route changes and automatically hide
  /// the dropdown when the widget's route is not active.
  final RouteObserver<PageRoute<dynamic>>? routeObserver;

  /// The unique group ID of the dropdown.
  /// This ID is used to associate nested dropdowns and prevent them from
  /// closing when tapped inside each other.
  final String? groupId;

  /// The semantic label for the dropdown.
  final String? semanticLabel;

  /// The callback that is called when the user taps outside the dropdown.
  final VoidCallback? onTapOutside;

  /// The widget to display as the child (target) of the dropdown.
  final Widget child;

  /// The widget to display inside the dropdown as its content.
  final Widget content;

  /// Creates a Moon Design dropdown.
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

class _MoonDropdownState extends State<MoonDropdown>
    with RouteAware, SingleTickerProviderStateMixin {
  late final Key _regionKey =
      widget.groupId != null ? ValueKey(widget.groupId) : ObjectKey(widget);
  final LayerLink _layerLink = LayerLink();

  AnimationController? _animationController;
  CurvedAnimation? _curvedAnimation;

  OverlayEntry? _overlayEntry;

  bool _routeIsShowing = true;

  bool get shouldShowDropdown => widget.show && _routeIsShowing;

  void _showDropdown() {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _createOverlayContent(),
    );
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
          dropdownMaxWidth: overlayWidth -
              ((overlayWidth / 2 - dropdownTargetGlobalCenter) * 2).abs() -
              dropdownMargin.horizontal,
        );

      case MoonDropdownAnchorPosition.bottom:
        return _DropdownPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomCenter,
          followerAnchor: Alignment.topCenter,
          dropdownMaxWidth: overlayWidth -
              ((overlayWidth / 2 - dropdownTargetGlobalCenter) * 2).abs() -
              dropdownMargin.horizontal,
        );

      case MoonDropdownAnchorPosition.left:
        return _DropdownPositionProperties(
          offset: Offset(-distanceToTarget, 0),
          targetAnchor: Alignment.centerLeft,
          followerAnchor: Alignment.centerRight,
          dropdownMaxWidth:
              dropdownTargetGlobalLeft - distanceToTarget - dropdownMargin.left,
        );

      case MoonDropdownAnchorPosition.right:
        return _DropdownPositionProperties(
          offset: Offset(distanceToTarget, 0),
          targetAnchor: Alignment.centerRight,
          followerAnchor: Alignment.centerLeft,
          dropdownMaxWidth: overlayWidth -
              dropdownTargetGlobalRight -
              distanceToTarget -
              dropdownMargin.right,
        );

      case MoonDropdownAnchorPosition.topLeft:
        return _DropdownPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topLeft,
          followerAnchor: Alignment.bottomLeft,
          dropdownMaxWidth:
              overlayWidth - dropdownTargetGlobalLeft - dropdownMargin.left,
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
          dropdownMaxWidth:
              overlayWidth - dropdownTargetGlobalLeft - dropdownMargin.left,
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
    // Route was added to the navigator and is now the top-most route.
    if (shouldShowDropdown) {
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

    if (shouldShowDropdown) {
      // The covering route was popped off the navigator.
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
      widget.routeObserver
          ?.subscribe(this, ModalRoute.of(context)! as PageRoute<dynamic>);
    });
  }

  @override
  void didUpdateWidget(MoonDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.routeObserver != widget.routeObserver) {
      oldWidget.routeObserver?.unsubscribe(this);
      widget.routeObserver
          ?.subscribe(this, ModalRoute.of(context)! as PageRoute<dynamic>);
    }

    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      if (!_routeIsShowing) return;

      if (oldWidget.dropdownAnchorPosition != widget.dropdownAnchorPosition) {
        _removeDropdown(immediately: true);
        _showDropdown();
      } else if (shouldShowDropdown && _overlayEntry == null) {
        _showDropdown();
      } else if (!shouldShowDropdown && _overlayEntry != null) {
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
    final BorderRadiusGeometry effectiveBorderRadius = widget.borderRadius ??
        context.moonTheme?.dropdownTheme.properties.borderRadius ??
        BorderRadius.circular(12);

    final Color effectiveBackgroundColor = widget.backgroundColor ??
        context.moonTheme?.dropdownTheme.colors.backgroundColor ??
        MoonColors.light.goku;

    final Color effectiveTextColor =
        context.moonTheme?.dropdownTheme.colors.textColor ??
            MoonColors.light.textPrimary;

    final Color effectiveIconColor =
        context.moonTheme?.dropdownTheme.colors.iconColor ??
            MoonColors.light.iconPrimary;

    final TextStyle effectiveTextStyle =
        context.moonTheme?.dropdownTheme.properties.textStyle ??
            MoonTypography.typography.body.textDefault;

    final double effectiveDistanceToTarget = widget.distanceToTarget ??
        context.moonTheme?.dropdownTheme.properties.distanceToTarget ??
        MoonSizes.sizes.x4s;

    final EdgeInsetsGeometry effectiveContentPadding = widget.contentPadding ??
        context.moonTheme?.dropdownTheme.properties.contentPadding ??
        const EdgeInsets.all(4);

    final EdgeInsets resolvedContentPadding =
        effectiveContentPadding.resolve(Directionality.of(context));

    final EdgeInsetsGeometry effectiveDropdownMargin = widget.dropdownMargin ??
        context.moonTheme?.dropdownTheme.properties.dropdownMargin ??
        const EdgeInsets.all(8);

    final EdgeInsets resolvedDropdownMargin =
        effectiveDropdownMargin.resolve(Directionality.of(context));

    final List<BoxShadow> effectiveDropdownShadows = widget.dropdownShadows ??
        context.moonTheme?.dropdownTheme.shadows.dropdownShadows ??
        MoonShadows.light.sm;

    MoonDropdownAnchorPosition dropdownAnchorPosition =
        widget.dropdownAnchorPosition;

    final RenderBox overlayRenderBox =
        Overlay.of(context).context.findRenderObject()! as RenderBox;

    final RenderBox targetRenderBox = context.findRenderObject()! as RenderBox;

    final Offset dropdownTargetGlobalCenter = targetRenderBox.localToGlobal(
      targetRenderBox.size.center(Offset.zero),
      ancestor: overlayRenderBox,
    );

    final Offset dropdownTargetGlobalLeft = targetRenderBox.localToGlobal(
      targetRenderBox.size.centerLeft(Offset.zero),
      ancestor: overlayRenderBox,
    );

    final Offset dropdownTargetGlobalRight = targetRenderBox.localToGlobal(
      targetRenderBox.size.centerRight(Offset.zero),
      ancestor: overlayRenderBox,
    );

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
          dropdownAnchorPosition = dropdownTargetGlobalCenter.dy <
                  overlayRenderBox.size.center(Offset.zero).dy
              ? MoonDropdownAnchorPosition.bottom
              : MoonDropdownAnchorPosition.top;
        case MoonDropdownAnchorPosition.horizontal:
          dropdownAnchorPosition = dropdownTargetGlobalCenter.dx <
                  overlayRenderBox.size.center(Offset.zero).dx
              ? MoonDropdownAnchorPosition.right
              : MoonDropdownAnchorPosition.left;
        default:
          break;
      }
    }

    final _DropdownPositionProperties dropdownAnchorPositionParameters =
        _resolveDropdownPositionParameters(
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
          followerAnchor: widget.followerAnchor ??
              dropdownAnchorPositionParameters.followerAnchor,
          targetAnchor: widget.targetAnchor ??
              dropdownAnchorPositionParameters.targetAnchor,
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
                    style:
                        effectiveTextStyle.copyWith(color: effectiveTextColor),
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
                            shadows: effectiveDropdownShadows,
                            shape: MoonSquircleBorder(
                              borderRadius: effectiveBorderRadius
                                  .squircleBorderRadius(context),
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
