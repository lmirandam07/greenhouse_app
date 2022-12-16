import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:green_house/constants/exports.dart';

import '../../../services/firestore_services/firestore_services.dart';

class DropdownMenu extends StatefulWidget {
  final Color dropdownColor;
  DropdownMenu([this.dropdownColor = AppColors.primaryColor]);

  @override
  State<DropdownMenu> createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  final firestoreService = FirestoreService();
  final List<String> homes = [];

  String? homeSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownButtonHideUnderline(
          child: FutureBuilder(
              future: firestoreService.getUserHomeAcceptedList(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: widget.dropdownColor,
                  ));
                }
                if (snapshot.hasData) {
                  final homesList = snapshot.data;
                  homesList.forEach((home) {
                    homes.add(home['home_name'] + "_" + home['home_id']);
                  });
                  return DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        Expanded(
                          child: Text(
                            'Hogares',
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
                    items: homes
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item.split('_')[0],
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: homeSelected,
                    onChanged: (value) {
                      setState(() {
                        homes.clear();
                        homeSelected = value as String;
                        homes.clear();
                      });
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
                  );
                } else {
                  return const Text('No tiene casas disponibles');
                }
              }),
        ),
      ),
    );
  }
}
