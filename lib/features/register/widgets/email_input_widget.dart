import 'package:flutter/material.dart';
import 'package:orcazap/shared/widgets/input_widget.dart';

class EmailInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const EmailInputWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      labelText: 'E-mail',
      hintText: 'voce@oficina.com.br',
      controller: controller,
      textInputType: TextInputType.emailAddress,
      prefixIcon: Icons.mail_outline_rounded,
    );
  }
}
