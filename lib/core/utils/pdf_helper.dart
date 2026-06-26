import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:orcazap/data/models/budget_model.dart';
import 'package:orcazap/data/models/shop_model.dart';

class PdfHelper {
  PdfHelper._();

  static Future<String> generateBudgetPdf({
    required BudgetModel budget,
    required ShopModel shop,
  }) async {
    final pdf = pw.Document();

    final dateStr = _formattedDate(budget.createdAt);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          // ── CABEÇALHO DA OFICINA ──
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    shop.shopName.toUpperCase(),
                    style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text('Responsável: ${shop.ownerName}', style: const pw.TextStyle(fontSize: 10)),
                  pw.Text('Contato: ${shop.phone}', style: const pw.TextStyle(fontSize: 10)),
                  pw.Text('Cidade: ${shop.city}', style: const pw.TextStyle(fontSize: 10)),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.amber,
                    ),
                    child: pw.Text(
                      'ORÇAMENTO',
                      style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                    ),
                  ),
                  pw.SizedBox(height: 6),
                  pw.Text('Data: $dateStr', style: const pw.TextStyle(fontSize: 10)),
                  pw.Text('Validade: ${budget.validityDays} dias', style: const pw.TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 15),
          pw.Divider(thickness: 1.5, color: PdfColors.grey300),
          pw.SizedBox(height: 10),

          // ── DADOS DO CLIENTE ──
          pw.Text(
            'DADOS DO CLIENTE',
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColors.grey800),
          ),
          pw.SizedBox(height: 6),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey200, width: 0.5),
            children: [
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: pw.Text('Nome: ${budget.clientName}', style: const pw.TextStyle(fontSize: 10)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: pw.Text('Telefone: ${budget.phone}', style: const pw.TextStyle(fontSize: 10)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: pw.Text('CPF/CNPJ: ${budget.cpfCnpj}', style: const pw.TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 15),

          // ── DADOS DO VEÍCULO ──
          pw.Text(
            'DADOS DO VEÍCULO',
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColors.grey800),
          ),
          pw.SizedBox(height: 6),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey200, width: 0.5),
            children: [
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: pw.Text('Marca: ${budget.brand}', style: const pw.TextStyle(fontSize: 10)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: pw.Text('Modelo: ${budget.model}', style: const pw.TextStyle(fontSize: 10)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: pw.Text('Ano: ${budget.year}', style: const pw.TextStyle(fontSize: 10)),
                  ),
                ],
              ),
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: pw.Text('Placa: ${budget.plate}', style: const pw.TextStyle(fontSize: 10)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: pw.Text('Quilometragem: ${budget.km}', style: const pw.TextStyle(fontSize: 10)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: pw.Text('', style: const pw.TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 20),

          // ── LISTA DE ITENS ──
          pw.Text(
            'SERVIÇOS E PEÇAS',
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColors.grey800),
          ),
          pw.SizedBox(height: 6),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
            columnWidths: {
              0: const pw.FlexColumnWidth(5),
              1: const pw.FlexColumnWidth(1),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(2),
            },
            children: [
              // Cabeçalho da tabela
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: pw.Text('Descrição', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: pw.Text('Qtd', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: pw.Text('Preço Unitário', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: pw.Text('Total', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9)),
                  ),
                ],
              ),
              // Linhas
              ...budget.items.map((item) {
                final qty = item.quantity.toDouble();
                final price = item.unitPrice;
                final total = item.total;

                return pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Text(item.description, style: const pw.TextStyle(fontSize: 9)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Text(qty.toStringAsFixed(0), style: const pw.TextStyle(fontSize: 9)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Text('R\$ ${price.toStringAsFixed(2)}', style: const pw.TextStyle(fontSize: 9)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Text('R\$ ${total.toStringAsFixed(2)}', style: const pw.TextStyle(fontSize: 9)),
                    ),
                  ],
                );
              }),
            ],
          ),
          pw.SizedBox(height: 15),

          // ── RESUMO FINANCEIRO E OBSERVAÇÕES ──
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Observações (esquerda)
              pw.Expanded(
                flex: 6,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Observações:',
                      style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: PdfColors.grey700),
                    ),
                    pw.SizedBox(height: 3),
                    pw.Text(
                      budget.notes.isNotEmpty
                          ? budget.notes
                          : 'Sem observações adicionais.',
                      style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      'Forma de Pagamento: ${budget.paymentMethod}',
                      style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(width: 20),
              // Valores (direita)
              pw.Expanded(
                flex: 4,
                child: pw.Column(
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Subtotal:', style: const pw.TextStyle(fontSize: 9)),
                        pw.Text('R\$ ${budget.subtotal.toStringAsFixed(2)}', style: const pw.TextStyle(fontSize: 9)),
                      ],
                    ),
                    pw.SizedBox(height: 3),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Desconto:', style: const pw.TextStyle(fontSize: 9)),
                        pw.Text('R\$ ${budget.discount.toStringAsFixed(2)}', style: const pw.TextStyle(fontSize: 9, color: PdfColors.red)),
                      ],
                    ),
                    pw.SizedBox(height: 4),
                    pw.Divider(color: PdfColors.grey300, thickness: 0.5),
                    pw.SizedBox(height: 4),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('TOTAL:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
                        pw.Text(
                          'R\$ ${budget.total.toStringAsFixed(2)}',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12, color: PdfColors.amber800),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final output = await getTemporaryDirectory();
    final fileName = 'orcamento_${budget.clientName.replaceAll(' ', '_')}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file.path;
  }

  static Future<void> sharePdf({
    required BudgetModel budget,
    required ShopModel shop,
  }) async {
    final filePath = await generateBudgetPdf(budget: budget, shop: shop);
    final clientName = budget.clientName;
    // ignore: deprecated_member_use
    await Share.shareXFiles([XFile(filePath)], text: 'Orçamento para $clientName');
  }

  static String _formattedDate(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
  }
}
