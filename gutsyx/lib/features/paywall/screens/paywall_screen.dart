import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gutsyx/core/theme.dart';
import 'package:gutsyx/features/auth/providers/auth_provider.dart';
import 'package:gutsyx/features/paywall/providers/subscription_provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key});

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  Package? _selectedPackage;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final offering = ref.watch(subscriptionProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/dashboard'),
        ),
      ),
      body: offering == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const Icon(Icons.auto_awesome, size: 64, color: AppTheme.metallicPurple),
                  const SizedBox(height: 24),
                  const Text(
                    'GutsyX Premium',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Unlock unlimited AI scans and personalized health insights.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),
                  _buildFeatureRow(Icons.check_circle, 'Unlimited AI Analysis'),
                  _buildFeatureRow(Icons.check_circle, 'Detailed Bristol Scale Tracking'),
                  _buildFeatureRow(Icons.check_circle, 'Advanced AI Insights'),
                  _buildFeatureRow(Icons.check_circle, 'Advanced Hydration & Color Metrics'),
                  const SizedBox(height: 40),
                  if (offering.annual != null)
                    _buildSubscriptionOption(
                      package: offering.annual!,
                      title: 'Yearly',
                      subtitle: '7-Day Free Trial • Best Value',
                    ),
                  const SizedBox(height: 16),
                  if (offering.monthly != null)
                    _buildSubscriptionOption(
                      package: offering.monthly!,
                      title: 'Monthly',
                      subtitle: 'Cancel anytime',
                    ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _selectedPackage == null || _isLoading
                        ? null
                        : () async {
                            setState(() => _isLoading = true);
                            final success = await ref
                                .read(subscriptionProvider.notifier)
                                .purchasePackage(_selectedPackage!);
                            setState(() => _isLoading = false);
                            if (success) {
                              ref.read(authProvider.notifier).setPremium(true);
                              if (mounted) context.go('/dashboard');
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.electricBlue,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            _selectedPackage?.packageType == PackageType.annual
                                ? 'Start 7-Day Free Trial'
                                : 'Subscribe Now',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => ref.read(subscriptionProvider.notifier).restorePurchases(),
                    child: const Text(
                      'Restore Purchases',
                      style: TextStyle(color: Colors.grey, decoration: TextDecoration.underline),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.electricBlue, size: 24),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildSubscriptionOption({
    required Package package,
    required String title,
    required String subtitle,
  }) {
    final isSelected = _selectedPackage == package;
    return InkWell(
      onTap: () => setState(() => _selectedPackage = package),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.electricBlue : Colors.grey[300]!,
            width: 2,
          ),
          color: isSelected ? AppTheme.electricBlue.withOpacity(0.05) : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ],
            ),
            Text(
              package.storeProduct.priceString,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
