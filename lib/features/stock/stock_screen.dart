import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      _Product(name: 'iPhone 16 128GB Black', sku: 'IP16-128-BK', qty: 12, status: 'ปกติ'),
      _Product(name: 'iPhone 16 Pro 256GB', sku: 'IP16P-256-TI', qty: 5, status: 'ปกติ'),
      _Product(name: 'Samsung S24 Ultra', sku: 'S24U-256-GY', qty: 3, status: 'ใกล้เหมด'),
      _Product(name: 'Xiaomi 14 512GB', sku: 'MI14-512-BK', qty: 0, status: 'หมด'),
      _Product(name: 'iPhone 15 256GB Blue', sku: 'IP15-256-BL', qty: 8, status: 'ปกติ'),
      _Product(name: 'OPPO Find X7', sku: 'OPX7-256-BK', qty: 2, status: 'ใกล้เหมด'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('สต็อกสินค้า'),
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ค้นหาสินค้า / SKU / IMEI',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final p = products[index];
                return _StockTile(product: p);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Product {
  final String name;
  final String sku;
  final int qty;
  final String status;
  _Product({required this.name, required this.sku, required this.qty, required this.status});
}

class _StockTile extends StatelessWidget {
  final _Product product;
  const _StockTile({required this.product});

  Color get statusColor {
    switch (product.status) {
      case 'หมด': return AppTheme.danger;
      case 'ใกล้เหมด': return AppTheme.warning;
      default: return AppTheme.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.phone_iphone, color: AppTheme.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(product.sku, style: TextStyle(fontSize: 12, color: AppTheme.textMuted)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${product.qty}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: product.qty == 0 ? AppTheme.danger : AppTheme.text)),
              Text(product.status, style: TextStyle(fontSize: 11, color: statusColor, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}
