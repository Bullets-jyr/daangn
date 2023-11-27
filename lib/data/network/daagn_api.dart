import 'package:fast_app_base/common/cli_common.dart';
import 'package:fast_app_base/common/util/async/cli_async.dart';
import 'package:fast_app_base/data/network/result/api_error.dart';
import 'package:fast_app_base/entity/dummies.dart';
import 'package:fast_app_base/entity/post/vo_product_post.dart';
import 'package:fast_app_base/screen/notification/vo/notification_dummies.dart';
import 'package:fast_app_base/screen/notification/vo/vo_notification.dart';

import '../simple_result.dart';

class DaangnApi {
  // static Future<(String, DateTime)> getTitle(int id)async{
  //   await sleepAsync(400.ms);
  //   return (id.toString(), DateTime.now());
  // }

  static Future<SimpleResult<List<DaangnNotification>, ApiError>>
      getNotification() async {
    // await sleepAsync(500.ms);
    await sleepAsync(1000.ms);
    return SimpleResult.success(notificationList);
  }

  // static Future<SimpleResult<ProductPost, ApiError>> getPost(int id) async {
  //   await sleepAsync(500.ms);
  //   return SimpleResult.success(
  //     ProductPost(
  //       simpleProductPost: post1,
  //       content: '깨끗하게 잘 쓰던 물건이에요. 잘 쓰면 좋겠습니다. 감사합니다.',
  //     ),
  //   );
  // }

  static Future<ProductPost> getPost(int id) async {
    await sleepAsync(500.ms);
    return ProductPost(
      simpleProductPost: post1,
      content: '깨끗하게 잘 쓰던 물건이에요. 잘 쓰면 좋겠습니다. 감사합니다.',
    );
  }
}
