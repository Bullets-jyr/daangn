import 'dart:async';

import 'package:fast_app_base/common/dart/extension/num_duration_extension.dart';
import 'package:fast_app_base/common/dart/extension/ref_extension.dart';
import 'package:fast_app_base/data/network/daagn_api.dart';
import 'package:fast_app_base/entity/post/vo_product_post.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// 결괏값, id
final productPostProvider = AutoDisposeFutureProviderFamily<ProductPost,int>((ref, id) async {
// final productPostProvider = FutureProviderFamily<ProductPost,int>((ref, id) async {
  // 시간 제한 있는 캐싱
  // final link = ref.keepAlive();
  // Timer(Duration(seconds: 15), () {
  //   link.close();
  // });
  ref.cacheFor(10.minutes);

  return await DaangnApi.getPost(id);
});