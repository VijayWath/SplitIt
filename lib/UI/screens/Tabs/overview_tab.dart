import 'package:app/providers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OverviewTab extends ConsumerWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authNotifierProvider).value;
    return Column(
      children: [
        Container(child: Center(child: Text("USser Data for ${user?.name}"))),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Center(
            child: Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/0/0e/Prime_Minister_of_India_Narendra_Modi.jpg",
            ),
          ),
        ),
        Container(child: Center(child: Text(user.toString()))),
      ],
    );
  }
}
