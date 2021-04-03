import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {

  static Future<bool> isHasPermissionStorage() async {
    return await Permission.storage.status.isGranted;
  }

  static Future<bool> requestPermissionStorage() async {
    return await Permission.storage.request().isGranted;
  }

  static Future<bool> openPermissionSettings() async {
    openAppSettings();

    // if (await Permission.storage.isPermanentlyDenied) {
    //   // The user opted to never again see the permission request dialog for this
    //   // app. The only way to change the permission's status now is to let the
    //   // user manually enable it in the system settings.
    //   openAppSettings();
    // }
  }
}
