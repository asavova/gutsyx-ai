import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

final subscriptionProvider = StateNotifierProvider<SubscriptionNotifier, Offering?>((ref) {
  return SubscriptionNotifier();
});

class SubscriptionNotifier extends StateNotifier<Offering?> {
  SubscriptionNotifier() : super(null) {
    _init();
  }

  Future<void> _init() async {
    try {
      final String apiKey;
      
      // Using String.fromEnvironment for zero-dependency configuration
      if (Platform.isIOS) {
        apiKey = const String.fromEnvironment('REVENUECAT_API_KEY_IOS');
      } else if (Platform.isAndroid) {
        apiKey = const String.fromEnvironment('REVENUECAT_API_KEY_ANDROID');
      } else {
        throw UnsupportedError('This platform is not supported by GutsyX RevenueCat module.');
      }

      if (apiKey.isEmpty) {
        print("GutsyX Error: RevenueCat API Key is missing. Build with --dart-define.");
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
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      // Ensure 'gutsyX Premium' matches your Entitlement ID in the RevenueCat Dashboard
      return customerInfo.entitlements.active.containsKey('gutsyX Premium');
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
