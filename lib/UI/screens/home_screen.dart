import 'dart:ui';

import 'package:app/UI/screens/Tabs/overview_tab.dart';
import 'package:app/UI/screens/widgets/loading_circle.dart';
import 'package:app/providers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final homeTabProvider = StateProvider<int>((ref) => 0);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const tabs = [
    OverviewTab(),
    Center(child: Text("Groups")),
    Center(child: Text("Personal")),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final currentIndex = ref.watch(homeTabProvider);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    final navItems = [
      NavigationRailDestination(
        icon: Icon(Icons.home),
        label: Text("Overview"),
      ),
      NavigationRailDestination(icon: Icon(Icons.group), label: Text("Groups")),
      NavigationRailDestination(
        icon: Icon(Icons.person),
        label: Text("Personal"),
      ),
    ];

    return authState.when(
      data: (user) {
        final isWide = MediaQuery.of(context).size.width >= 600;

        return Scaffold(
          appBar: isWide
              ? null
              : AppBar(
                  titleSpacing: width * 0.001,
                  leadingWidth: width * 0.2,
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      user?.profile_picture_url ?? '',
                    ),
                  ),

                  title: Text("Welcome ${user?.name ?? ''}"),
                  actions: [
                    IconButton(
                      onPressed: () {
                        ref.read(authNotifierProvider.notifier).logout();
                      },
                      icon: const Icon(Icons.logout),
                    ),
                  ],
                ),

          body: isWide
              ? Row(
                  children: [
                    NavigationRail(
                      trailingAtBottom: true,
                      trailing: IconButton(
                        onPressed: () {
                          ref.read(authNotifierProvider.notifier).logout();
                        },
                        icon: Icon(
                          Icons.logout,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      leadingAtTop: true,
                      leading: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: CircleAvatar(
                              radius: height * 0.06,
                              backgroundImage: NetworkImage(
                                user?.profile_picture_url ?? '',
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            "Welcome ${user?.name ?? 'Jhon Doe'}",
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: height * 0.02),
                        ],
                      ),
                      selectedIndex: currentIndex,
                      scrollable: true,
                      extended: width > 800,
                      onDestinationSelected: (index) {
                        ref.read(homeTabProvider.notifier).state = index;
                      },
                      // labelType: NavigationRailLabelType.all,
                      destinations: navItems,
                    ),

                    const VerticalDivider(width: 1),

                    //RIGHT CONTENT
                    Expanded(
                      child: IndexedStack(index: currentIndex, children: tabs),
                    ),
                  ],
                )
              : IndexedStack(index: currentIndex, children: tabs),

          //ONLY FOR SMALL SCREENS
          bottomNavigationBar: isWide
              ? null
              : ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: BottomNavigationBar(
                      iconSize: height * 0.035,
                      backgroundColor:
                          Colors.transparent, // 🔥 required for blur
                      elevation: 0,

                      currentIndex: currentIndex,
                      onTap: (index) {
                        ref.read(homeTabProvider.notifier).state = index;
                      },

                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: "Overview",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.group),
                          label: "Groups",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.person),
                          label: "Personal",
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },

      loading: () => const Scaffold(body: Center(child: LoadingCircle())),

      error: (e, _) => Scaffold(body: Center(child: Text(e.toString()))),
    );
  }
}
