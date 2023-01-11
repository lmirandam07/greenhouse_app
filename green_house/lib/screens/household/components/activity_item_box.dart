import 'package:flutter/material.dart';

import '../../../constants/exports.dart';

class ActivityItemBox extends StatelessWidget {
  final String emissionTitle;
  final double emission_value;
  const ActivityItemBox(this.emissionTitle, this.emission_value, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          color: AppColors.primaryColor,
          width: 0.2,
        ),
        boxShadow: [
          mainShadow,
        ],
      ),
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
                  color: AppColors.primaryColor,
                  width: 0.8,
                ),
              ),
              child: Center(
                child: Text(
                  emissionTitle,
                  style: montserratRegular.copyWith(
                    fontSize: body18,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 65.0,
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              border: Border.all(
                color: AppColors.primaryColor,
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
                  '$emission_value kg',
                  style: montserratSemiBold.copyWith(
                    fontSize: body16,
                    color: AppColors.blackMainColor,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'CO',
                        style: montserratLight.copyWith(
                          fontSize: body14,
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
    );
  }
}
