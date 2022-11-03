import 'package:carclenx_vendor_app/controller/notification_controller.dart';
import 'package:carclenx_vendor_app/controller/splash_controller.dart';
import 'package:carclenx_vendor_app/helper/date_converter.dart';
import 'package:carclenx_vendor_app/util/dimensions.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:carclenx_vendor_app/util/styles.dart';
import 'package:carclenx_vendor_app/view/base/custom_app_bar.dart';
import 'package:carclenx_vendor_app/view/base/custom_image.dart';
import 'package:carclenx_vendor_app/view/base/loading_screen.dart';
import 'package:carclenx_vendor_app/view/screens/notification/widget/notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class NotificationScreen extends StatelessWidget {
  RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'notification'.tr),
      body:
          GetBuilder<NotificationController>(builder: (notificationController) {
        if (notificationController.notificationList != null) {
          notificationController.saveSeenNotificationCount(
              notificationController.notificationList.length);
        }
        List<DateTime> _dateTimeList = [];
        return notificationController.isLoading
            ? LoadingScreen()
            : notificationController.notificationList != null
                ? notificationController.notificationList.length > 0
                    ? SmartRefresher(
                        enablePullDown: true,
                        onRefresh: () async {
                          await notificationController
                              .getNotificationList()
                              .then((value) =>
                                  _refreshController.refreshCompleted());
                        },
                        controller: _refreshController,
                        child: Scrollbar(
                            child: SingleChildScrollView(
                                child: Center(
                                    child: SizedBox(
                                        width: 1170,
                                        child: ListView.builder(
                                          itemCount: notificationController
                                              .notificationList.length,
                                          padding: EdgeInsets.zero,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            DateTime _originalDateTime =
                                                DateConverter
                                                    .dateTimeStringToDate(
                                                        notificationController
                                                            .notificationList[
                                                                index]
                                                            .createdAt
                                                            .toString());
                                            DateTime _convertedDate = DateTime(
                                                _originalDateTime.year,
                                                _originalDateTime.month,
                                                _originalDateTime.day);
                                            bool _addTitle = false;
                                            if (!_dateTimeList
                                                .contains(_convertedDate)) {
                                              _addTitle = true;
                                              _dateTimeList.add(_convertedDate);
                                            }
                                            return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  _addTitle
                                                      ? Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(10, 10,
                                                                  10, 0),
                                                          child: Text(DateConverter
                                                              .dateTimeStringToDateOnly(
                                                                  notificationController
                                                                      .notificationList[
                                                                          index]
                                                                      .createdAt
                                                                      .toString())),
                                                        )
                                                      : SizedBox(),
                                                  ListTile(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return NotificationDialog(
                                                                notificationModel:
                                                                    notificationController
                                                                            .notificationList[
                                                                        index]);
                                                          });
                                                    },
                                                    leading: ClipOval(
                                                        child: CustomImage(
                                                      image: notificationController
                                                                      .notificationList[
                                                                          index]
                                                                      .imageUrl !=
                                                                  null &&
                                                              notificationController
                                                                      .notificationList[
                                                                          index]
                                                                      .imageUrl
                                                                      .length >
                                                                  0
                                                          ? '${notificationController.notificationList[index].imageUrl[0]}'
                                                          : '',
                                                      height: 40,
                                                      width: 40,
                                                      fit: BoxFit.cover,
                                                    )),
                                                    title: Text(
                                                      notificationController
                                                              .notificationList[
                                                                  index]
                                                              .title ??
                                                          '',
                                                      style: robotoMedium.copyWith(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_SMALL),
                                                    ),
                                                    subtitle: Text(
                                                      notificationController
                                                              .notificationList[
                                                                  index]
                                                              .description ??
                                                          '',
                                                      style: robotoRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_SMALL),
                                                    ),
                                                    trailing: Text(
                                                        DateConverter.timeAgo(
                                                            dateTime:
                                                                notificationController
                                                                    .notificationList[
                                                                        index]
                                                                    .updatedAt),
                                                        style: robotoRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_EXTRA_SMALL,
                                                            color: Theme.of(
                                                                    context)
                                                                .disabledColor)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: Dimensions
                                                            .PADDING_SIZE_SMALL),
                                                    child: Divider(
                                                        color: Theme.of(context)
                                                            .disabledColor),
                                                  ),
                                                ]);
                                          },
                                        ))))),
                      )
                    : Center(child: Text('no_notification_found'.tr))
                : Center(child: CircularProgressIndicator());
      }),
    );
  }
}
