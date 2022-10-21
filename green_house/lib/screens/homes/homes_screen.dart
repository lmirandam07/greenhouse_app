import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/constants/exports.dart';
import 'package:green_house/models/home_model.dart';
import 'package:green_house/screens/homes/components/home_box.dart';
import 'package:green_house/screens/create_home/create_home_screen.dart';

import '../../services/firestore_services/firestore_services.dart';
import '../../widgets/custom_app_bar.dart';

class HomesScreen extends StatelessWidget {
  HomesScreen({Key? key}) : super(key: key);
  final firestoreService = FirestoreService();
  final List<dynamic> homes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// top app bar
            CustomAppBar(
              isLeadingIcon: false,
              titleText: 'Hogares',
              action: GestureDetector(
                onTap: () {
                  Get.to(CreateHomeScreen());
                },
                child: Container(
                  height: 45.0,
                  width: 45.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius15),
                    color: AppColors.primaryColor,
                  ),
                  child: const Center(
                    child: Icon(Icons.add,
                        color: AppColors.blackColor, size: 30.0),
                  ),
                ),
              ),
            ),

            /// list
            SizedBox(height: screenHeight(context) * 0.016),
            FutureBuilder(
                future: firestoreService.getUserHomes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    List homesList = snapshot.data;
                    print('Casa List');
                    print(homesList.length);
                    print(snapshot.data);
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: homesList.length,
                        itemBuilder: (context, index) {
                          return const Center(child: HomeBox());
                        });
                  } else {
                    return const Center(
                        child: Text('No perteneces a ningun hogar'));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
