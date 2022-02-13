enum UserControl { hover, singlePress, longPress }

extension ControlEventExtension on UserControl {
  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? onHover,
    T Function()? onPress,
    T Function()? onLongPress,
  }) {
    if (this == UserControl.hover && onHover != null) {
      return onHover();
    } else if (this == UserControl.singlePress && onPress != null) {
      return onPress();
    } else if (this == UserControl.longPress && onLongPress != null) {
      return onLongPress();
    }

    return orElse();
  }

  T when<T>({
    required T Function() onHover,
    required T Function() onPress,
    required T Function() onLongPress,
  }) {
    switch (this) {
      case UserControl.hover:
        return onHover();
      case UserControl.singlePress:
        return onPress();
      case UserControl.longPress:
        return onLongPress();
    }
  }
}
