import 'package:fast_app_base/data/network/daagn_api.dart';
import 'package:fast_app_base/entity/post/vo_product_post.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// 결괏값, id
final productPostProvider = AutoDisposeFutureProviderFamily<ProductPost,int>((ref, id) async {
// final productPostProvider = FutureProviderFamily<ProductPost,int>((ref, id) async {
  return await DaangnApi.getPost(id);
});