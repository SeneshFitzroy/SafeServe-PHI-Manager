import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../shop_detail/widgets/shop_image.dart';
import 'widgets/view_shop_header.dart';
import 'widgets/view_text_field.dart';
import 'widgets/view_trade_dropdown.dart';

class ViewShopDetailScreen extends StatefulWidget {
  const ViewShopDetailScreen({super.key});

  @override
  State<ViewShopDetailScreen> createState() => _ViewShopDetailScreenState();
}

class _ViewShopDetailScreenState extends State<ViewShopDetailScreen> {
  late final Map<String, dynamic> d;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      d = args;
    } else {
      d = {};
    }
  }

  String _formatDate(dynamic ts) {
    if (ts == null) return '';
    if (ts is DateTime) return DateFormat('yyyy-MM-dd').format(ts);
    try {
      final date = (ts as dynamic).toDate();
      if (date is DateTime) {
        return DateFormat('yyyy-MM-dd').format(date);
      }
    } catch (_) {}
    return ts.toString();
  }

  @override
  Widget build(BuildContext context) {
    final licensedDateStr = _formatDate(d['licensedDate']);

    return Scaffold(
      appBar: SafeServeAppBar(height: 70, onMenuPressed: () {}),
      body: Stack(children: [
        _gradient(),
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

              ViewTextField(label: 'Reference Number', value: d['referenceNo'] ?? ''),
              ViewTextField(label: 'Business Reg. Number', value: d['businessRegNumber'] ?? ''),
              ViewTextField(label: 'Name of Establishment', value: d['name'] ?? ''),
              ViewTextField(label: 'Address of Establishment', value: d['establishmentAddress'] ?? ''),
              ViewTextField(label: 'District', value: d['district'] ?? ''),
              ViewTextField(label: 'GN Division', value: d['gnDivision'] ?? ''),
              ViewTextField(label: 'License Number', value: d['licenseNumber'] ?? ''),
              ViewTextField(label: 'Licensed Date', value: licensedDateStr),
              ViewTradeDropdown(label: 'Type of Trade', value: d['typeOfTrade'] ?? ''),
              ViewTextField(label: 'Number of Employees', value: d['numberOfEmployees']?.toString() ?? ''),
              ViewTextField(label: 'Name of Owner', value: d['ownerName'] ?? ''),
              ViewTextField(label: 'NIC Number', value: d['nicNumber'] ?? ''),
              ViewTextField(label: 'Private Address', value: d['privateAddress'] ?? ''),
              ViewTextField(label: 'Telephone', value: d['telephone'] ?? ''),
              const SizedBox(height: 15),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Text('Image of the Shop', style: TextStyle(fontSize: 18, color: Colors.black)),
              ),
              ShopImage(imagePath: d['image'] ?? ''),
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
            onPressed: () => Navigator.pushReplacementNamed(
                context, '/shop_detail', arguments: d['referenceNo'] ?? ''),
            child: const Text('Close',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      ]),
    );
  }

  Widget _gradient() => Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)]),
    ),
  );
}
