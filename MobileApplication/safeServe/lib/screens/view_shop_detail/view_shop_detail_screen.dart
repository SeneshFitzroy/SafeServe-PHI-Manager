// lib/screens/view_shop_detail/view_shop_detail_screen.dart

import 'package:flutter/material.dart';
import '../../widgets/safe_serve_appbar.dart';
import 'widgets/view_shop_header.dart';
import 'widgets/view_text_field.dart';
import 'widgets/view_trade_dropdown.dart';

class ViewShopDetailScreen extends StatefulWidget {
  const ViewShopDetailScreen({Key? key}) : super(key: key);

  @override
  State<ViewShopDetailScreen> createState() => _ViewShopDetailScreenState();
}

class _ViewShopDetailScreenState extends State<ViewShopDetailScreen> {
  late Map<String, dynamic> shopData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    shopData = (args is Map<String, dynamic>) ? args : {};
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = shopData['image'] as String? ?? '';
    return Scaffold(
      appBar: SafeServeAppBar(
        height: 70,
        onMenuPressed: () {},
      ),
      body: Stack(
        children: [
          _buildGradient(),
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                ViewShopHeader(
                  title: 'View Shop Details',
                  onArrowPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 20),
                ViewTextField(label: 'Reference No', value: shopData['referenceNo'] ?? ''),
                ViewTextField(label: 'PHI Area',       value: shopData['phiArea'] ?? ''),
                ViewTradeDropdown(label: 'Type of Trade', value: shopData['typeOfTrade'] ?? ''),
                ViewTextField(label: 'Owner',          value: shopData['ownerName'] ?? ''),
                ViewTextField(label: 'Address',        value: shopData['address'] ?? ''),
                ViewTextField(label: 'Telephone',      value: shopData['telephone'] ?? ''),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  child: Text('Image of the Shop', style: TextStyle(fontSize: 18, color: Colors.black)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF4289FC)),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: imagePath.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: imagePath.startsWith('http')
                          ? Image.network(imagePath, fit: BoxFit.cover, width: double.infinity)
                          : Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity),
                    )
                        : const Center(child: Text('No image provided')),
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F41BB),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/shop_detail', arguments: shopData['name']);
              },
              child: const Text('Close', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradient() => Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
      ),
    ),
  );
}
