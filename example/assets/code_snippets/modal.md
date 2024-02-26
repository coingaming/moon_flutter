import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class Modal extends StatelessWidget {
  const Modal({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> modalBuilder(BuildContext context) {
      return showMoonModal<void>(
        context: context,
        builder: (BuildContext context) {
          return MoonModal(
            child: SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width - 64,
              child: const Center(
                child: Text("This is MoonModal."),
              ),
            ),
          );
        },
      );
    }

    return Center(
      child: Builder(
        builder: (BuildContext context) {
          return MoonFilledButton(
            label: const Text("Open MoonModal"),
            onTap: () => modalBuilder(context),
          );
        },
      ),
    );
  }
}