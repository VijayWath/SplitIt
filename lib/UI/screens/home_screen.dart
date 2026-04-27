import 'package:app/UI/screens/Tabs/personal_tab.dart';
import 'package:app/UI/widgets/home_scree_side_rail.dart';
import 'package:app/UI/widgets/home_screen_bottom_navbar.dart';
import 'package:app/UI/screens/Tabs/overview_tab.dart';
import 'package:app/UI/widgets/loading_circle.dart';
import 'package:app/providers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final homeTabProvider = StateProvider<int>((ref) => 0);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  static const navRailItems = [
    NavigationRailDestination(icon: Icon(Icons.home), label: Text("Overview")),
    NavigationRailDestination(icon: Icon(Icons.group), label: Text("Groups")),
    NavigationRailDestination(
      icon: Icon(Icons.person),
      label: Text("Personal"),
    ),
  ];

  static const navBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Overview"),
    BottomNavigationBarItem(icon: Icon(Icons.group), label: "Groups"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Personal"),
  ];

  static const tabs = [
    OverviewTab(),
    Center(child: Text("Groups")),
    PersonalTab(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final currentIndex = ref.watch(homeTabProvider);

    return authState.when(
      data: (user) {
        final isWide = MediaQuery.of(context).size.width >= 600;

        return Scaffold(
          appBar: isWide ? null : null,

          // AppBar(
          //     leading: CircleAvatar(
          //       backgroundImage: NetworkImage(
          //         user?.profile_picture_url ?? '',
          //       ),
          //     ),

          //     title: Text("${user?.name ?? ''}"),
          //     actions: [
          //       IconButton(
          //         onPressed: () {
          //           ref.read(authNotifierProvider.notifier).logout();
          //         },
          //         icon: const Icon(Icons.logout),
          //       ),
          //     ],
          //   ),
          body: isWide
              ? Row(
                  children: [
                    HomeScreeSideRail(
                      authNotifierProvider: authNotifierProvider,
                      user: user,
                      homeTabProvider: homeTabProvider,
                      navRailItems: navRailItems,
                    ),

                    const VerticalDivider(width: 1),

                    //RIGHT CONTENT
                    Expanded(
                      child: IndexedStack(index: currentIndex, children: tabs),
                    ),
                  ],
                )
              : IndexedStack(index: currentIndex, children: tabs),

          bottomNavigationBar: isWide
              ? null
              : HomeScreenBottomNavbar(
                  currentIndex: currentIndex,
                  stateProvider: homeTabProvider,
                  navItems: navBarItems,
                ),
        );
      },

      loading: () => const Scaffold(body: Center(child: LoadingCircle())),

      error: (e, _) => Scaffold(body: Center(child: Text(e.toString()))),
    );
  }
}
