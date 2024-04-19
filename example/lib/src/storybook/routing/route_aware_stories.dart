import 'package:example/src/storybook/routing/app_router.dart';
import 'package:example/src/storybook/stories/composites/combobox_multi_select.dart';
import 'package:example/src/storybook/stories/composites/combobox_single_select.dart';
import 'package:example/src/storybook/stories/composites/search_with_dropdown.dart';
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
import 'package:flutter/services.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

const String directory = 'assets/code_snippets/';

final List<Story> routeAwareStories = [
  // Composite stories.
  Story.asRoute(
    name: 'Composites/Combobox/single select combobox',
    routePath: ComboboxSingleSelectStory.path,
    router: router,
    codeString: fetchAsset('combobox_single_select.md'),
  ),
  Story.asRoute(
    name: 'Composites/Combobox/multi select combobox',
    routePath: ComboboxMultiSelectStory.path,
    router: router,
    codeString: fetchAsset('combobox_multi_select.md'),
  ),
  Story.asRoute(
    name: 'Composites/Search/search with list',
    routePath: SearchWithListStory.path,
    router: router,
    codeString: fetchAsset('search_with_list.md'),
  ),
  Story.asRoute(
    name: 'Composites/Search/search with dropdown',
    routePath: SearchWithDropdownStory.path,
    router: router,
    codeString: fetchAsset('search_with_dropdown.md'),
  ),

  // Primitive stories.
  Story.asRoute(
    name: 'Primitives/Accordion',
    routePath: AccordionStory.path,
    router: router,
    codeString: fetchAsset('accordion.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Alert',
    routePath: AlertStory.path,
    router: router,
    codeString: fetchAsset('alert.md'),
  ),
  Story.asRoute(
    name: 'Primitives/AuthCode',
    routePath: AuthCodeStory.path,
    router: router,
    codeString: fetchAsset('auth_code.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Avatar',
    routePath: AvatarStory.path,
    router: router,
    codeString: fetchAsset('avatar.md'),
  ),
  Story.asRoute(
    name: 'Primitives/BottomSheet',
    routePath: BottomSheetStory.path,
    router: router,
    codeString: fetchAsset('bottom_sheet.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Breadcrumb',
    routePath: BreadcrumbStory.path,
    router: router,
    codeString: fetchAsset('breadcrumb.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Button',
    routePath: ButtonStory.path,
    router: router,
    codeString: fetchAsset('button.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Carousel',
    routePath: CarouselStory.path,
    router: router,
    codeString: fetchAsset('carousel.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Checkbox',
    routePath: CheckboxStory.path,
    router: router,
    codeString: fetchAsset('checkbox.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Chip',
    routePath: ChipStory.path,
    router: router,
    codeString: fetchAsset('chip.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Loader/CircularLoader',
    routePath: CircularLoaderStory.path,
    router: router,
    codeString: fetchAsset('circular_loader.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Progress/CircularProgress',
    routePath: CircularProgressStory.path,
    router: router,
    codeString: fetchAsset('circular_progress.md'),
  ),
  Story.asRoute(
    name: 'Primitives/DotIndicator',
    routePath: DotIndicatorStory.path,
    router: router,
    codeString: fetchAsset('dot_indicator.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Drawer',
    routePath: DrawerStory.path,
    router: router,
    codeString: fetchAsset('drawer.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Dropdown',
    routePath: DropdownStory.path,
    router: router,
    codeString: fetchAsset('dropdown.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Icons',
    routePath: IconsStory.path,
    router: router,
    codeString: fetchAsset('icons.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Loader/LinearLoader',
    routePath: LinearLoaderStory.path,
    router: router,
    codeString: fetchAsset('linear_loader.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Progress/LinearProgress',
    routePath: LinearProgressStory.path,
    router: router,
    codeString: fetchAsset('linear_progress.md'),
  ),
  Story.asRoute(
    name: 'Primitives/MenuItem',
    routePath: MenuItemStory.path,
    router: router,
    codeString: fetchAsset('menu_item.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Modal',
    routePath: ModalStory.path,
    router: router,
    codeString: fetchAsset('modal.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Popover',
    routePath: PopoverStory.path,
    router: router,
    codeString: fetchAsset('popover.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Radio',
    routePath: RadioStory.path,
    router: router,
    codeString: fetchAsset('radio.md'),
  ),
  Story.asRoute(
    name: 'Primitives/SegmentedControl',
    routePath: SegmentedControlStory.path,
    router: router,
    codeString: fetchAsset('segmented_control.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Switch',
    routePath: SwitchStory.path,
    router: router,
    codeString: fetchAsset('switch.md'),
  ),
  Story.asRoute(
    name: 'Primitives/TabBar',
    routePath: TabBarStory.path,
    router: router,
    codeString: fetchAsset('tab_bar.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Table',
    routePath: TableStory.path,
    router: router,
    codeString: fetchAsset('table.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Tag',
    routePath: TagStory.path,
    router: router,
    codeString: fetchAsset('tag.md'),
  ),
  Story.asRoute(
    name: 'Primitives/TextArea',
    routePath: TextAreaStory.path,
    router: router,
    codeString: fetchAsset('text_area.md'),
  ),
  Story.asRoute(
    name: 'Primitives/TextInput',
    routePath: TextInputStory.path,
    router: router,
    codeString: fetchAsset('text_input.md'),
  ),
  Story.asRoute(
    name: 'Primitives/TextInputGroup',
    routePath: TextInputGroupStory.path,
    router: router,
    codeString: fetchAsset('text_input_group.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Toast',
    routePath: ToastStory.path,
    router: router,
    codeString: fetchAsset('toast.md'),
  ),
  Story.asRoute(
    name: 'Primitives/Tooltip',
    routePath: TooltipStory.path,
    router: router,
    codeString: fetchAsset('tooltip.md'),
  ),
];

Future<String> fetchAsset(String assetName) async => rootBundle.loadString('$directory$assetName');
