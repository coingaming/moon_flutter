import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_design/src/widgets/buttons/filled_button.dart';
import 'package:moon_design/src/widgets/dropdown/dropdown.dart';

const Key _dropdownKey = Key("dropdownKey");
const Key _showButtonKey = Key("showButtonKey");

const Widget _drawerContent = Text("Content");

void main() {
  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _DropdownTestWidget(
        dropdownKey: _dropdownKey,
      ),
    );

    expect(find.byKey(_dropdownKey), findsOneWidget);
  });

  testWidgets("Dropdown is displayed when the 'show' button is tapped.",
      (tester) async {
    await tester.pumpWidget(const _DropdownTestWidget());
    final button = find.byKey(_showButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_drawerContent), findsOneWidget);
  });

  testWidgets(
      "Dropdown collapses when a tap occurs outside its content, if dismissible.",
      (tester) async {
    await tester.pumpWidget(const _DropdownTestWidget());
    final button = find.byKey(_showButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_drawerContent), findsOneWidget);

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(find.byWidget(_drawerContent), findsNothing);
  });

  testWidgets(
      "Dropdown stays expanded when a tap occurs outside its content, if not dismissible.",
      (tester) async {
    await tester.pumpWidget(const _DropdownTestWidget(isDismissible: false));
    final button = find.byKey(_showButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_drawerContent), findsOneWidget);

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(find.byWidget(_drawerContent), findsOneWidget);
  });

  testWidgets("Provided background color is used for dropdown.",
      (tester) async {
    await tester.pumpWidget(
      const _DropdownTestWidget(
        color: Colors.blue,
      ),
    );
    final button = find.byKey(_showButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_drawerContent), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is MoonDropdown && widget.backgroundColor == Colors.blue,
      ),
      findsOneWidget,
    );
  });
}

class _DropdownTestWidget extends StatefulWidget {
  final Key? dropdownKey;
  final bool isDismissible;
  final Color color;

  const _DropdownTestWidget({
    this.dropdownKey,
    this.isDismissible = true,
    this.color = Colors.white,
  });

  @override
  State<_DropdownTestWidget> createState() => _DropdownTestWidgetState();
}

class _DropdownTestWidgetState extends State<_DropdownTestWidget> {
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: MoonDropdown(
            key: widget.dropdownKey,
            show: _show,
            backgroundColor: widget.color,
            onTapOutside: () => setState(() => _show = !widget.isDismissible),
            content: _drawerContent,
            child: MoonFilledButton(
              key: _showButtonKey,
              onTap: () => setState(() => _show = true),
            ),
          ),
        ),
      ),
    );
  }
}
