import 'package:faker/faker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fakerProvider = Provider<Faker>((ref) {
  return Faker();
});
