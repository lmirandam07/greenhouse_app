import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/constants/exports.dart';

import 'emission_power_dialog.dart';
import 'emission_transport_dialog.dart';

class EmissionType extends StatelessWidget {
  const EmissionType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: const Text('Transporte'),
            leading: const Icon(Icons.train_sharp, color: AppColors.blueColor),
            onTap: () => Get.dialog(ReIssueDialogTransport()),
          ),
          ListTile(
            title: const Text('Energia'),
            leading: const Icon(Icons.lightbulb, color: AppColors.powerColor),
            onTap: () => Get..dialog(ReIssueDialogPower()),
          )
        ],
      ),
    ));
  }
}
