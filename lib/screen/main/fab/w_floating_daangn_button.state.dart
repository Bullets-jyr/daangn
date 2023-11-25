import 'package:freezed_annotation/freezed_annotation.dart';

part 'w_floating_daangn_button.state.freezed.dart';

// final이 아닐 경우에는 @unfreezed를 만들어야합니다.
// @freezed
// class FloatingButtonState {
//   final bool isExpanded;
//   final bool isSmall;
//
//   // 초기화의 또 다른 방법
//   // 기본 생성자를 생성하면 isExpanded, isSmall 모두 false로 세팅이 됩니다.
//   // FloatingButtonState()
//   //     : isExpanded = false,
//   //       isSmall = false;
//
//   FloatingButtonState(this.isExpanded, this.isSmall);
// }

// dart run build_runner build
// dart run build_runner watch
@freezed
class FloatingButtonState with _$FloatingButtonState {
  const factory FloatingButtonState(
      final bool isExpanded,
      final bool isHided,
      final bool isSmall
      ) = _FloatingButtonState;
}