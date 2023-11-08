import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/entity/post/vo_simple_product_post.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProductPostItem extends StatelessWidget {
  final SimpleProductPost post;

  const ProductPostItem(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              // borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10),),
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: post.product.images[0],
                width: 150,
              ),
            ),
            Width(10),
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // post.content.text.size(17).bold.make(),
                  post.title.text.size(17).bold.make(),
                  Row(
                    children: [
                      post.address.simpleAddress.text
                          .color(context.appColors.lessImportant)
                          .make(),
                      '•'
                          .text
                          .color(context.appColors.lessImportant)
                          .make(),
                      timeago
                          .format(post.createTime,
                              locale: context.locale.languageCode)
                          .text
                          .color(context.appColors.lessImportant)
                          .make(),
                    ],
                  ),
                  post.product.price.toWon().text.bold.make(),
                ],
              ),
            ),
          ],
        ).p(15),
        // Stack에서 Align 적용이 되지 않는 경우?
        // Positioned.fill()로 감싸줍니다.
        // Positioned.fill()이 Stack 전체의 영역을 꽉 채워주고,
        // 꽉 찬 영역안에서 bottomRight를 만들어줍니다.
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('$basePath/home/post_chat_count.png'),
                post.chatCount.text.make(),
                Image.asset('$basePath/home/post_heart_off.png'),
                post.likeCount.text.make(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
