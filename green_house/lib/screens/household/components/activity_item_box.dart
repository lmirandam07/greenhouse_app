import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../../constants/exports.dart';
import '../../dialogs/remove_emission.dart';

class ActivityItemBox extends StatelessWidget {
  final String emissionId;
  final String emissionTitle;
  final double emission_value;
  final Timestamp emission_date;
  final String emissionData;
  final String emissionUserId;
  final String? ownerId;
  final Color color;
  const ActivityItemBox(
      this.emissionId,
      this.emissionTitle,
      this.emission_value,
      this.emission_date,
      this.emissionData,
      this.ownerId,
      this.color,
      this.emissionUserId,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime date =
        DateTime.fromMillisecondsSinceEpoch(emission_date.seconds * 1000);
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return Container(
      height: screenHeight(context) * 0.08,
      margin: EdgeInsets.only(
        left: screenHeight(context) * 0.02,
        right: screenHeight(context) * 0.02,
        top: screenHeight(context) * 0.017,
      ),
      width: screenWidth(context),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(radius10),
        border: Border.all(
          color: color,
          width: 0.2,
        ),
        boxShadow: [
          mainShadow,
        ],
      ),
      child: GestureDetector(
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 65.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radius10),
                      bottomLeft: Radius.circular(radius10),
                    ),
                    border: Border.all(
                      color: color,
                      width: 0.8,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight(context) * 0.01),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: emissionTitle,
                            style: montserratRegular.copyWith(
                              fontSize: body14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: emissionData + ' - ' + formattedDate,
                            style: montserratRegular.copyWith(
                              fontSize: body10,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackHintColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 65.0,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  border: Border.all(
                    color: color,
                    width: 0.8,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(radius10),
                    bottomRight: Radius.circular(radius10),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${emission_value.toStringAsFixed(2)} kg',
                      style: montserratSemiBold.copyWith(
                        fontSize: body14,
                        color: AppColors.blackMainColor,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'CO',
                            style: montserratLight.copyWith(
                              fontSize: body12,
                              color: AppColors.blackMainColor,
                            ),
                          ),
                          WidgetSpan(
                            child: Transform.translate(
                              offset: const Offset(0.0, 0.0),
                              child: Text(
                                '2',
                                style: montserratRegular.copyWith(
                                  fontSize: body10,
                                  color: AppColors.blackMainColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTapDown: (details) {
          Timer(Duration(milliseconds: 800), () {
            Get.dialog(RemoveUserDialog(
                emissionId, emissionTitle, color, emissionUserId,ownerId));
          });
        },
      ),
    );
  }
}
//