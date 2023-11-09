import 'package:fast_app_base/entity/post/vo_product_post.dart';
import 'package:fast_app_base/entity/post/vo_simple_product_post.dart';
import 'package:flutter/material.dart';

class PostContent extends StatelessWidget {
  final SimpleProductPost simpleProductPost;
  final ProductPost? productPost;

  const PostContent({
    super.key,
    required this.simpleProductPost,
    this.productPost,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
