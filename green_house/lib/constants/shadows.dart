import 'package:flutter/material.dart';

import 'exports.dart';

BoxShadow whiteLightShadow = const BoxShadow(
  color: AppColors.whiteLightColor,
  blurRadius: 30.0,
  offset: Offset(0.0, 6.0),
);

BoxShadow mainShadow = BoxShadow(
  color: AppColors.blackColor.withOpacity(0.08),
  blurRadius: 16.0,
);