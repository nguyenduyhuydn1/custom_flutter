import 'package:custom_flutter/Klerith/config/router/app_router.dart';
// import 'package:custom_flutter/Klerith/config/theme/app_theme.dart';
// import 'package:custom_flutter/Klerith/presentation/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// void main() {
//   runApp(const ProviderScope(child: MainApp()));
// }

class KlerithApp extends ConsumerWidget {
  const KlerithApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isDarkmode = ref.watch(isDarkmodeProvider);
    // final selectedColor = ref.watch(selectedColorProvider);

    return MaterialApp.router(
      title: 'Flutter Widgets',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
