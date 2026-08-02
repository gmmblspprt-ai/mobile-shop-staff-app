import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../core/theme/app_theme.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});
  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final MobileScannerController controller = MobileScannerController();
  bool _isProcessing = false;
  final _manualController = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    _manualController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) async {
    if (_isProcessing) return;
    final barcode = capture.barcodes.firstOrNull;
    if (barcode?.rawValue == null) return;
    setState(() => _isProcessing = true);
    await controller.stop();
    if (!mounted) return;
    _showResult(barcode!.rawValue!);
  }

  void _showResult(String imei) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('iPhone 16 Pro 256GB', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('IMEI: $imei', style: TextStyle(color: AppTheme.textMuted)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: AppTheme.success.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
              child: const Text('ในสต็อก', style: TextStyle(color: AppTheme.success, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                controller.start();
                setState(() => _isProcessing = false);
              },
              child: const Text('ขายออก'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                controller.start();
                setState(() => _isProcessing = false);
              },
              child: const Text('ปิด'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('สแกน IMEI'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              alignment: Alignment.center,
              children: [
                MobileScanner(controller: controller, onDetect: _onDetect),
                Container(
                  width: 260, height: 140,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.primaryLight, width: 3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                TextField(
                  controller: _manualController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'หรือพิมพ์ IMEI...',
                    prefixIcon: Icon(Icons.edit_outlined),
                  ),
                  onSubmitted: (v) {
                    if (v.trim().length >= 14) _showResult(v.trim());
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    final v = _manualController.text.trim();
                    if (v.length >= 14) _showResult(v);
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('ค้นหา IMEI'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
