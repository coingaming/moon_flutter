import 'package:example/src/storybook/common/icons/icons_arrows_list.dart';
import 'package:example/src/storybook/common/icons/icons_charts_list.dart';
import 'package:example/src/storybook/common/icons/icons_chat_list.dart';
import 'package:example/src/storybook/common/icons/icons_controls_list.dart';
import 'package:example/src/storybook/common/icons/icons_devices_list.dart';
import 'package:example/src/storybook/common/icons/icons_files_list.dart';
import 'package:example/src/storybook/common/icons/icons_generic_list.dart';
import 'package:example/src/storybook/common/icons/icons_mail_list.dart';
import 'package:example/src/storybook/common/icons/icons_maps_list.dart';
import 'package:example/src/storybook/common/icons/icons_media_list.dart';
import 'package:example/src/storybook/common/icons/icons_notifications_list.dart';
import 'package:example/src/storybook/common/icons/icons_other_list.dart';
import 'package:example/src/storybook/common/icons/icons_security_list.dart';
import 'package:example/src/storybook/common/icons/icons_shop_list.dart';
import 'package:example/src/storybook/common/icons/icons_software_list.dart';
import 'package:example/src/storybook/common/icons/icons_sports_list.dart';
import 'package:example/src/storybook/common/icons/icons_text_edit_list.dart';
import 'package:example/src/storybook/common/icons/icons_time_list.dart';
import 'package:example/src/storybook/common/icons/icons_travel_list.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class IconsStory extends Story {
  IconsStory()
      : super(
          name: "Icons",
          builder: (context) {
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(height: 24),
                ),
                _IconsGridWithTitle(
                  title: "Arrows",
                  iconsList: iconsArrowsList,
                  iconsNameList: iconsArrowsNameList,
                ),
                _IconsGridWithTitle(
                  title: "Charts",
                  iconsList: iconsChartsList,
                  iconsNameList: iconsChartsNameList,
                ),
                _IconsGridWithTitle(
                  title: "Chat",
                  iconsList: iconsChatList,
                  iconsNameList: iconsChatNameList,
                ),
                _IconsGridWithTitle(
                  title: "Controls",
                  iconsList: iconsControlsList,
                  iconsNameList: iconsControlsNameList,
                ),
                _IconsGridWithTitle(
                  title: "Devices",
                  iconsList: iconsDevicesList,
                  iconsNameList: iconsDevicesNameList,
                ),
                _IconsGridWithTitle(
                  title: "Files",
                  iconsList: iconsFilesList,
                  iconsNameList: iconsFilesNameList,
                ),
                _IconsGridWithTitle(
                  title: "Generic",
                  iconsList: iconsGenericList,
                  iconsNameList: iconsGenericNameList,
                ),
                _IconsGridWithTitle(
                  title: "Mail",
                  iconsList: iconsMailList,
                  iconsNameList: iconsMailNameList,
                ),
                _IconsGridWithTitle(
                  title: "Maps",
                  iconsList: iconsMapsList,
                  iconsNameList: iconsMapsNameList,
                ),
                _IconsGridWithTitle(
                  title: "Media",
                  iconsList: iconsMediaList,
                  iconsNameList: iconsMediaNameList,
                ),
                _IconsGridWithTitle(
                  title: "Notifications",
                  iconsList: iconsNotificationsList,
                  iconsNameList: iconsNotificationsNameList,
                ),
                _IconsGridWithTitle(
                  title: "Other",
                  iconsList: iconsOtherList,
                  iconsNameList: iconsOtherNameList,
                ),
                _IconsGridWithTitle(
                  title: "Security",
                  iconsList: iconsSecurityList,
                  iconsNameList: iconsSecurityNameList,
                ),
                _IconsGridWithTitle(
                  title: "Shop",
                  iconsList: iconsShopList,
                  iconsNameList: iconsShopNameList,
                ),
                _IconsGridWithTitle(
                  title: "Software",
                  iconsList: iconsSoftwareList,
                  iconsNameList: iconsSoftwareNameList,
                ),
                _IconsGridWithTitle(
                  title: "Sports",
                  iconsList: iconsSportsList,
                  iconsNameList: iconsSportsNameList,
                ),
                _IconsGridWithTitle(
                  title: "Text Edit",
                  iconsList: iconsTextEditList,
                  iconsNameList: iconsTextEditNameList,
                ),
                _IconsGridWithTitle(
                  title: "Time",
                  iconsList: iconsTimeList,
                  iconsNameList: iconsTimeNameList,
                ),
                _IconsGridWithTitle(
                  title: "Travel",
                  iconsList: iconsTravelList,
                  iconsNameList: iconsTravelNameList,
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 24),
                ),
              ],
            );
          },
        );
}

class _IconsGridWithTitle extends StatelessWidget {
  final String title;
  final List<Icon> iconsList;
  final List<String> iconsNameList;

  const _IconsGridWithTitle({
    required this.title,
    required this.iconsList,
    required this.iconsNameList,
  });

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverPadding(
          padding: const EdgeInsets.only(top: 40, bottom: 16),
          sliver: SliverToBoxAdapter(
            child: TextDivider(text: title),
          ),
        ),
        SliverGrid.builder(
          itemCount: iconsList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconsList[index],
                const SizedBox(height: 20),
                Text(
                  iconsNameList[index],
                  style: TextStyle(fontSize: 10, color: context.moonColors!.trunks),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
