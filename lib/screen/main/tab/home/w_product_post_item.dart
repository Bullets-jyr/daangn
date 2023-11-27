import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_app_base/common/common.dart';

// import 'package:fast_app_base/common/dart/extension/num_extension.dart' hide IntExt;
// import 'package:fast_app_base/common/dart/extension/num2_extension.dart';
import 'package:fast_app_base/entity/post/vo_simple_product_post.dart';
import 'package:fast_app_base/screen/dialog/d_color_bottom.dart';
import 'package:fast_app_base/screen/dialog/d_message.dart';
import 'package:fast_app_base/screen/post_detail/s_post_detail.dart';
import 'package:flutter/material.dart';

import 'package:nav/enum/enum_nav_ani.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProductPostItem extends StatelessWidget {
  final SimpleProductPost post;

  const ProductPostItem(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return Tap(
      // return GestureDetector(
      //   behavior: HitTestBehavior.translucent,
      //   onTapUp: (details) {
      //     Nav.pushWithRippleEffect(
      //       PostDetailScreen(
      //         post.id,
      //         simpleProductPost: post,
      //       ),
      //       offset: Offset(details.globalPosition.dx, details.globalPosition.dy),
      //       durationMs: 800
      //     );
      //   },
      onTap: () {
        // 상세페이지
        Nav.push(
          PostDetailScreen(
            post.id,
          ),
          durationMs: 800,
        );

        // context.go('/main/localLife/${post.id}');
        // context.go('/main/localLife/${post.id}', extra: post);

        // Nav.push(
        //   // // Nav.pushReplacement(
        //   PostDetailScreen(
        //     post.id,
        //     simpleProductPost: post,
        //   ),
        //   context: context,
        //   durationMs: 800,
        //   //   // navAni: NavAni.Ripple,
        // );

        // iOS: 스와이프 백 방지
        // Nav.pushFromRight(
        //   PostDetailScreen(
        //     post.id,
        //     simpleProductPost: post,
        //   ),
        //   prohibitSwipeBack: true,
        // );

        // MessageDialog('안녕하세요', context: context,).show(useRootNavigator: false);
        // ColorBottomSheet('안녕', context: context,).show();
      },
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                // borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10),),
                borderRadius: BorderRadius.circular(10),
                // child: Hero(
                //   tag: '${post.id}_${post.product.images[0]}',
                //   child: CachedNetworkImage(
                //     imageUrl: post.product.images[0],
                //     width: 150,
                //   ),
                // ),
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
                    // Hero(
                    //   tag: '${post.id}_title',
                    //   // child: post.title.text.size(17).bold.make(),
                    //   child: Material(
                    //     child: post.title.text.size(17).bold.make(),
                    //   ),
                    // ),
                    Material(
                      child: post.title.text.size(17).bold.make(),
                    ),
                    Row(
                      children: [
                        post.address.simpleAddress.text
                            .color(context.appColors.lessImportant)
                            .make(),
                        '•'.text.color(context.appColors.lessImportant).make(),
                        post
                            .createTime
                            .timeago
                            // timeago
                            //     .format(post.createTime, locale: context.locale.languageCode)
                            .text
                            .color(context.appColors.lessImportant)
                            .make(),
                      ],
                    ),
                    // IntExt(post.product.price).toWon().text.bold.make(),
                    // A member named 'toWon' is defined in extension 'IntExt' and extension 'IntExt2', and none are more specific.
                    post.product.price.toWon().text.bold.make(),
                    // IntExt2(post.product.price).toWon().text.bold.make(),
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
      ),
    );
  }
}
