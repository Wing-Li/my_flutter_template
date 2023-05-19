import 'package:flutter/material.dart';
import 'package:my_flutter_template/res/my_theme.dart';
import 'package:my_flutter_template/utils/dialog/my_dialog_widget.dart';
import 'package:my_flutter_template/utils/dialog/my_popup_alert_message_widget.dart';

class MyDialogUtils {
  static void showMessageDialog(
    BuildContext context,
    String message, {
    String title = "提示",
    String confirmText = "确认",
    String cancelText = "取消",
    Function? onConfirmTap,
    Function? onCancelTap,
    TextStyle? messageStyle,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyDialogWidget(
          title: title,
          message: message,
          messageStyle: messageStyle,
          confirmText: confirmText,
          onConfirmTap: () {
            if (onConfirmTap != null) onConfirmTap();
          },
          cancelText: cancelText,
          onCancelTap: () {
            if (onCancelTap != null) onCancelTap();
          },
        );
      },
    );
  }

  static void showCustomDialog(
    BuildContext context, {
    String title = "提示",
    String? message,
    Widget? child,
    String confirmText = "确认",
    String cancelText = "取消",
    Function? onConfirmTap,
    Function? onCancelTap,
    TextStyle? messageStyle,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyDialogWidget(
          title: title,
          message: message,
          child: child,
          messageStyle: messageStyle,
          confirmText: confirmText,
          onConfirmTap: () {
            if (onConfirmTap != null) onConfirmTap();
          },
          cancelText: cancelText,
          onCancelTap: () {
            if (onCancelTap != null) onCancelTap();
          },
        );
      },
    );
  }

  static void showPopupAlertMessageSheet(
    BuildContext context,
    String message, {
    String confirmText = "确定",
    String cancelText = "取消",
    Function? onConfirmTap,
    Function? onCancelTap,
  }) {
    showModalBottomSheet(
      context: context,
      elevation: 10,
      backgroundColor: MyTheme.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      builder: (context) {
        return MyPopupAlertMessageWidget(
          message: message,
          confirmText: confirmText,
          onConfirmTap: () {
            if (onConfirmTap != null) onConfirmTap();
          },
          cancelText: cancelText,
          onCancelTap: () {
            if (onCancelTap != null) onCancelTap();
          },
        );
      },
    );
  }

// static void showFilterSheet(
//     BuildContext context, {
//       KDIX_FilterListUserModel filterModel,
//       OnSelectFilterResultCallBack onSelectFilterResultCallBack,
//     }) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: EO_Theme.transparent,
//     builder: (context) {
//       return KDIX_FilterBottomPopup(
//         filterModel: filterModel,
//         onSelectFilterResultCallBack: onSelectFilterResultCallBack,
//       );
//     },
//   );
// }
}
