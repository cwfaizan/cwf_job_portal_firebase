import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordVisibleProvider = StateProvider<bool>((ref) => false);

// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'password_visible.g.dart';

// @riverpod
// class PasswordVisible extends _$PasswordVisible {
//   @override
//   bool build() => false;

//   void toggle() => state = !state;
// }
