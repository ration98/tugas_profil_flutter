// lib/features/percabangan_page.dart
import 'package:flutter/material.dart';

class PercabanganPage extends StatelessWidget {
  const PercabanganPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fitur Percabangan"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildMenuCard(
              context,
              title: "Nilai Maksimal & Minimal",
              subtitle: "Temukan nilai terbesar dan terkecil dari 2 angka",
              icon: Icons.compare_arrows,
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NilaiMaxMinPage()),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildMenuCard(
              context,
              title: "Diskon Bertingkat (Nested IF)",
              subtitle: "Hitung diskon berdasarkan jumlah pembelian",
              icon: Icons.discount,
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DiskonNestedIfPage()),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildMenuCard(
              context,
              title: "Diskon Switch-Case",
              subtitle: "Hitung diskon menggunakan Switch-Case",
              icon: Icons.switch_account,
              color: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DiskonSwitchCasePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

// ============ NILAI MAKSIMAL & MINIMAL PAGE (IF) ============
class NilaiMaxMinPage extends StatefulWidget {
  const NilaiMaxMinPage({super.key});

  @override
  State<NilaiMaxMinPage> createState() => _NilaiMaxMinPageState();
}

class _NilaiMaxMinPageState extends State<NilaiMaxMinPage> {
  final _bilangan1Controller = TextEditingController();
  final _bilangan2Controller = TextEditingController();
  String _result = '';

  void _calculate() {
    final bil1 = double.tryParse(_bilangan1Controller.text);
    final bil2 = double.tryParse(_bilangan2Controller.text);

    if (bil1 != null && bil2 != null) {
      setState(() {
        if (bil1 > bil2) {
          _result = '''
[ HASIL PERBANDINGAN ]
----------------------------------------
Bilangan 1 : ${bil1.toStringAsFixed(2)}
Bilangan 2 : ${bil2.toStringAsFixed(2)}
----------------------------------------
[ MAX ] : ${bil1.toStringAsFixed(2)}
[ MIN ] : ${bil2.toStringAsFixed(2)}
----------------------------------------
Bilangan 1 LEBIH BESAR dari Bilangan 2
''';
        } else if (bil2 > bil1) {
          _result = '''
[ HASIL PERBANDINGAN ]
----------------------------------------
Bilangan 1 : ${bil1.toStringAsFixed(2)}
Bilangan 2 : ${bil2.toStringAsFixed(2)}
----------------------------------------
[ MAX ] : ${bil2.toStringAsFixed(2)}
[ MIN ] : ${bil1.toStringAsFixed(2)}
----------------------------------------
Bilangan 2 LEBIH BESAR dari Bilangan 1
''';
        } else {
          _result = '''
[ HASIL PERBANDINGAN ]
----------------------------------------
Bilangan 1 : ${bil1.toStringAsFixed(2)}
Bilangan 2 : ${bil2.toStringAsFixed(2)}
----------------------------------------
[ INFO ] KEDUA BILANGAN SAMA BESAR!
Nilai : ${bil1.toStringAsFixed(2)}
----------------------------------------
''';
        }
      });
    } else {
      setState(() {
        _result = '[ ERROR ] Masukkan angka yang valid!';
      });
    }
  }

  void _reset() {
    _bilangan1Controller.clear();
    _bilangan2Controller.clear();
    setState(() {
      _result = '';
    });
  }

  @override
  void dispose() {
    _bilangan1Controller.dispose();
    _bilangan2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nilai Maksimal & Minimal"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reset,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue.shade700),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Masukkan 2 bilangan untuk mengetahui mana yang terbesar dan terkecil',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _bilangan1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Bilangan 1',
                hintText: 'Contoh: 25',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.looks_one),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bilangan2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Bilangan 2',
                hintText: 'Contoh: 10',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.looks_two),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calculate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Hitung', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _reset,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Reset', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (_result.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _result.contains('ERROR') 
                      ? Colors.red.shade50 
                      : _result.contains('SAMA') 
                          ? Colors.amber.shade50 
                          : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _result.contains('ERROR') 
                        ? Colors.red.shade300 
                        : _result.contains('SAMA') 
                            ? Colors.amber.shade300 
                            : Colors.green.shade300,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _result,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      height: 1.8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ============ DISKON NESTED IF PAGE ============
class DiskonNestedIfPage extends StatefulWidget {
  const DiskonNestedIfPage({super.key});

  @override
  State<DiskonNestedIfPage> createState() => _DiskonNestedIfPageState();
}

class _DiskonNestedIfPageState extends State<DiskonNestedIfPage> {
  final _pembelianController = TextEditingController();
  String _result = '';

  void _calculate() {
    final pembelian = double.tryParse(_pembelianController.text);

    if (pembelian != null && pembelian > 0) {
      setState(() {
        double diskonPersen = 0;
        String kategori = '';

        // NESTED IF UNTUK MENENTUKAN DISKON
        if (pembelian >= 1500000) {
          diskonPersen = 0.30;
          kategori = '[PLATINUM] >= Rp 1.500.000';
        } else {
          if (pembelian >= 1000000) {
            diskonPersen = 0.20;
            kategori = '[GOLD] Rp 1.000.000 - Rp 1.499.999';
          } else {
            if (pembelian >= 500000) {
              diskonPersen = 0.10;
              kategori = '[SILVER] Rp 500.000 - Rp 999.999';
            } else {
              diskonPersen = 0.00;
              kategori = '[BRONZE] < Rp 500.000';
            }
          }
        }

        final diskon = pembelian * diskonPersen;
        final totalBayar = pembelian - diskon;

        _result = '''
[ STRUK PEMBELANJAAN - NESTED IF ]
========================================
Total Pembelian : Rp ${_formatRupiah(pembelian)}
Kategori        : $kategori
----------------------------------------
Diskon          : ${(diskonPersen * 100).toStringAsFixed(0)}%
Nilai Diskon    : Rp ${_formatRupiah(diskon)}
----------------------------------------
TOTAL BAYAR     : Rp ${_formatRupiah(totalBayar)}
========================================
''';
      });
    } else {
      setState(() {
        _result = '[ ERROR ] Masukkan jumlah pembelian yang valid (minimal Rp 1)!';
      });
    }
  }

  String _formatRupiah(double value) {
    return value.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]}.',
    );
  }

  void _reset() {
    _pembelianController.clear();
    setState(() {
      _result = '';
    });
  }

  @override
  void dispose() {
    _pembelianController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diskon Bertingkat (Nested IF)"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reset,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Aturan Diskon (Nested IF):',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 6),
                  _buildRuleItem('>= Rp 1.500.000', 'Diskon 30%', Colors.green),
                  _buildRuleItem('Rp 1.000.000 - Rp 1.499.999', 'Diskon 20%', Colors.blue),
                  _buildRuleItem('Rp 500.000 - Rp 999.999', 'Diskon 10%', Colors.amber),
                  _buildRuleItem('< Rp 500.000', 'Diskon 0%', Colors.grey),
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _pembelianController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah Pembelian (Rp)',
                hintText: 'Contoh: 750000',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calculate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Hitung Diskon', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _reset,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Reset', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (_result.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _result.contains('ERROR') 
                      ? Colors.red.shade50 
                      : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _result.contains('ERROR') 
                        ? Colors.red.shade300 
                        : Colors.green.shade300,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _result,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      height: 1.8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRuleItem(String range, String diskon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text('$range -> ', style: const TextStyle(fontSize: 13)),
          Text(
            diskon,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ============ DISKON SWITCH-CASE PAGE ============
class DiskonSwitchCasePage extends StatefulWidget {
  const DiskonSwitchCasePage({super.key});

  @override
  State<DiskonSwitchCasePage> createState() => _DiskonSwitchCasePageState();
}

class _DiskonSwitchCasePageState extends State<DiskonSwitchCasePage> {
  final _pembelianController = TextEditingController();
  String _result = '';

  String _getDiscountLevel(double pembelian) {
    int level;
    if (pembelian >= 1500000) {
      level = 4;
    } else if (pembelian >= 1000000) {
      level = 3;
    } else if (pembelian >= 500000) {
      level = 2;
    } else {
      level = 1;
    }

    switch (level) {
      case 4:
        return 'PLATINUM';
      case 3:
        return 'GOLD';
      case 2:
        return 'SILVER';
      case 1:
        return 'BRONZE';
      default:
        return 'BRONZE';
    }
  }

  double _getDiscountPercentage(String level) {
    switch (level) {
      case 'PLATINUM':
        return 0.30;
      case 'GOLD':
        return 0.20;
      case 'SILVER':
        return 0.10;
      case 'BRONZE':
        return 0.00;
      default:
        return 0.00;
    }
  }

  String _getLevelIcon(String level) {
    switch (level) {
      case 'PLATINUM':
        return '[P]';
      case 'GOLD':
        return '[G]';
      case 'SILVER':
        return '[S]';
      case 'BRONZE':
        return '[B]';
      default:
        return '[-]';
    }
  }

  String _getLevelDescription(String level) {
    switch (level) {
      case 'PLATINUM':
        return '>= Rp 1.500.000';
      case 'GOLD':
        return 'Rp 1.000.000 - Rp 1.499.999';
      case 'SILVER':
        return 'Rp 500.000 - Rp 999.999';
      case 'BRONZE':
        return '< Rp 500.000';
      default:
        return '-';
    }
  }

  void _calculate() {
    final pembelian = double.tryParse(_pembelianController.text);

    if (pembelian != null && pembelian > 0) {
      setState(() {
        final level = _getDiscountLevel(pembelian);
        final diskonPersen = _getDiscountPercentage(level);
        final icon = _getLevelIcon(level);
        final deskripsi = _getLevelDescription(level);
        final diskon = pembelian * diskonPersen;
        final totalBayar = pembelian - diskon;

        _result = '''
[ STRUK PEMBELANJAAN - SWITCH CASE ]
========================================
Total Pembelian : Rp ${_formatRupiah(pembelian)}
Level           : $icon $level
Syarat          : $deskripsi
----------------------------------------
Diskon          : ${(diskonPersen * 100).toStringAsFixed(0)}%
Nilai Diskon    : Rp ${_formatRupiah(diskon)}
----------------------------------------
TOTAL BAYAR     : Rp ${_formatRupiah(totalBayar)}
========================================
''';
      });
    } else {
      setState(() {
        _result = '[ ERROR ] Masukkan jumlah pembelian yang valid (minimal Rp 1)!';
      });
    }
  }

  String _formatRupiah(double value) {
    return value.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]}.',
    );
  }

  void _reset() {
    _pembelianController.clear();
    setState(() {
      _result = '';
    });
  }

  @override
  void dispose() {
    _pembelianController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diskon Switch-Case"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reset,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Level Diskon (Switch-Case):',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 6),
                  _buildLevelItem('[P] PLATINUM', '>= Rp 1.500.000', '30%', Colors.green),
                  _buildLevelItem('[G] GOLD', 'Rp 1.000.000 - Rp 1.499.999', '20%', Colors.blue),
                  _buildLevelItem('[S] SILVER', 'Rp 500.000 - Rp 999.999', '10%', Colors.amber),
                  _buildLevelItem('[B] BRONZE', '< Rp 500.000', '0%', Colors.grey),
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _pembelianController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah Pembelian (Rp)',
                hintText: 'Contoh: 750000',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calculate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Hitung Diskon', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _reset,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Reset', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (_result.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _result.contains('ERROR') 
                      ? Colors.red.shade50 
                      : Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _result.contains('ERROR') 
                        ? Colors.red.shade300 
                        : Colors.purple.shade300,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _result,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      height: 1.8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelItem(String level, String range, String diskon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text('$level : ', style: const TextStyle(fontSize: 13)),
          Text(
            range,
            style: const TextStyle(fontSize: 13),
          ),
          const Spacer(),
          Text(
            diskon,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}