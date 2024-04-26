import 'dart:async';

import 'package:development/services/navigation_service.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:share_plus/share_plus.dart';

class BranchService {
  BranchContentMetaData metadata = BranchContentMetaData();
  BranchLinkProperties lp = BranchLinkProperties();
  late BranchUniversalObject buo;
  late BranchEvent eventStandard;
  late BranchEvent eventCustom;

  StreamSubscription<Map>? streamSubscription;
  StreamController<String> controllerData = StreamController<String>();
  StreamController<String> controllerInitSession = StreamController<String>();

  void listenDynamicLinks() async {
    streamSubscription = FlutterBranchSdk.listSession().listen(
      (data) async {
        debugPrint('listenDynamicLinks - DeepLink Data: $data');
        controllerData.sink.add((data.toString()));

        if (data.containsKey('+clicked_branch_link') &&
            data['+clicked_branch_link'] == true) {
          debugPrint(
              '------------------------------------Link clicked----------------------------------------------');
          debugPrint('Key: ${data['key']}');
          debugPrint('Chip ID: ${data['chip_id']}');
          debugPrint(
              '------------------------------------------------------------------------------------------------');
          debugPrint(
            'Link clicked: Custom string - ${data['custom_string']} - Date: ${data['custom_date_created'] ?? ''}',
          );

          if (data['key'] == '1') {
            debugPrint("Key correct");
            NavigationService.routeToNamed(
              '/view-chip',
              arguments: {"chipId": data['chip_id']},
            );
          }
        }
      },
      onError: (error) {
        debugPrint('listSession error: ${error.toString()}');
      },
    );
  }

  void initDeepLinkData() {
    final DateTime today = DateTime.now();
    String dateString =
        '${today.year}-${today.month}-${today.day} ${today.hour}:${today.minute}:${today.second}';

    metadata = BranchContentMetaData()
      ..addCustomMetadata('custom_string', 'abcd')
      ..addCustomMetadata('custom_number', 12345)
      ..addCustomMetadata('custom_bool', true)
      ..addCustomMetadata('custom_list_number', [1, 2, 3, 4, 5])
      ..addCustomMetadata('custom_list_string', ['a', 'b', 'c'])
      ..addCustomMetadata('custom_date_created', dateString);
    //--optional Custom Metadata
    /*
      ..contentSchema = BranchContentSchema.COMMERCE_PRODUCT
      ..price = 50.99
      ..currencyType = BranchCurrencyType.BRL
      ..quantity = 50
      ..sku = 'sku'
      ..productName = 'productName'
      ..productBrand = 'productBrand'
      ..productCategory = BranchProductCategory.ELECTRONICS
      ..productVariant = 'productVariant'
      ..condition = BranchCondition.NEW
      ..rating = 100
      ..ratingAverage = 50
      ..ratingMax = 100
      ..ratingCount = 2
      ..setAddress(
          street: 'street',
          city: 'city',
          region: 'ES',
          country: 'Brazil',
          postalCode: '99999-987')
      ..setLocation(31.4521685, -114.7352207);
      */

    const canonicalIdentifier = 12;

    buo = BranchUniversalObject(
        canonicalIdentifier: 'flutter/branch_$canonicalIdentifier',
        title: 'Flutter Branch Plugin - $dateString',
        contentDescription: 'Flutter Branch Description - $dateString',
        contentMetadata: metadata,
        keywords: ['Plugin', 'Branch', 'Flutter'],
        publiclyIndex: true,
        locallyIndex: true,
        expirationDateInMilliSec: DateTime.now()
            .add(const Duration(days: 365))
            .millisecondsSinceEpoch);
    lp = BranchLinkProperties(
        channel: 'share',
        feature: 'sharing',
        stage: 'new share',
        campaign: 'campaign',
        tags: ['one', 'two', 'three'])
      ..addControlParam('\$uri_redirect_mode', '1')
      ..addControlParam('\$ios_nativelink', true)
      ..addControlParam('\$match_duration', 7200)
      ..addControlParam('\$always_deeplink', true)
      ..addControlParam('\$android_redirect_timeout', 750)
      ..addControlParam('referring_user_id', 'user_id');

    eventStandard = BranchEvent.standardEvent(BranchStandardEvent.ADD_TO_CART)
      //--optional Event data
      ..transactionID = '12344555'
      ..alias = 'StandardEventAlias'
      ..currency = BranchCurrencyType.BRL
      ..revenue = 1.5
      ..shipping = 10.2
      ..tax = 12.3
      ..coupon = 'test_coupon'
      ..affiliation = 'test_affiliation'
      ..eventDescription = 'Event_description'
      ..searchQuery = 'item 123'
      ..adType = BranchEventAdType.BANNER
      ..addCustomData(
          'Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
      ..addCustomData(
          'Custom_Event_Property_Key2', 'Custom_Event_Property_val2');

    eventCustom = BranchEvent.customEvent('Custom_event')
      ..alias = 'CustomEventAlias'
      ..addCustomData(
          'Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
      ..addCustomData(
          'Custom_Event_Property_Key2', 'Custom_Event_Property_val2');
  }

  void generateLink(BuildContext context, BranchUniversalObject buo,
      BranchLinkProperties lp) async {
    initDeepLinkData();

    BranchResponse response =
        await FlutterBranchSdk.getShortUrl(buo: buo, linkProperties: lp);
    if (response.success) {
      if (context.mounted) {
        debugPrint(response.result);

        // Clipboard.setData(ClipboardData(text: response.result)).then((_) {
        //   HelperWidgets.showSnackbar(
        //       context, 'Copied to clipboard!', 'success');
        // });

        Share.share('Check out this chip: ${response.result}');
      }
    } else {
      debugPrint('Error : ${response.errorCode} - ${response.errorMessage}');
    }
  }
}
