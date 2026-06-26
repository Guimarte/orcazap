import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orcazap/core/theme/app_theme.dart';
import 'package:orcazap/features/create_budget/cubit/create_budget_cubit.dart';
import 'package:orcazap/features/create_budget/widgets/create_budget_appbar_widget.dart';
import 'package:orcazap/features/create_budget/widgets/client_section_widget.dart';
import 'package:orcazap/features/create_budget/widgets/vehicle_section_widget.dart';
import 'package:orcazap/features/create_budget/widgets/services_section_widget.dart';
import 'package:orcazap/features/create_budget/widgets/details_section_widget.dart';
import 'package:orcazap/features/create_budget/widgets/budget_summary_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:orcazap/core/utils/pdf_helper.dart';
import 'package:orcazap/features/create_budget/widgets/status_selector_widget.dart';
import 'package:orcazap/data/models/budget_model.dart';

class CreateBudgetPage extends StatefulWidget {
  const CreateBudgetPage({super.key});

  @override
  State<CreateBudgetPage> createState() => _CreateBudgetPageState();
}

class _CreateBudgetPageState extends State<CreateBudgetPage> {
  final _formKey = GlobalKey<FormState>();

  final _clientNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cpfCnpjController = TextEditingController();

  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _plateController = TextEditingController();
  final _kmController = TextEditingController();

  String? _selectedPaymentMethod;
  String _selectedStatus = 'pendente';
  final _validityController = TextEditingController(text: '7');
  final _notesController = TextEditingController();
  final _discountController = TextEditingController(text: '0');

  double _discountValue = 0.0;
  bool _isInitialized = false;

  @override
  void dispose() {
    _clientNameController.dispose();
    _phoneController.dispose();
    _cpfCnpjController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _plateController.dispose();
    _kmController.dispose();
    _validityController.dispose();
    _notesController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  void _save(BuildContext context) {
    if (_clientNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, informe o nome do cliente.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final validity = int.tryParse(_validityController.text) ?? 7;

    context.read<CreateBudgetCubit>().saveBudget(
          clientName: _clientNameController.text.trim(),
          phone: _phoneController.text.trim(),
          cpfCnpj: _cpfCnpjController.text.trim(),
          brand: _brandController.text.trim(),
          model: _modelController.text.trim(),
          year: _yearController.text.trim(),
          plate: _plateController.text.trim(),
          km: _kmController.text.trim(),
          paymentMethod: _selectedPaymentMethod ?? 'Não informado',
          validityDays: validity,
          notes: _notesController.text.trim(),
          discount: _discountValue,
          status: _selectedStatus,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateBudgetCubit, CreateBudgetState>(
      listener: (context, state) {
        if (state is CreateBudgetSuccess) {
          _showShareDialog(context, state.budget, context.read<CreateBudgetCubit>());
        } else if (state is CreateBudgetError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        } else if (state is CreateBudgetEditing) {
          final cubit = context.read<CreateBudgetCubit>();
          final data = cubit.initialBudgetData;
          if (data != null && !_isInitialized) {
            _isInitialized = true;
            _clientNameController.text = data.clientName;
            _phoneController.text = data.phone;
            _cpfCnpjController.text = data.cpfCnpj;
            _brandController.text = data.brand;
            _modelController.text = data.model;
            _yearController.text = data.year;
            _plateController.text = data.plate;
            _kmController.text = data.km;
            _validityController.text = data.validityDays.toString();
            _notesController.text = data.notes;
            _discountController.text = data.discount.toString();
            _discountValue = double.tryParse(_discountController.text) ?? 0.0;
            _selectedPaymentMethod = data.paymentMethod;
            _selectedStatus = data.status;
          }
        }
      },
      builder: (context, state) {
        if (state is CreateBudgetLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final isLoading = state is CreateBudgetSaving;

        return Scaffold(
          appBar: CreateBudgetAppBarWidget(
            title: context.read<CreateBudgetCubit>().isEditMode ? 'Editar orçamento' : 'Novo orçamento',
            onSave: isLoading ? () {} : () => _save(context),
          ),
          body: Stack(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            if (context.read<CreateBudgetCubit>().isEditMode) ...[
                              StatusSelectorWidget(
                                currentStatus: _selectedStatus,
                                onStatusChanged: (value) {
                                  setState(() {
                                    _selectedStatus = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                            ],
                            ClientSectionWidget(
                              nameController: _clientNameController,
                              phoneController: _phoneController,
                              cpfCnpjController: _cpfCnpjController,
                            ),
                            VehicleSectionWidget(
                              brandController: _brandController,
                              modelController: _modelController,
                              yearController: _yearController,
                              plateController: _plateController,
                              kmController: _kmController,
                            ),
                            ServicesSectionWidget(
                              items: state.items,
                              cubit: context.read<CreateBudgetCubit>(),
                            ),
                            DetailsSectionWidget(
                              selectedPaymentMethod: _selectedPaymentMethod,
                              onPaymentMethodChanged: (value) {
                                setState(() {
                                  _selectedPaymentMethod = value;
                                });
                              },
                              validityController: _validityController,
                              notesController: _notesController,
                            ),
                          ],
                        ),
                      ),
                    ),
                    BudgetSummaryWidget(
                      subtotal: state.subtotal,
                      discountController: _discountController,
                      onDiscountChanged: (value) {
                        setState(() {
                          _discountValue = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (isLoading)
                Container(
                  color: AppColors.overlay,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showShareDialog(BuildContext context, BudgetModel budget, CreateBudgetCubit cubit) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 28),
              const SizedBox(width: 10),
              Text(
                'Salvo com Sucesso!',
                style: AppTextStyles.h3.copyWith(fontSize: 18),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'O orçamento de ${budget.clientName} foi cadastrado com sucesso!',
                style: AppTextStyles.bodySecondary,
              ),
              const SizedBox(height: 20),
              Text(
                'Como deseja compartilhar?',
                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsOverflowButtonSpacing: 8,
          actions: [
            ElevatedButton.icon(
              icon: const Icon(Icons.chat_bubble_outline_rounded),
              label: const Text('Enviar WhatsApp (Texto)'),
              onPressed: () => _sendWhatsAppMessage(context, budget, cubit),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                foregroundColor: AppColors.textPrimary,
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.picture_as_pdf_outlined),
              label: const Text('Compartilhar PDF'),
              onPressed: () => _sharePdf(context, budget, cubit),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close dialog
                Navigator.of(context).pop(true);   // Pop CreateBudgetPage
              },
              child: const Text('Voltar ao Início'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendWhatsAppMessage(BuildContext context, BudgetModel budget, CreateBudgetCubit cubit) async {
    final clientName = budget.clientName;
    final phone = budget.phone;
    final vehicle = '${budget.brand} ${budget.model}'.trim();
    final plate = budget.plate;
    final subtotal = budget.subtotal;
    final discount = budget.discount;
    final total = budget.total;
    final paymentMethod = budget.paymentMethod;
    final validity = budget.validityDays;
    final notes = budget.notes;

    final shopName = cubit.shopDetails?.shopName ?? 'Oficina';

    final itemsText = cubit.state.items.isEmpty
        ? 'Nenhum item informado.'
        : cubit.state.items.map((item) {
            return '- ${item.quantity}x ${item.description}: R\$ ${item.total.toStringAsFixed(2)}';
          }).join('\n');

    final message = '''
*ORÇAMENTO — $shopName*

Olá, *$clientName*!
Segue o resumo do orçamento para o veículo *$vehicle* (Placa: *$plate*):

*Itens:*
$itemsText

*Subtotal:* R\$ ${subtotal.toStringAsFixed(2)}
*Desconto:* R\$ ${discount.toStringAsFixed(2)}
*Total:* R\$ ${total.toStringAsFixed(2)}

*Forma de pagamento:* $paymentMethod
*Validade:* $validity dias
${notes.isNotEmpty ? '\n*Observações:*\n$notes\n' : ''}
Qualquer dúvida ou para aprovação do serviço, entre em contato!
Obrigado!
''';

    var cleanPhone = phone.replaceAll(RegExp(r'\D'), '');
    if (cleanPhone.length == 10 || cleanPhone.length == 11) {
      cleanPhone = '55$cleanPhone';
    }

    final url = 'https://wa.me/$cleanPhone?text=${Uri.encodeComponent(message)}';
    final uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Não foi possível abrir o WhatsApp.';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao abrir WhatsApp: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _sharePdf(BuildContext context, BudgetModel budget, CreateBudgetCubit cubit) async {
    try {
      final shop = cubit.shopDetails;
      if (shop == null) {
        throw 'Os dados da oficina ainda não foram carregados.';
      }
      
      await PdfHelper.sharePdf(
        budget: budget,
        shop: shop,
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao compartilhar PDF: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}
