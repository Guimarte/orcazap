import 'package:flutter/material.dart';
import 'package:orcazap/shared/widgets/input_widget.dart';


class PhoneCityInputWidget extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController cityController;

  const PhoneCityInputWidget({
    super.key,
    required this.phoneController,
    required this.cityController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Telefone ──
        Expanded(
          flex: 5,
          child: InputWidget(
            labelText: 'Telefone',
            hintText: '(11) 9 0000-0000',
            controller: phoneController,
            textInputType: TextInputType.phone,
            prefixIcon: Icons.phone_outlined,
          ),
        ),
        const SizedBox(width: 12),

        // ── Cidade ──
        Expanded(
          flex: 4,
          child: InputWidget(
            labelText: 'Cidade',
            hintText: 'São Paulo',
            controller: cityController,
            textInputType: TextInputType.text,
            prefixIcon: Icons.location_on_outlined,
          ),
        ),
      ],
    );
  }
}
