import 'dart:developer';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/job.dart';
import 'firebase_provider.dart';

part 'job_repository.g.dart';

@riverpod
class JobRepository extends _$JobRepository {
  @override
  Future<List<Job>> build() async => getJobs();

  Future<void> addJob(String uid, String title, String company) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final docRef = await ref
          .watch(firebaseFirestoreProvider)
          .collection('users/$uid/jobs')
          .add({
        'uid': uid,
        'title': title,
        'company': company,
      });
      log(docRef.id);
      return getJobs();
    });
  }

  Future<void> updateJob(
      String jobId, String uid, String title, String company) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref
          .watch(firebaseFirestoreProvider)
          .collection('users/$uid/jobs')
          .doc(jobId)
          .update({
        'uid': uid,
        'title': title,
        'company': company,
      });
      return getJobs();
    });
  }

  Future<void> deleteJob(String uid, String jobId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref
          .watch(firebaseFirestoreProvider)
          .collection('users/$uid/jobs')
          .doc(jobId)
          .delete();
      return getJobs();
    });
  }

  Future<List<Job>> getJobs() async {
    final user = ref.watch(firebaseAuthProvider).currentUser;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await ref
        .watch(firebaseFirestoreProvider)
        .collection('users/${user!.uid}/jobs')
        // .where('uid', isEqualTo: user.uid)
        .get();
    return querySnapshot.docs.map((e) => Job.fromJson(e.id, e.data())).toList();
  }
}
