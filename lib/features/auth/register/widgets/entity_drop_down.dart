import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/core/widgets/error_view.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/features/auth/register/data/models/entity_model.dart';
import 'package:wssal/features/auth/register/providers/register_provider.dart';

class EntityDropDown extends StatelessWidget {
  const EntityDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerProvider = context.read<RegisterProvider>();
    return Consumer<RegisterProvider>(
      builder: (_, provider, __) {
        if (provider.typeLoading) return const AppLoader();
        if (provider.typeError != null) return const ErrorView();
        return Container(
          height: 50,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.primaryColor, width: 1),
          ),
          child: DropdownButton<Entity>(
            isExpanded: true,
            underline: const SizedBox.shrink(),
            icon: const Icon(Icons.keyboard_arrow_down),
            iconSize: 24,
            elevation: 16,
            hint: const Text('نوع المنشأة'),
            value: provider.chosenPlaceType,
            onChanged: (val) => registerProvider.changePlaceType(val),
            dropdownColor: Colors.white,
            items: provider.typeList
                .toList()
                .map<DropdownMenuItem<Entity>>((Entity value) {
              return DropdownMenuItem<Entity>(
                value: value,
                child: Text(
                  value.value ?? '',
                  style: const TextStyle(fontSize: 14),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
