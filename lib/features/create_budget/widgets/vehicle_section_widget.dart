import 'package:flutter/material.dart';
import 'package:orcazap/shared/widgets/section_card_widget.dart';
import 'package:orcazap/shared/widgets/input_widget.dart';

class VehicleSectionWidget extends StatelessWidget {
  final TextEditingController brandController;
  final TextEditingController modelController;
  final TextEditingController yearController;
  final TextEditingController plateController;
  final TextEditingController kmController;

  const VehicleSectionWidget({
    super.key,
    required this.brandController,
    required this.modelController,
    required this.yearController,
    required this.plateController,
    required this.kmController,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCardWidget(
      icon: Icons.directions_car_filled_outlined,
      title: 'VEÍCULO',
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InputWidget(
                  controller: brandController,
                  labelText: 'Marca',
                  hintText: 'Ex: Chevrolet',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: InputWidget(
                  controller: modelController,
                  labelText: 'Modelo',
                  hintText: 'Ex: Onix',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: InputWidget(
                  controller: yearController,
                  labelText: 'Ano',
                  hintText: 'Ex: 2020',
                  textInputType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: InputWidget(
                  controller: plateController,
                  labelText: 'Placa',
                  hintText: 'Ex: ABC1D23',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          InputWidget(
            controller: kmController,
            labelText: 'Quilometragem',
            hintText: 'Ex: 45.000 km',
            textInputType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
