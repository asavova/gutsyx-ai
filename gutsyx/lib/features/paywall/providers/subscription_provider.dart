import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final subscriptionProvider = StateNotifierProvider<SubscriptionNotifier, Offering?>((ref) {
  return SubscriptionNotifier();
});

class SubscriptionNotifier extends StateNotifier<Offering?> {
  SubscriptionNotifier() : super(null) {
    _init();
  }

  Future<void> _init() async {
    try {
      final String? apiKey;
      
      // Handle platform-specific keys from .env
      if (Platform.isIOS) {
        apiKey = dotenv.env['REVENUECAT_API_KEY_IOS'];
      } else if (Platform.isAndroid) {
        apiKey = dotenv.env['REVENUECAT_API_KEY_ANDROID'];
      } else {
        throw UnsupportedError('This platform is not supported by GutsyX RevenueCat module.');
      }

      if (apiKey == null || apiKey.isEmpty) {
        print("GutsyX Error: RevenueCat API Key is missing in .env configuration.");
        return;
      }

      await Purchases.configure(PurchasesConfiguration(apiKey));
      
      final offerings = await Purchases.getOfferings();
      if (offerings.current != null) {
        state = offerings.current;
      }
    } catch (e) {
      print("GutsyX Subscription Service: Failed to initialize. Error: $e");
    }
  }

  Future<bool> purchasePackage(Package package) async {
    try {

      final CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      final hasPro = customerInfo.entitlements.active.containsKey('gutsyX Premium');
      return hasPro;
    } catch (e) {
      print("GutsyX Purchase Module: Transaction failed. Error: $e");
      return false;
    }
  }

  Future<void> restorePurchases() async {
    try {
      await Purchases.restorePurchases();
      print("GutsyX Purchase Module: Entitlements restored successfully.");
    } catch (e) {
      print("GutsyX Purchase Module: Restore failed. Error: $e");
    }
  }
}
