import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/num_duration_extension.dart';
import 'package:fast_app_base/common/widget/animated_width_collapse.dart';
import 'package:fast_app_base/screen/main/fab/w_floating_daangn_button.riverpod.dart';
import 'package:fast_app_base/screen/main/s_main.dart';
import 'package:fast_app_base/screen/write/s_write.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common/language/language.dart';

class FloatingDaangnButton extends ConsumerWidget {
  static const height = 100.0;

  FloatingDaangnButton({super.key});

  final duration = 300.ms;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isExpanded = ref.watch(floatingButtonExpandedProvider);
    // final isSmall = ref.watch(floatingButtonIsSmallProvider);

    final floatingButtonState = ref.watch(floatingButtonStateProvider);
    final isExpanded = floatingButtonState.isExpanded;
    final isSmall = floatingButtonState.isSmall;
    final isHided = floatingButtonState.isHided;

    return AnimatedOpacity(
      opacity: isHided? 0 : 1,
      duration: duration,
      child: Stack(
        children: [
          IgnorePointer(
            ignoring: !isExpanded,
            child: AnimatedContainer(
              duration: 300.ms,
              color:
                  isExpanded ? Colors.black.withOpacity(0.4) : Colors.transparent,
            ),
          ),
          IgnorePointer(
            ignoring: isHided,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IgnorePointer(
                    ignoring: !isExpanded,
                    child: AnimatedOpacity(
                      opacity: isExpanded ? 1 : 0,
                      duration: duration,
                      child: Column(
                        children: [
                          Container(
                            width: layerWidth,
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              color: context.appColors.floatingActionLayer,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // _floatItem('알바', '$basePath/fab/fab_01.png'),
                                Tap(onTap: () {
                                  print('localLife');
                                  context.go('/main/localLife');
                                }, child: _floatItem('part_time', '$basePath/fab/fab_01.png')),
                                _floatItem('lecture', '$basePath/fab/fab_02.png'),
                                _floatItem('agriculture', '$basePath/fab/fab_03.png'),
                                _floatItem('profit', '$basePath/fab/fab_04.png'),
                                _floatItem('car', '$basePath/fab/fab_05.png'),
                              ],
                            ),
                          ),
                          height10,
                          Tap(
                            onTap: () {
                              // 글 작성
                              Nav.push(const WriteScreen());
                            },
                            child: Container(
                              width: layerWidth,
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.only(right: 15, bottom: 10),
                              decoration: BoxDecoration(
                                color: context.appColors.floatingActionLayer,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _floatItem('sell_my_thing'.tr(), '$basePath/fab/fab_06.png'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Tap(
                    onTap: () {
                      // ref.read(floatingButtonExpandedProvider.notifier).state = !isExpanded;
                      // ref.read(floatingButtonIsSmallProvider.notifier).state = !isSmall;

                      // final currentTab = ref.read(currentTabProvider);
                      // debugPrint(currentTab.tabName);
                      // switch(currentTab) {
                      //   case TabItem.home:
                      //     // TODO: Handle this case.
                      //   case TabItem.localLife:
                      //     // TODO: Handle this case.
                      //   case TabItem.nearMe:
                      //     // TODO: Handle this case.
                      //   case TabItem.chat:
                      //     // TODO: Handle this case.
                      //   case TabItem.my:
                      //     // TODO: Handle this case.
                      // }

                      ref.read(floatingButtonStateProvider.notifier).toggleMenu();
                    },
                    child: AnimatedContainer(
                      duration: duration,
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: isExpanded
                            ? context.appColors.floatingActionLayer
                            : const Color(0xffff791f),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedRotation(
                            turns: isExpanded ? 0.125 : 0,
                            duration: duration,
                            child: Icon(Icons.add),
                          ),
                          AnimatedWidthCollapse(
                            visible: !isSmall,
                            duration: duration,
                            child: '글쓰기'.text.make(),
                          ),
                          // if (!isSmall) '글쓰기'.text.make(),
                        ],
                      ),
                    ),
                  ).pOnly(
                      bottom: MainScreenState.bottomNavigationBarHeight +
                          context.viewPaddingBottom +
                          10,
                      right: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double get layerWidth => currentLanguage == Language.english ? 250 : 160;

  _floatItem(String title, String imagePath) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 30,
        ),
        const Width(8),
        title.tr().text.make(),
      ],
    );
  }
}
