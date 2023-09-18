import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/faker_provider.dart';
import '../providers/firebase_provider.dart';
import '../providers/job_repository.dart';
import '../widgets/custom_app_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jrProvider = ref.watch(jobRepositoryProvider);
    return Scaffold(
      appBar: customAppBar(
        'Home',
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.power_settings_new),
          ),
          IconButton(
            onPressed: () async {
              final user = ref.watch(firebaseAuthProvider).currentUser;
              final faker = ref.watch(fakerProvider);
              ref.read(jobRepositoryProvider.notifier).addJob(
                    user!.uid,
                    faker.job.title(),
                    faker.company.name(),
                  );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: jrProvider.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) => ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(data[index]['title']),
            subtitle: Text(data[index]['company']),
          ),
        ),
        error: (error, stackTrace) => Center(child: Text('$error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
