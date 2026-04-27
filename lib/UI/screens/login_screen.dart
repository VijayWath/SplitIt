import 'package:app/UI/widgets/loading_circle.dart';
import 'package:app/providers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      body: authState.when(
        data: (data) => Container(
          width: double.infinity,
          color: theme.colorScheme.surface,
          child: isLargeScreen
              ? Landscape(
                  screenHeight: screenHeight,
                  theme: theme,
                  screenWidth: screenWidth,
                )
              : Portrait(
                  screenHeight: screenHeight,
                  theme: theme,
                  screenWidth: screenWidth,
                ),
        ),
        error: (error, trace) => Text("Error: ${authState.error}"),
        loading: () => Center(child: const LoadingCircle()),
      ),
    );
  }
}

class Landscape extends ConsumerWidget {
  const Landscape({
    super.key,
    required this.screenHeight,
    required this.theme,
    required this.screenWidth,
  });

  final double screenHeight;
  final ThemeData theme;
  final double screenWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 20,
              top: 0,
              bottom: 0,
              left: 0,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  topLeft: Radius.circular(0),
                  bottomRight: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  topLeft: Radius.circular(0),
                  bottomRight: Radius.circular(40),
                  topRight: Radius.circular(0),
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/cat.jpeg',
                  image:
                      "https://images.unsplash.com/photo-1703248187251-c897f32fe4ec",
                  fit: BoxFit.cover,
                  height: double.infinity,
                  fadeInDuration: const Duration(milliseconds: 500),
                ),
              ),
            ),
          ),
        ),

        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Every expense tells a story.",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Understand yours...and write the next chapter with us.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 28,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    ref.read(authNotifierProvider.notifier).signInWithGoogle();
                  },
                  label: const Text("Continue with Google"),
                  icon: const Icon(Icons.login_rounded),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Portrait extends ConsumerWidget {
  const Portrait({
    super.key,
    required this.screenHeight,
    required this.theme,
    required this.screenWidth,
  });

  final double screenHeight;
  final ThemeData theme;
  final double screenWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: .start,
      children: [
        Container(
          width: double.infinity,
          height: screenHeight * 0.55,
          decoration: BoxDecoration(
            // color: theme.colorScheme.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                // color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 2,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/cat.jpeg',
              image:
                  "https://images.unsplash.com/photo-1703248187251-c897f32fe4ec",
              fit: BoxFit.cover,
              height: double.infinity,
              fadeInDuration: const Duration(milliseconds: 500),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                "Every expense tells a story.",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              SizedBox(
                width: screenWidth * 0.6,
                height: screenHeight * 0.1,
                child: Text(
                  "Understand yours...and write the next chapter with us.",
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Align(
                alignment: .center,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 25,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    ref.read(authNotifierProvider.notifier).signInWithGoogle();
                  },
                  label: Text("Continue with Google"),
                  icon: Icon(Icons.login_rounded),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
