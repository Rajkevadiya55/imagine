/// used to show loading, error alerts.

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

easyLoadingShowProgress(
    {String? status,
      Widget? indicator,
      EasyLoadingMaskType? maskType = EasyLoadingMaskType.clear,
      bool? dismissOnTap,
      bool withDismiss = true}) {
  easyLoadingDismiss(withDismiss: withDismiss);
  EasyLoading.show(
      status: status,
      indicator: indicator,
      maskType: maskType,
      dismissOnTap: dismissOnTap);
}

easyLoadingShowError(String status,
    {Duration? duration,
      EasyLoadingMaskType? maskType,
      bool? dismissOnTap,
      bool withDismiss = true}) {
  easyLoadingDismiss(withDismiss: withDismiss);
  EasyLoading.showError(status,
      duration: duration, maskType: maskType, dismissOnTap: dismissOnTap);
}

easyLoadingShowSuccess(String status,
    {Duration? duration,
      EasyLoadingMaskType? maskType,
      bool? dismissOnTap,
      bool withDismiss = true}) {
  easyLoadingDismiss(withDismiss: withDismiss);
  EasyLoading.showSuccess(status,
      duration: duration, maskType: maskType, dismissOnTap: dismissOnTap);
}

easyLoadingDismiss({bool withDismiss = true}) {
  if (withDismiss) {
    EasyLoading.dismiss();
  }
}

easyLoadingToast({required String message}) {
  EasyLoading.showToast(message);
}
