import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/firebase_provider.dart';
import '../routing/app_router.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_message.dart';
import '../widgets/password_text_form_field.dart';

class SignUpPage extends ConsumerWidget {
  SignUpPage({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: customAppBar('Sign Up'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController..text = 'faizan.abbas020@gmail.com',
            ),
            PasswordTextFormField(passwordController: passwordController),
            FilledButton(
              onPressed: () {
                createUserWithEmailAndPassword(context, ref);
              },
              child: const Text('Sign Up'),
            ),
            TextButton(
              onPressed: () {
                context.goNamed(AppRoute.signInPage.name);
              },
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createUserWithEmailAndPassword(
      BuildContext context, WidgetRef ref) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential =
          await ref.watch(firebaseAuthProvider).createUserWithEmailAndPassword(
                email: emailController.text,
                password: passwordController.text,
              );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ignore: use_build_context_synchronously
        showMessage(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // ignore: use_build_context_synchronously
        showMessage(context, 'The account already exists for that email.');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showMessage(context, e.toString());
    }
  }
}
