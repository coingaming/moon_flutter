enum ComponentOptions {
  accordion,
  alert,
  authCode,
  avatar,
  bottomSheet,
  breadcrumb,
  button,
  carousel,
  checkbox,
  chip,
  circularLoader,
  circularProgress,
  dotIndicator,
  drawer,
  dropdown,
  icons,
  linearLoader,
  linearProgress,
  menuItem,
  modal,
  popover,
  radio,
  segmentedControl,
  switchX,
  tabBar,
  table,
  tag,
  textArea,
  textInput,
  textInputGroup,
  toast,
  tooltip;

  String get name {
    String rawName = toString().split('.').last;
    if (this == switchX) rawName = rawName.substring(0, rawName.length - 1);

    return rawName[0].toUpperCase() + rawName.substring(1);
  }
}
