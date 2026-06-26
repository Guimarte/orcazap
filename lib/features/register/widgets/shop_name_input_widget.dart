import 'package:flutter/material.dart';
import 'package:orcazap/shared/widgets/input_widget.dart';

class ShopNameInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const ShopNameInputWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      labelText: 'Nome da Oficina',
      hintText: 'Auto Center Silva',
      controller: controller,
      textInputType: TextInputType.name,
      prefixIcon: Icons.storefront_rounded,
    );
  }
}
