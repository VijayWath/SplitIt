import 'package:app/models/userModel.dart';
import 'package:app/providers/auth_notifier.dart' show AuthNotifier;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class HomeScreeSideRail extends ConsumerWidget {
  const HomeScreeSideRail({
    super.key,
    required this.authNotifierProvider,
    this.user,
    required this.homeTabProvider,
    required this.navRailItems,
  });
  final AsyncNotifierProvider<AuthNotifier, UserModel?> authNotifierProvider;
  final UserModel? user;
  final StateProvider<int> homeTabProvider;
  final List<NavigationRailDestination> navRailItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final currentIndex = ref.watch(homeTabProvider);

    return NavigationRail(
      trailingAtBottom: true,
      trailing: IconButton(
        onPressed: () {
          ref.read(authNotifierProvider.notifier).logout();
        },
        icon: Icon(Icons.logout, color: theme.colorScheme.onSurface),
      ),
      leadingAtTop: true,
      leading: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CircleAvatar(
              radius: height * 0.06,
              backgroundImage: NetworkImage(user?.profile_picture_url ?? ''),
            ),
          ),
          Text(
            "${user?.name ?? 'Jhon Doe'}",
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: height * 0.005),
        ],
      ),
      selectedIndex: currentIndex,
      scrollable: true,
      extended: width > 800,
      onDestinationSelected: (index) {
        ref.read(homeTabProvider.notifier).state = index;
      },
      destinations: navRailItems,
    );
  }
}
