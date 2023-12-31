import 'package:fast_app_base/entity/user/vo_address.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../product/vo_product.dart';
import '../user/vo_user.dart';

part 'vo_simple_product_post.freezed.dart';

@freezed
// class ProductPost with _$ProductPost {
class SimpleProductPost with _$SimpleProductPost {
  const factory SimpleProductPost(
    final int id,
    final User user,
    final Product product,
    // final String content,
    final String title,
    // final String address,
    final Address address,
    final int chatCount,
    final int likeCount,
    final DateTime createTime,
  // ) = _ProductPost;
  ) = _SimpleProductPost;
}
