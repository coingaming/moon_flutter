import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moon_design/moon_design.dart';
import 'package:transparent_image/transparent_image.dart';

class RoutingErrorWidget extends StatelessWidget {
  const RoutingErrorWidget({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeInImage(
                height: 200,
                placeholder: MemoryImage(kTransparentImage),
                image: const AssetImage('assets/images/url_error.jpg'),
              ),
              Text(
                'Lost in space',
                style: context.moonTypography!.heading.text32,
              ),
              const SizedBox(height: 8),
              Text(
                'Houston, we have a problem. Moon not found.',
                style: context.moonTypography!.body.text16,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              MoonButton(
                onTap: () => context.go('/'),
                borderColor: context.moonColors!.piccolo,
                showBorder: true,
                label: Text(
                  'Go back to home',
                  style: TextStyle(color: context.moonColors!.piccolo),
                ),
              ),
            ],
          ),
        ),
      );
}
