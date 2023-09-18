import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/password_visible.dart';

class PasswordTextFormField extends ConsumerWidget {
  const PasswordTextFormField({super.key, required this.passwordController});
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pvProvider = ref.watch(passwordVisibleProvider);
    return TextFormField(
      controller: passwordController..text = '12345678',
      obscureText: !pvProvider,
      decoration: InputDecoration(
        labelText: 'Password',
        suffixIcon: InkWell(
          onTap: () {
            ref.read(passwordVisibleProvider.notifier).state = !pvProvider;
          },
          child: Icon(
            pvProvider ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
    );
  }
}
