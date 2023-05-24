import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:green_house/constants/exports.dart';
import '../controller/emission_controller.dart';
import 'package:get/get.dart';

class DropdownFuelTypeMenu extends StatefulWidget {
  final Function(String?) onChanged;
  final Color dropdownColor;
  DropdownFuelTypeMenu(this.onChanged,
      [this.dropdownColor = AppColors.primaryColor]);

  @override
  State<DropdownFuelTypeMenu> createState() => DropdownFuelTypeMenuState();
}

class DropdownFuelTypeMenuState extends State<DropdownFuelTypeMenu> {
  final List<String> items = [
    '91 octanos',
    '95 octanos',
    'Diesel',
  ];
  String? selectedValue;
  final EmissionController emissionController = Get.put(EmissionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Row(
              children: const [
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    'Gasolina',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as String;
              });
              String selected = '';
              selected = value as String;
              emissionController.fuelTypeController.text = selected;
            },
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 14,
            iconEnabledColor: Colors.white,
            iconDisabledColor: Colors.grey,
            buttonHeight: 150,
            buttonWidth: 200,
            buttonPadding: const EdgeInsets.only(left: 14, right: 14),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
              color: widget.dropdownColor,
            ),
            buttonElevation: 2,
            itemHeight: 40,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownMaxHeight: 200,
            dropdownWidth: 180,
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: widget.dropdownColor,
            ),
            dropdownElevation: 8,
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
            offset: const Offset(-20, 0),
          ),
        ),
      ),
    );
  }
}
