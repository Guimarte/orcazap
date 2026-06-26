import 'package:flutter/material.dart';
import 'package:orcazap/core/theme/app_theme.dart';
import 'package:orcazap/shared/widgets/section_card_widget.dart';
import 'package:orcazap/shared/widgets/input_widget.dart';

class DetailsSectionWidget extends StatelessWidget {
  final String? selectedPaymentMethod;
  final ValueChanged<String?> onPaymentMethodChanged;
  final TextEditingController validityController;
  final TextEditingController notesController;

  const DetailsSectionWidget({
    super.key,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodChanged,
    required this.validityController,
    required this.notesController,
  });

  @override
  Widget build(BuildContext context) {
    final paymentMethods = [
      'Não informado',
      'Dinheiro',
      'Pix',
      'Cartão de Crédito',
      'Cartão de Débito',
      'Boleto Bancário',
      'Faturado',
    ];

    return SectionCardWidget(
      icon: Icons.info_outline_rounded,
      title: 'DETALHES',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Forma de Pagamento (Dropdown)
          Text(
            'FORMA DE PAGAMENTO',
            style: AppTextStyles.label,
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: selectedPaymentMethod,
            items: paymentMethods
                .map((method) => DropdownMenuItem(
                      value: method,
                      child: Text(method, style: AppTextStyles.body),
                    ))
                .toList(),
            onChanged: onPaymentMethodChanged,
            style: AppTextStyles.body,
            decoration: const InputDecoration(
              hintText: 'Selecione a forma',
            ),
          ),
          const SizedBox(height: 16),
          // Validade do orçamento (dias)
          InputWidget(
            controller: validityController,
            labelText: 'Validade (dias)',
            hintText: 'Ex: 7',
            textInputType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          // Observações
          Text(
            'OBSERVAÇÕES',
            style: AppTextStyles.label,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: notesController,
            maxLines: 4,
            style: AppTextStyles.body,
            decoration: const InputDecoration(
              hintText: 'Digite observações ou termos adicionais sobre o serviço...',
            ),
          ),
        ],
      ),
    );
  }
}
