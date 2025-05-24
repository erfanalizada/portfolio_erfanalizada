import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_theme_changer_erfan/dynamic_theme_picker.dart';
import 'package:portfolio_erfanalizada/widgets/yellow_button.dart';

class YellowButtonTestScreen extends ConsumerStatefulWidget {
  const YellowButtonTestScreen({super.key});

  @override
  ConsumerState<YellowButtonTestScreen> createState() => _YellowButtonTestScreenState();
}

class _YellowButtonTestScreenState extends ConsumerState<YellowButtonTestScreen> {
  @override
  Widget build(BuildContext context) {
    final colorPalette = CustomThemeColorPalette(ref);
    return Scaffold(
      backgroundColor: colorPalette.getColor('main_background'),
      appBar: AppBar(
        title: const Text('Yellow Button Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            YellowButton(
              text: 'Next page',
              icon: Icons.arrow_forward_ios,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
