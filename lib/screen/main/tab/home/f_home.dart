import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/entity/dummies.dart';
import 'package:fast_app_base/screen/main/fab/w_floating_daangn_button.dart';
import 'package:fast_app_base/screen/main/fab/w_floating_daangn_button.riverpod.dart';
import 'package:fast_app_base/screen/main/tab/home/w_product_post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({super.key});

  @override
  ConsumerState<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> {
  final scrollController = ScrollController();
  String title = "플러터동";

  @override
  void initState() {
    scrollController.addListener(() {
      // final isSmall = ref.read(floatingButtonIsSmallProvider);
      //
      // if (scrollController.position.pixels > 100 && !isSmall) {
      //   ref.read(floatingButtonIsSmallProvider.notifier).state = true;
      // } else if (scrollController.position.pixels < 100 && isSmall) {
      //   ref.read(floatingButtonIsSmallProvider.notifier).state = false;
      // }
      final floatingState = ref.read(floatingButtonStateProvider);

      if (scrollController.position.pixels > 100 && !floatingState.isSmall) {
        ref.read(floatingButtonStateProvider.notifier).changeButtonSize(true);
      } else if (scrollController.position.pixels < 100 &&
          floatingState.isSmall) {
        ref.read(floatingButtonStateProvider.notifier).changeButtonSize(false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          // automaticallyImplyLeading: false,
          title: PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                title = value;
              });
            },
            // TODO: 위, 아래 회전 화살표 구현
            // TODO: onOpened, onCancled (열린 상태, 닫힌 상태 감지)
            // TODO: AnimatedLotate 위젯 사용
            itemBuilder: (BuildContext context) => ["다트동", "앱동"]
                .map((e) => PopupMenuItem(
                      value: e,
                      // child: e.text.make(),
                      child: Text(e),
                    ))
                .toList(),
            // itemBuilder: (BuildContext context) => [
            //   PopupMenuItem(child: "다트동".text.make(), value: "다트동",),
            //   PopupMenuItem(child: "앱동".text.make(), value: "앱동",),
            // ],
            // child: title.text.make(),
            child: Text(title),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: FloatingDaangnButton.height),
            controller: scrollController,
            itemBuilder: (context, index) => ProductPostItem(postList[index]),
            itemCount: postList.length,
            separatorBuilder: (context, index) => Line()..pSymmetric(h: 15),
            // children: postList.map((e) => ProductPostItem(e)).toList(),
            // children: [
            //   Container(height: 500, color: Colors.red),
            //   Container(height: 500, color: Colors.blue),
            //   Container(height: 500, color: Colors.red),
            //   Container(height: 500, color: Colors.blue),
            // ],
          ),
        ),
      ],
    );
  }
}
