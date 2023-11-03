import 'package:fast_app_base/screen/main/fab/w_floating_daangn_button.state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final floatingButtonStateProvider =
    StateNotifierProvider<FloatingButtonStateNotifier, FloatingButtonState>(
  (ref) => FloatingButtonStateNotifier(
    // FloatingButtonState(),
    const FloatingButtonState(false, false),
  ),
);

class FloatingButtonStateNotifier extends StateNotifier<FloatingButtonState> {
  FloatingButtonStateNotifier(super.state);

  // 편법
  // @override
  // bool updateShouldNotify(FloatingButtonState old, FloatingButtonState current) {
  //   return true;
  // }

  bool needToMakeButtonBigger = false;

  void toggleMenu() {
    // final isExpanded = state.isExpanded;
    // final isSmall = state.isSmall;
    // state.isExpanded = !state.isExpanded;
    // state.isSmall = true;

    // 체이닝 메서드
    // state = state
    //   ..isExpanded = !state.isExpanded
    //   ..isSmall = true;
    // state = FloatingButtonState(!state.isExpanded, true);

    final isExpanded = state.isExpanded;
    final isSmall = state.isSmall;

    state = state.copyWith(isExpanded: !state.isExpanded, isSmall: needToMakeButtonBigger ? false : true);

    if (needToMakeButtonBigger) {
      needToMakeButtonBigger = false;
    }

    if (!isSmall && !isExpanded) {
      needToMakeButtonBigger = true;
    }
  }

  void changeButtonSize(bool isSmall) {
    // state = state..isSmall = isSmall;
    // state = FloatingButtonState(state.isExpanded, isSmall);
    if (state.isExpanded) {
      return;
    }
    state = state.copyWith(isSmall: isSmall);
  }
}

// final floatingButtonExpandedProvider = StateProvider((ref) => false);
// final floatingButtonIsSmallProvider = StateProvider((ref) => false);
