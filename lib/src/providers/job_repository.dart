import 'dart:developer';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_provider.dart';

part 'job_repository.g.dart';

@riverpod
class JobRepository extends _$JobRepository {
  @override
  Future<List<Map<String, dynamic>>> build() async => getJobs();

  Future<void> addJob(String uid, String title, String company) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final docRef =
          await ref.watch(firebaseFirestoreProvider).collection('jobs').add({
        'uid': uid,
        'title': title,
        'company': company,
      });
      log(docRef.id);
      return getJobs();
    });
  }

  Future<List<Map<String, dynamic>>> getJobs() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await ref.watch(firebaseFirestoreProvider).collection('jobs').get();
    return querySnapshot.docs.map((e) => e.data()).toList();
  }
}
