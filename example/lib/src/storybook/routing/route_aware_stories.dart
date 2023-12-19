import 'package:example/src/storybook/routing/app_router.dart';
import 'package:example/src/storybook/stories/accordion.dart';
import 'package:example/src/storybook/stories/alert.dart';
import 'package:example/src/storybook/stories/auth_code.dart';
import 'package:example/src/storybook/stories/avatar.dart';
import 'package:example/src/storybook/stories/bottom_sheet.dart';
import 'package:example/src/storybook/stories/button.dart';
import 'package:example/src/storybook/stories/carousel.dart';
import 'package:example/src/storybook/stories/checkbox.dart';
import 'package:example/src/storybook/stories/chip.dart';
import 'package:example/src/storybook/stories/circular_loader.dart';
import 'package:example/src/storybook/stories/circular_progress.dart';
import 'package:example/src/storybook/stories/dot_indicator.dart';
import 'package:example/src/storybook/stories/drawer.dart';
import 'package:example/src/storybook/stories/dropdown.dart';
import 'package:example/src/storybook/stories/icons.dart';
import 'package:example/src/storybook/stories/linear_loader.dart';
import 'package:example/src/storybook/stories/linear_progress.dart';
import 'package:example/src/storybook/stories/menu_item.dart';
import 'package:example/src/storybook/stories/modal.dart';
import 'package:example/src/storybook/stories/popover.dart';
import 'package:example/src/storybook/stories/radio.dart';
import 'package:example/src/storybook/stories/segmented_control.dart';
import 'package:example/src/storybook/stories/switch.dart';
import 'package:example/src/storybook/stories/tab_bar.dart';
import 'package:example/src/storybook/stories/table.dart';
import 'package:example/src/storybook/stories/tag.dart';
import 'package:example/src/storybook/stories/text_area.dart';
import 'package:example/src/storybook/stories/text_input.dart';
import 'package:example/src/storybook/stories/text_input_group.dart';
import 'package:example/src/storybook/stories/toast.dart';
import 'package:example/src/storybook/stories/tooltip.dart';
import 'package:flutter/services.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

const String directory = 'assets/code_snippets/';

final List<Story> routeAwareStories = [
  Story.asRoute(
    name: 'Accordion',
    routePath: AccordionStory.path,
    router: router,
    codeString: fetchAsset('accordion.md'),
  ),
  Story.asRoute(
    name: 'Alert',
    routePath: AlertStory.path,
    router: router,
    codeString: fetchAsset('alert.md'),
  ),
  Story.asRoute(
    name: 'AuthCode',
    routePath: AuthCodeStory.path,
    router: router,
    codeString: fetchAsset('auth_code.md'),
  ),
  Story.asRoute(
    name: 'Avatar',
    routePath: AvatarStory.path,
    router: router,
    codeString: fetchAsset('avatar.md'),
  ),
  Story.asRoute(
    name: 'BottomSheet',
    routePath: BottomSheetStory.path,
    router: router,
    codeString: fetchAsset('bottom_sheet.md'),
  ),
  Story.asRoute(
    name: 'Button',
    routePath: ButtonStory.path,
    router: router,
    codeString: fetchAsset('button.md'),
  ),
  Story.asRoute(
    name: 'Carousel',
    routePath: CarouselStory.path,
    router: router,
    codeString: fetchAsset('carousel.md'),
  ),
  Story.asRoute(
    name: 'Checkbox',
    routePath: CheckboxStory.path,
    router: router,
    codeString: fetchAsset('checkbox.md'),
  ),
  Story.asRoute(
    name: 'Chip',
    routePath: ChipStory.path,
    router: router,
    codeString: fetchAsset('chip.md'),
  ),
  Story.asRoute(
    name: 'Loader/CircularLoader',
    routePath: CircularLoaderStory.path,
    router: router,
    codeString: fetchAsset('circular_loader.md'),
  ),
  Story.asRoute(
    name: 'Progress/CircularProgress',
    routePath: CircularProgressStory.path,
    router: router,
    codeString: fetchAsset('circular_progress.md'),
  ),
  Story.asRoute(
    name: 'DotIndicator',
    routePath: DotIndicatorStory.path,
    router: router,
    codeString: fetchAsset('dot_indicator.md'),
  ),
  Story.asRoute(
    name: 'Drawer',
    routePath: DrawerStory.path,
    router: router,
    codeString: fetchAsset('drawer.md'),
  ),
  Story.asRoute(
    name: 'Dropdown',
    routePath: DropdownStory.path,
    router: router,
    codeString: fetchAsset('dropdown.md'),
  ),
  Story.asRoute(
    name: 'Icons',
    routePath: IconsStory.path,
    router: router,
    codeString: fetchAsset('icons.md'),
  ),
  Story.asRoute(
    name: 'Loader/LinearLoader',
    routePath: LinearLoaderStory.path,
    router: router,
    codeString: fetchAsset('linear_loader.md'),
  ),
  Story.asRoute(
    name: 'Progress/LinearProgress',
    routePath: LinearProgressStory.path,
    router: router,
    codeString: fetchAsset('linear_progress.md'),
  ),
  Story.asRoute(
    name: 'MenuItem',
    routePath: MenuItemStory.path,
    router: router,
    codeString: fetchAsset('menu_item.md'),
  ),
  Story.asRoute(
    name: 'Modal',
    routePath: ModalStory.path,
    router: router,
    codeString: fetchAsset('modal.md'),
  ),
  Story.asRoute(
    name: 'Popover',
    routePath: PopoverStory.path,
    router: router,
    codeString: fetchAsset('popover.md'),
  ),
  Story.asRoute(
    name: 'Radio',
    routePath: RadioStory.path,
    router: router,
    codeString: fetchAsset('radio.md'),
  ),
  Story.asRoute(
    name: 'SegmentedControl',
    routePath: SegmentedControlStory.path,
    router: router,
    codeString: fetchAsset('segmented_control.md'),
  ),
  Story.asRoute(
    name: 'Switch',
    routePath: SwitchStory.path,
    router: router,
    codeString: fetchAsset('switch.md'),
  ),
  Story.asRoute(
    name: 'TabBar',
    routePath: TabBarStory.path,
    router: router,
    codeString: fetchAsset('tab_bar.md'),
  ),
  Story.asRoute(
    name: 'Table',
    routePath: TableStory.path,
    router: router,
    codeString: fetchAsset('table.md'),
  ),
  Story.asRoute(
    name: 'Tag',
    routePath: TagStory.path,
    router: router,
    codeString: fetchAsset('tag.md'),
  ),
  Story.asRoute(
    name: 'TextArea',
    routePath: TextAreaStory.path,
    router: router,
    codeString: fetchAsset('text_area.md'),
  ),
  Story.asRoute(
    name: 'TextInput',
    routePath: TextInputStory.path,
    router: router,
    codeString: fetchAsset('text_input.md'),
  ),
  Story.asRoute(
    name: 'TextInputGroup',
    routePath: TextInputGroupStory.path,
    router: router,
    codeString: fetchAsset('text_input_group.md'),
  ),
  Story.asRoute(
    name: 'Toast',
    routePath: ToastStory.path,
    router: router,
    codeString: fetchAsset('toast.md'),
  ),
  Story.asRoute(
    name: 'Tooltip',
    routePath: TooltipStory.path,
    router: router,
    codeString: fetchAsset('tooltip.md'),
  ),
];

Future<String> fetchAsset(String assetName) async => rootBundle.loadString('$directory$assetName');
