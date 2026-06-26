import 'package:flutter/material.dart';
import 'package:orcazap/features/login/login_view.dart';

mixin LoginMixin on State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
