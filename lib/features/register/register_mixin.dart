import 'package:flutter/material.dart';
import 'package:orcazap/features/register/register_view.dart';

mixin RegisterMixin on State<RegisterView> {
  final shopNameController = TextEditingController();
  final ownerNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final passwordController = TextEditingController();
  bool termsAccepted = false;

  @override
  void dispose() {
    shopNameController.dispose();
    ownerNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
