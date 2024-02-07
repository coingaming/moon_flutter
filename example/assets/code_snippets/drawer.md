import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class Drawer extends StatelessWidget {
  const Drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      maxHeight: MediaQuery.of(context).size.height,
      maxWidth: MediaQuery.of(context).size.width,
      child: Scaffold(
        drawer: MoonDrawer(
          width: MediaQuery.of(context).size.width * 0.4,
          child: const Align(
            child: Text("MoonDrawer"),
          ),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: MoonFilledButton(
                onTap: () => Scaffold.of(context).openDrawer(),
                label: const Text("Open MoonDrawer"),
              ),
            );
          },
        ),
      ),
    );
  }
}