import 'package:flutter/material.dart';
import 'package:flutter_adaptive_button/flutter_adaptive_button.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TargetPlatform? overridePlatform;
  bool useMaterial3 = true;
  bool isDisabled = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        platform: overridePlatform,
        useMaterial3: useMaterial3,
      ),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Adaptive Button Example'),
          ),
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                onPressed: () {
                  setState(() {
                    isDisabled = !isDisabled;
                  });
                },
                label: Text(isDisabled ? 'Enable' : 'Disable'),
              ),
              const SizedBox(height: 16),
              //M2 M3
              FloatingActionButton.extended(
                onPressed: () {
                  setState(() {
                    useMaterial3 = !useMaterial3;
                  });
                },
                label: Text(useMaterial3 ? 'Switch to M2' : 'Switch to M3'),
              ),
              const SizedBox(height: 16),
              FloatingActionButton.extended(
                onPressed: () {
                  setState(() {
                    overridePlatform = overridePlatform == TargetPlatform.iOS
                        ? null
                        : TargetPlatform.iOS;
                  });
                },
                label: Text(
                    'Switch to ${overridePlatform == TargetPlatform.iOS ? 'Android' : 'iOS'}'),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton(
                  onPressed: isDisabled ? null : () {},
                  child: const Text('Filled Button'),
                ).adaptive(context),
                const SizedBox(height: 16),
                FilledButton.tonal(
                  onPressed: isDisabled ? null : () {},
                  child: const Text('Filled Button Tonal'),
                ).adaptive(context),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: isDisabled ? null : () {},
                  child: const Text('Outlined Button'),
                ).adaptive(context),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: isDisabled ? null : () {},
                  child: const Text('Text Button'),
                ).adaptive(context),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: isDisabled ? null : () {},
                  child: const Text('Elevated Button'),
                ).adaptive(context),
              ],
            ),
          ),
        );
      }),
    );
  }
}
