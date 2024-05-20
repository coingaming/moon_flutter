import 'package:example/src/storybook/stories/composites/combobox_single_select.dart';
import 'package:example/src/storybook/stories/composites/search_with_list.dart';
import 'package:example/src/storybook/stories/primitives/accordion.dart';
import 'package:example/src/storybook/stories/primitives/alert.dart';
import 'package:example/src/storybook/stories/primitives/auth_code.dart';
import 'package:example/src/storybook/stories/primitives/avatar.dart';
import 'package:example/src/storybook/stories/primitives/bottom_sheet.dart';
import 'package:example/src/storybook/stories/primitives/breadcrumb.dart';
import 'package:example/src/storybook/stories/primitives/button.dart';
import 'package:example/src/storybook/stories/primitives/carousel.dart';
import 'package:example/src/storybook/stories/primitives/checkbox.dart';
import 'package:example/src/storybook/stories/primitives/chip.dart';
import 'package:example/src/storybook/stories/primitives/circular_loader.dart';
import 'package:example/src/storybook/stories/primitives/circular_progress.dart';
import 'package:example/src/storybook/stories/primitives/dot_indicator.dart';
import 'package:example/src/storybook/stories/primitives/drawer.dart';
import 'package:example/src/storybook/stories/primitives/dropdown.dart';
import 'package:example/src/storybook/stories/primitives/icons.dart';
import 'package:example/src/storybook/stories/primitives/linear_loader.dart';
import 'package:example/src/storybook/stories/primitives/linear_progress.dart';
import 'package:example/src/storybook/stories/primitives/menu_item.dart';
import 'package:example/src/storybook/stories/primitives/modal.dart';
import 'package:example/src/storybook/stories/primitives/popover.dart';
import 'package:example/src/storybook/stories/primitives/radio.dart';
import 'package:example/src/storybook/stories/primitives/segmented_control.dart';
import 'package:example/src/storybook/stories/primitives/switch.dart';
import 'package:example/src/storybook/stories/primitives/tab_bar.dart';
import 'package:example/src/storybook/stories/primitives/table.dart';
import 'package:example/src/storybook/stories/primitives/tag.dart';
import 'package:example/src/storybook/stories/primitives/text_area.dart';
import 'package:example/src/storybook/stories/primitives/text_input.dart';
import 'package:example/src/storybook/stories/primitives/text_input_group.dart';
import 'package:example/src/storybook/stories/primitives/toast.dart';
import 'package:example/src/storybook/stories/primitives/tooltip.dart';

enum Component {
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
  combobox,
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
  search,
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

  String get description => switch (this) {
        accordion =>
          "Accordion is a clickable list that toggles detailed content on header tap.",
        alert =>
          "Alert is a way of informing a user of important changes in a prominent way.",
        authCode =>
          "One-time password (OTP) is a unique code generated for secure logins.",
        avatar =>
          "Avatars typically display images, icons, or initials for people or entities.",
        bottomSheet =>
          "Bottom sheet is a modified dialog that slides from the bottom of the screen.",
        breadcrumb =>
          "A list of links indicating the current location in the navigation hierarchy.",
        button =>
          "Buttons communicate actions that users can take with a single tap.",
        carousel =>
          "Carousel displays multiple images or content in a swipeable format.",
        checkbox =>
          "Checkbox allows to select multiple options from a limited set of choices.",
        chip =>
          "Chip is used to filter or trigger actions in a clickable format.",
        circularLoader =>
          "Loaders provide visual feedback for in-progress tasks.",
        circularProgress =>
          "Progress indicator visually tracks a user’s progress through a set of steps.",
        combobox =>
          "Combination of dropdown and free text input for filtering options.",
        dotIndicator =>
          'Dot indicator visually tracks a user’s position in a series of items or pages.',
        drawer =>
          'Drawer is a panel that slides out from the edge of the screen.',
        dropdown =>
          "Dropdown list allows users to choose one value from a menu by clicking.",
        icons =>
          'Commonly used interface icons provided by Moon Design System.',
        linearLoader =>
          "Loaders provide visual feedback for in-progress tasks.",
        linearProgress =>
          "Progress indicator visually tracks a user’s progress through a set of steps.",
        menuItem =>
          "Menu item is a selectable option within a menu or container.",
        modal =>
          "Modal appears above content, requiring user interaction before returning.",
        popover =>
          "Popover displays additional content or actions in response to user input.",
        radio =>
          'Radio buttons represent a group of choices with single selection.',
        search =>
          'Search allows users to input a word or phrase to find relevant content.',
        segmentedControl =>
          'Segmented control lets user choose from multiple options displayed in segments.',
        switchX => 'Switch is a control used to toggle between two states.',
        tabBar =>
          'Tabs allow users to navigate easily between views within the same context.',
        table =>
          'Table is used to display large amounts of data in rows and columns.',
        tag =>
          "Tags are interactive keywords used to organize and categorize objects.",
        textArea => 'A form control for entering and editing multi-line text.',
        textInput => 'Text input fields allow users to enter text.',
        textInputGroup =>
          'Combine different types of inputs into groups to save vertical space on designs.',
        toast =>
          "Toast provides brief feedback message without interrupting the interface.",
        tooltip => 'Tooltip displays additional information about an element.',
      };

  String get urlPath => switch (this) {
        accordion => AccordionStory.path,
        alert => AlertStory.path,
        authCode => AuthCodeStory.path,
        avatar => AvatarStory.path,
        bottomSheet => BottomSheetStory.path,
        button => ButtonStory.path,
        breadcrumb => BreadcrumbStory.path,
        carousel => CarouselStory.path,
        checkbox => CheckboxStory.path,
        chip => ChipStory.path,
        circularLoader => CircularLoaderStory.path,
        circularProgress => CircularProgressStory.path,
        combobox => ComboboxSingleSelectStory.path,
        dotIndicator => DotIndicatorStory.path,
        drawer => DrawerStory.path,
        dropdown => DropdownStory.path,
        icons => IconsStory.path,
        linearLoader => LinearLoaderStory.path,
        linearProgress => LinearProgressStory.path,
        menuItem => MenuItemStory.path,
        modal => ModalStory.path,
        popover => PopoverStory.path,
        radio => RadioStory.path,
        search => SearchWithListStory.path,
        segmentedControl => SegmentedControlStory.path,
        switchX => SwitchStory.path,
        tabBar => TabBarStory.path,
        table => TableStory.path,
        tag => TagStory.path,
        textArea => TextAreaStory.path,
        textInput => TextInputStory.path,
        textInputGroup => TextInputGroupStory.path,
        toast => ToastStory.path,
        tooltip => TooltipStory.path,
      };

  String get imagePath {
    final name = toString().split('.').last;

    final formattedName = this == switchX
        ? 'switch'
        : name.replaceAllMapped(
            RegExp('[A-Z]'),
            (Match match) => '_${match.group(0)!.toLowerCase()}',
          );

    return 'assets/components/$formattedName.png';
  }
}
