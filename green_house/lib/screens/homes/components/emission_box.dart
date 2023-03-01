import 'package:flutter/material.dart';
import 'package:green_house/services/firestore_services/firestore_services.dart';

import '../../../constants/exports.dart';

class EmissionBox extends StatelessWidget {
  final String homeId;

  EmissionBox(this.homeId, {Key? key}) : super(key: key);

  final firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder<Iterable>(
              future: firestoreService.getHomeUserEmissionList(homeId),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: LinearProgressIndicator());
                }
                if (snapshot.hasData) {
                  final homeUsersEmissions = snapshot.data;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: homeUsersEmissions.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenHeight(context) * 0.014,
                              vertical: screenHeight(context) * 0.012),
                          width: screenWidth(context),
                          margin: EdgeInsets.only(
                            left: screenHeight(context) * 0.02,
                            right: screenHeight(context) * 0.02,
                            top: screenHeight(context) * 0.015,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius10),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Emisiones de ${homeUsersEmissions[index]['userName']}",
                                style: montserratRegular.copyWith(
                                  fontSize: body15,
                                  color: AppColors.blackMainColor,
                                ),
                              ),
                              SizedBox(height: screenHeight(context) * 0.005),
                              Stack(
                                children: [
                                  Container(
                                    height: 2.0,
                                    width: screenWidth(context),
                                    color: AppColors.primaryColor,
                                  ),
                                ],
                              ),
                              Text(
                                "Emisiones de Energía: ${homeUsersEmissions[index]['powerValue']} CO2 kg",
                                style: montserratRegular.copyWith(
                                  fontSize: body12,
                                  color: AppColors.blackMainColor,
                                ),
                              ),
                              Text(
                                "Emisiones de Transporte: ${homeUsersEmissions[index]['transportValue']} CO2 kg",
                                style: montserratRegular.copyWith(
                                  fontSize: body12,
                                  color: AppColors.blackMainColor,
                                ),
                              ),
                              Text(
                                "Emisiones de Gas: ${homeUsersEmissions[index]['gasValue']} CO2 kg",
                                style: montserratRegular.copyWith(
                                  fontSize: body12,
                                  color: AppColors.blackMainColor,
                                ),
                              ),
                              Text(
                                "Emisiones de Basura: ${homeUsersEmissions[index]['trashValue']} CO2 kg",
                                style: montserratRegular.copyWith(
                                  fontSize: body12,
                                  color: AppColors.blackMainColor,
                                ),
                              ),
                              Text(
                                "Emisiones Totales: ${homeUsersEmissions[index]['totalEmision']} CO2 kg",
                                style: montserratSemiBold.copyWith(
                                  fontSize: body12,
                                  color: AppColors.blackMainColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                } else {
                  return Center(child: Text('No hay emisiones'));
                }
              })
        ],
      ),
    );
  }
}
