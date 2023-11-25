import 'package:fast_app_base/common/common.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../../screen/main/fab/w_floating_daangn_button.riverpod.dart';

class FcmManager {
  static void requestPermission() {
    FirebaseMessaging.instance.requestPermission();
  }

  // static void initialize() async {
  static void initialize(WidgetRef ref) async {
    ///Foreground
    FirebaseMessaging.onMessage.listen((message) async {
      final title = message.notification?.title;
      if (title == null) {
        return;
      }
      ref.read(floatingButtonStateProvider.notifier).hideButton();
      final controller = App.navigatorKey.currentContext?.showSnackbar(
        title,
        extraButton: Tap(
          onTap: () {
            App.navigatorKey.currentContext!.go(message.data['deeplink']);
          },
          child: '열기'.text.white.bold.make().p(20),
        ),
      );
      final reason = await controller?.closed;
      print(reason);
      // await sleepAsync(4.seconds);
      // debugPrint(message.toString());
      ref.read(floatingButtonStateProvider.notifier).showButton();

      // final title = message.notification?.title;
      // if (title == null) {
      //   return;
      // }
      // ref.read(floatingButtonStateProvider.notifier).hideButton();
      // final controller = App.navigatorKey.currentContext?.showSnackbar(title,
      //     extraButton: Tap(
      //         onTap: () {
      //           App.navigatorKey.currentContext!.go(message.data['deeplink']);
      //         },
      //         child: '열기'.text.white.bold.make().p(20)));
      // await controller?.closed;
      // ref.read(floatingButtonStateProvider.notifier).showButton();
    });

    ///
    ///
    /// Background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      App.navigatorKey.currentContext!.go(message.data['deeplink']);
    });

    ///
    ///
    ///
    /// Not running -> initial launch

    final firstMessage = await FirebaseMessaging.instance.getInitialMessage();
    // 메세지를 누르고 해당 메세지를 들고 들어왔다는 의미
    if (firstMessage != null) {
      // await sleepUntil(() => App.navigatorKey.currentContext != null);
      await sleepUntil(() => App.navigatorKey.currentContext != null && App.navigatorKey.currentContext!.mounted);
      // final context = App.navigatorKey.currentContext;
      // if (context != null && context.mounted) {
      //   context.go(firstMessage.data['deeplink']);
      // }
      // ignore: use_build_context_synchronously
      App.navigatorKey.currentContext!.go(firstMessage.data['deeplink']);

      // await sleepUntil(() =>
      // // App.navigatorKey.currentContext != null && App.navigatorKey.currentContext!.mounted).timeout(5.seconds);
      // App.navigatorKey.currentContext != null && App.navigatorKey.currentContext!.mounted);
      // // ignore: use_build_context_synchronously
      // App.navigatorKey.currentContext!.go(firstMessage.data['deeplink']);
    }

    final token = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      /// API로 token 전송

    });
    print(token);
  }
}
