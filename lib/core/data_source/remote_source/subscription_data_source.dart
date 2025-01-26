import 'package:birthday_gift/utils/logger/logger.dart' as log;
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

class SubscriptionDataSource {

  Future<void> initPlatformState() async {
    await Purchases.setLogLevel(LogLevel.debug);

    PurchasesConfiguration configuration = PurchasesConfiguration(_revenueCatKey);
    await Purchases.configure(configuration);
  }

  Future<bool> isSubscriptionEnabled() async {
    try {
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      for (var entitlement in customerInfo.entitlements.all.values) {
        log.Log.i("Entitlement ${entitlement.identifier}: isActive=${entitlement.isActive}, isSandbox=${entitlement.isSandbox}");
      }
      return customerInfo.entitlements.active.isNotEmpty;
    } on Exception catch (e) {
      log.Log.e(e);
      return false;
    }
  }

  Future<void> showPaywall() async {
    await RevenueCatUI.presentPaywall();
  }

  static const _revenueCatKey = "goog_QRewhqwPxjUqetOxMAvIzVWtypy";
}
