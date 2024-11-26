import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:letstrip/theme/text_style.dart';
import 'package:letstrip/utils/lets_trip_app.dart';

void showErrorToast(String message) {
  DelightToastBar? toastBar;

  toastBar = DelightToastBar(
      builder: (context) => ToastCard(
            color: Theme.of(context).colorScheme.error,
            leading: Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.background,
              size: ScreenUtil().setSp(24),
            ),
            trailing: InkWell(
              onTap: () {
                toastBar!.remove();
              },
              child: Icon(
                Icons.clear,
                color: Theme.of(context).colorScheme.background,
                size: ScreenUtil().setSp(24),
              ),
            ),
            title: Text(message,
                style: AppTextTheme.bodyStyle
                    .copyWith(color: Theme.of(context).colorScheme.background)),
          ),
      autoDismiss: true);
  toastBar.show(navigatorKey.currentContext!);
}

void showSuccessToast(String message) {
  DelightToastBar? toastBar;

  toastBar = DelightToastBar(
      builder: (context) => ToastCard(
            color: Colors.green,
            leading: Icon(
              Icons.done_all_rounded,
              color: Theme.of(context).colorScheme.background,
              size: ScreenUtil().setSp(24),
            ),
            trailing: InkWell(
              onTap: () {
                toastBar!.remove();
              },
              child: Icon(
                Icons.clear,
                color: Theme.of(context).colorScheme.background,
                size: ScreenUtil().setSp(24),
              ),
            ),
            title: Text(message,
                style: AppTextTheme.bodyStyle
                    .copyWith(color: Theme.of(context).colorScheme.background)),
          ),
      autoDismiss: true);
  toastBar.show(navigatorKey.currentContext!);
}

void showInfoToast(String message, {int? milliseconds}) {
  DelightToastBar? toastBar;

  toastBar = DelightToastBar(
      snackbarDuration: Duration(milliseconds: milliseconds ?? 5000),
      builder: (context) => ToastCard(
            trailing: InkWell(
              onTap: () {
                toastBar!.remove();
              },
              child: Icon(
                Icons.clear,
                color: Theme.of(context).colorScheme.onSecondary,
                size: ScreenUtil().setSp(24),
              ),
            ),
            title: Text(message, style: AppTextTheme.bodyStyle),
          ),
      autoDismiss: true);
  toastBar.show(navigatorKey.currentContext!);
}

void toastWithAction(String message, VoidCallback action) {
  DelightToastBar? toastBar;

  toastBar = DelightToastBar(
      builder: (context) => ToastCard(
            trailing: InkWell(
              onTap: () {
                toastBar!.remove();
                action();
              },
              child: Icon(
                Icons.arrow_forward_rounded,
                color: Theme.of(context).colorScheme.onSecondary,
                size: ScreenUtil().setSp(24),
              ),
            ),
            title: Text(message, style: AppTextTheme.bodyStyle),
          ),
      autoDismiss: true);
  toastBar.show(navigatorKey.currentContext!);
}

void simpleToast(String message) {
  DelightToastBar? toastBar;
  toastBar = DelightToastBar(
      snackbarDuration: const Duration(milliseconds: 1000),
      animationDuration: const Duration(milliseconds: 300),
      builder: (context) => ToastCard(
            title: Text(message, style: AppTextTheme.bodyStyle),
          ),
      autoDismiss: true);
  toastBar.show(navigatorKey.currentContext!);
}
