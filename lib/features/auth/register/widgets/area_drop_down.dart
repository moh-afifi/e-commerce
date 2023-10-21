import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/core/widgets/error_view.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/features/auth/register/data/models/entity_model.dart';
import 'package:wssal/features/auth/register/providers/register_provider.dart';

class AreaDropDown extends StatelessWidget {
  const AreaDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (_, provider, __) {
        if (provider.placeLoading) return const AppLoader();
        if (provider.placeError != null) return const ErrorView();
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
            hint: const Text('منطقة التغطية'),
            value: provider.chosenArea,
            onChanged: (val) => provider.changeArea(val),
            dropdownColor: Colors.white,
            items: provider.areaList
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
