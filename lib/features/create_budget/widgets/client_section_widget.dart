import 'package:flutter/material.dart';
import 'package:orcazap/shared/widgets/section_card_widget.dart';
import 'package:orcazap/shared/widgets/input_widget.dart';

class ClientSectionWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController cpfCnpjController;

  const ClientSectionWidget({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.cpfCnpjController,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCardWidget(
      icon: Icons.person_outline_rounded,
      title: 'CLIENTE',
      child: Column(
        children: [
          InputWidget(
            controller: nameController,
            labelText: 'Nome do cliente',
            hintText: 'Digite o nome do cliente',
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: InputWidget(
                  controller: phoneController,
                  labelText: 'Telefone',
                  hintText: '(00) 00000-0000',
                  textInputType: TextInputType.phone,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: InputWidget(
                  controller: cpfCnpjController,
                  labelText: 'CPF / CNPJ',
                  hintText: '000.000.000-00',
                  textInputType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
