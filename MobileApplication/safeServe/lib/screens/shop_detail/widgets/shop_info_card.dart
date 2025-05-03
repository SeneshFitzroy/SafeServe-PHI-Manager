import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopInfoCard extends StatelessWidget {
  final Map<String, dynamic> shopData;
  const ShopInfoCard({Key? key, required this.shopData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration:
        BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Text('Shop Details',
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            const Spacer(),
            _iconBtn(MdiIcons.eyeOutline, const Color(0xFF34AC33), () {
              Navigator.pushNamed(context, '/view_shop_detail',
                  arguments: shopData);
            }),
            _iconBtn(MdiIcons.pencilOutline, const Color(0xFFF1D730), () {
              Navigator.pushNamed(context, '/edit_shop_detail',
                  arguments: shopData);
            }),
            _iconBtn(MdiIcons.trashCanOutline, const Color(0xFFBB1F22), () {
              _confirmDelete(context);
            }),
          ]),
          const SizedBox(height: 20),

          _row('Reference No', shopData['referenceNo'] ?? ''),
          _row('GN Division',  shopData['gnDivision'] ?? ''),
          _row('Type of Trade', shopData['typeOfTrade'] ?? ''),
          _row('Address', shopData['establishmentAddress'] ?? ''),
          _row('Name of the Owner', shopData['ownerName'] ?? ''),
          _row('Telephone', shopData['telephone'] ?? ''),
        ]),
      ),
    );
  }

  Widget _row(String label, String val) => Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500)),
      const SizedBox(height: 6),
      Text(val,
          style: const TextStyle(fontSize: 18, color: Color(0xFF838383))),
    ]),
  );

  Widget _iconBtn(IconData i, Color c, VoidCallback onTap) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: InkWell(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: c, width: 2),
        ),
        child: Icon(i, color: c, size: 22),
      ),
    ),
  );

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Delete'),
        content:
        const Text('Are you sure you want to delete this shop record?'),
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF1F41BB)),
              onPressed: () async {
                Navigator.pop(ctx);
                await FirebaseFirestore.instance
                    .collection('shops')
                    .doc(shopData['referenceNo'])
                    .delete();
              },
              child: const Text('Yes')),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF1F41BB),
                  side: const BorderSide(color: Color(0xFF1F41BB))),
              onPressed: () => Navigator.pop(ctx),
              child: const Text('No')),
        ],
      ),
    );
  }
}
