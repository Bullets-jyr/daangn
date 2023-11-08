import 'package:fast_app_base/common/cli_common.dart';
import 'package:fast_app_base/common/util/async/cli_async.dart';
import 'package:fast_app_base/data/network/result/api_error.dart';
import 'package:fast_app_base/screen/notification/vo/notification_dummies.dart';
import 'package:fast_app_base/screen/notification/vo/vo_notification.dart';

import '../simple_result.dart';

class DaangnApi {

  // static Future<(String, DateTime)> getTitle(int id)async{
  //   await sleepAsync(400.ms);
  //   return (id.toString(), DateTime.now());
  // }

  static Future<SimpleResult<List<DaangnNotification>, ApiError>> getNotification() async {
    await sleepAsync(3000.ms);
    return SimpleResult.success(notificationList);
  }
}