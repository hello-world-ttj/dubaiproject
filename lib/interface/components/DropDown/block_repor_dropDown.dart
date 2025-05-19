import 'dart:developer';

import 'package:dubaiprojectxyvin/Data/models/business_model.dart';
import 'package:dubaiprojectxyvin/Data/models/msg_model.dart';
import 'package:dubaiprojectxyvin/Data/models/product_model.dart';
import 'package:dubaiprojectxyvin/Data/notifiers/business_notifier.dart';
import 'package:dubaiprojectxyvin/interface/components/dialogs/blockPersonDialog.dart';
import 'package:dubaiprojectxyvin/interface/components/dialogs/report_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'selectionDropdown.dart';

class BlockReportDropdown extends ConsumerWidget {
  final Business? feed;
  final Product? product;
  final MessageModel? msg;
  final String? userId;
  final VoidCallback? onBlockStatusChanged;
  final bool? isBlocked;

  const BlockReportDropdown({
    this.onBlockStatusChanged,
    this.userId,
    this.msg,
    super.key,
    this.feed,
    this.isBlocked,
    this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SelectionDropDown(
      hintText: '',
      value: null,
      items: [
        DropdownMenuItem(
          value: 'report',
          child: Text(
            'Report',
            style: TextStyle(color: Colors.red),
          ),
        ),
        DropdownMenuItem(
          value: 'block',
          child: isBlocked != null && isBlocked == false
              ? Text(
                  'Block',
                  style: TextStyle(color: Colors.red),
                )
              : Text(
                  'Unblock',
                  style: TextStyle(color: Colors.red),
                ),
        ),
      ],
      onChanged: (value) async {
        if (value == 'report') {
          String reportType = '';
          if (feed != null) {
            reportType = 'Feeds';
            showReportPersonDialog(
                reportedItemId: feed?.id ?? '',
                context: context,
                onReportStatusChanged: () {},
                reportType: reportType);
          } else if (userId != null) {
            log(userId.toString());
            reportType = 'User';
            showReportPersonDialog(
                reportedItemId: userId ?? '',
                context: context,
                userId: userId ?? '',
                onReportStatusChanged: () {},
                reportType: reportType);
          } else if (product != null) {
            log(product.toString());
            reportType = 'Product';
            showReportPersonDialog(
                reportedItemId: product?.id ?? '',
                context: context,
                userId: userId ?? '',
                onReportStatusChanged: () {},
                reportType: reportType);
          } else {
            reportType = 'Message';
            showReportPersonDialog(
                reportedItemId: msg?.id ?? '',
                context: context,
                onReportStatusChanged: () {},
                reportType: reportType);
          }
        } else if (value == 'block') {
          if (feed != null) {
            showBlockPersonDialog(
                context: context,
                userId: feed?.author ?? '',
                onBlockStatusChanged: () {
                  ref.invalidate(businessNotifierProvider);
                });
          } else if (userId != null) {
            showBlockPersonDialog(
                context: context,
                userId: userId ?? '',
                onBlockStatusChanged: () {
                  onBlockStatusChanged;
                });
          }
        }
      },
    );
  }
}
