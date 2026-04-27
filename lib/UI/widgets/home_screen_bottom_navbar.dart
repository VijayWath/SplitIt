import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class HomeScreenBottomNavbar extends ConsumerWidget {
  const HomeScreenBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.stateProvider,
    required this.navItems,
  });
  final int currentIndex;
  final StateProvider stateProvider;
  final List<BottomNavigationBarItem> navItems;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent, // 🔥 required for blur
          elevation: 0,

          currentIndex: currentIndex,
          onTap: (index) {
            ref.read(stateProvider.notifier).state = index;
          },

          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Overview"),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: "Groups"),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Personal",
            ),
          ],
        ),
      ),
    );
  }
}
