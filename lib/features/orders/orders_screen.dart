import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<_Order> _orders = [
    _Order(id: 'SP-24080101', channel: 'Shopee', product: 'iPhone 16 128GB', status: 'รอแพ็ก'),
    _Order(id: 'LZ-88421', channel: 'Lazada', product: 'Samsung S24', status: 'รอแพ็ก'),
    _Order(id: 'SP-24080102', channel: 'Shopee', product: 'iPhone 15 256GB', status: 'กำลังส่ง'),
    _Order(id: 'POS-5521', channel: 'หน้าร้าน', product: 'iPhone 16 Pro', status: 'สำเร็จ'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ออเดอร์'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primary,
          unselectedLabelColor: AppTheme.textMuted,
          indicatorColor: AppTheme.primary,
          tabs: const [
            Tab(text: 'รอแพ็ก'),
            Tab(text: 'กำลังส่ง'),
            Tab(text: 'สำเร็จ'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildList('รอแพ็ก'),
          _buildList('กำลังส่ง'),
          _buildList('สำเร็จ'),
        ],
      ),
    );
  }

  Widget _buildList(String status) {
    final filtered = _orders.where((o) => o.status == status).toList();
    if (filtered.isEmpty) {
      return Center(child: Text('ไม่มีออเดอร์$status', style: TextStyle(color: AppTheme.textMuted)));
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final o = filtered[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(o.channel, style: TextStyle(fontWeight: FontWeight.w600, color: AppTheme.primary, fontSize: 12)),
                  const SizedBox(width: 8),
                  Text(o.id, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                ],
              ),
              const SizedBox(height: 8),
              Text(o.product, style: const TextStyle(fontSize: 15)),
              if (o.status == 'รอแพ็ก') ...[
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 42)),
                  child: const Text('แพ็กเสร็จ'),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _Order {
  final String id, channel, product, status;
  _Order({required this.id, required this.channel, required this.product, required this.status});
}
