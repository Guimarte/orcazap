import 'package:flutter/material.dart';
import 'package:orcazap/shared/widgets/input_widget.dart';

class OwnerNameInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const OwnerNameInputWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      labelText: 'Seu Nome',
      hintText: 'Ricardo Almeida',
      controller: controller,
      textInputType: TextInputType.name,
      prefixIcon: Icons.person_outline_rounded,
    );
  }
}
