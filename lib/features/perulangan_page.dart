// lib/features/perulangan_page.dart
import 'package:flutter/material.dart';

class PerulanganPage extends StatelessWidget {
  const PerulanganPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fitur Perulangan"),
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
              title: "Bilangan Bulat (FOR)",
              subtitle: "20 bilangan bulat menggunakan FOR",
              icon: Icons.numbers,
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BilanganBulatPage()),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildMenuCard(
              context,
              title: "Bilangan Ganjil (WHILE)",
              subtitle: "20 bilangan ganjil menggunakan WHILE",
              icon: Icons.emergency,
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BilanganGanjilWhilePage()),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildMenuCard(
              context,
              title: "Bilangan Fibonacci (DO-WHILE)",
              subtitle: "20 bilangan Fibonacci menggunakan DO-WHILE",
              icon: Icons.auto_awesome_motion,
              color: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FibonacciDoWhilePage()),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildMenuCard(
              context,
              title: "Bilangan Ganjil (Pilihan)",
              subtitle: "20 bilangan ganjil pilihan user",
              icon: Icons.toggle_on,
              color: Colors.teal,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BilanganGanjilPilihanPage()),
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

// ============ BILANGAN BULAT (FOR) ============
class BilanganBulatPage extends StatefulWidget {
  const BilanganBulatPage({super.key});

  @override
  State<BilanganBulatPage> createState() => _BilanganBulatPageState();
}

class _BilanganBulatPageState extends State<BilanganBulatPage> {
  String _result = '';

  void _calculate() {
    setState(() {
      List<int> numbers = [];
      
      // ===== MENGGUNAKAN FOR UNTUK 20 BILANGAN BULAT =====
      for (int i = 1; i <= 20; i++) {
        numbers.add(i);
      }
      
      _result = '''
[ 20 BILANGAN BULAT - FOR ]
========================================
Urutan ke-1  : 1
Urutan ke-2  : 2
Urutan ke-3  : 3
Urutan ke-4  : 4
Urutan ke-5  : 5
Urutan ke-6  : 6
Urutan ke-7  : 7
Urutan ke-8  : 8
Urutan ke-9  : 9
Urutan ke-10 : 10
Urutan ke-11 : 11
Urutan ke-12 : 12
Urutan ke-13 : 13
Urutan ke-14 : 14
Urutan ke-15 : 15
Urutan ke-16 : 16
Urutan ke-17 : 17
Urutan ke-18 : 18
Urutan ke-19 : 19
Urutan ke-20 : 20
========================================
Total : 20 bilangan bulat
Rentang : 1 - 20
''';
    });
  }

  void _reset() {
    setState(() {
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bilangan Bulat (FOR)"),
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
                      'Menampilkan 20 bilangan bulat menggunakan perulangan FOR',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Klik tombol di bawah untuk menampilkan\n20 bilangan bulat (1 - 20)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Tampilkan 20 Bilangan', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 24),
            if (_result.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade300),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _result,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ============ BILANGAN GANJIL (WHILE) ============
class BilanganGanjilWhilePage extends StatefulWidget {
  const BilanganGanjilWhilePage({super.key});

  @override
  State<BilanganGanjilWhilePage> createState() => _BilanganGanjilWhilePageState();
}

class _BilanganGanjilWhilePageState extends State<BilanganGanjilWhilePage> {
  String _result = '';

  void _calculate() {
    setState(() {
      List<int> numbers = [];
      int counter = 0;
      int number = 1;
      
      // ===== MENGGUNAKAN WHILE UNTUK 20 BILANGAN GANJIL =====
      while (counter < 20) {
        if (number % 2 != 0) {
          numbers.add(number);
          counter++;
        }
        number++;
      }
      
      String numberList = '';
      for (int i = 0; i < numbers.length; i++) {
        numberList += 'Urutan ke-${(i+1).toString().padLeft(2)} : ${numbers[i].toString().padLeft(3)}\n';
      }
      
      _result = '''
[ 20 BILANGAN GANJIL - WHILE ]
========================================
$numberList========================================
Total : 20 bilangan ganjil
Rentang : 1 - ${numbers.last}
''';
    });
  }

  void _reset() {
    setState(() {
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bilangan Ganjil (WHILE)"),
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
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange.shade700),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Menampilkan 20 bilangan ganjil menggunakan perulangan WHILE',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Klik tombol di bawah untuk menampilkan\n20 bilangan ganjil pertama',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Tampilkan 20 Bilangan Ganjil', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 24),
            if (_result.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade300),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _result,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ============ FIBONACCI (DO-WHILE) ============
class FibonacciDoWhilePage extends StatefulWidget {
  const FibonacciDoWhilePage({super.key});

  @override
  State<FibonacciDoWhilePage> createState() => _FibonacciDoWhilePageState();
}

class _FibonacciDoWhilePageState extends State<FibonacciDoWhilePage> {
  String _result = '';

  void _calculate() {
    setState(() {
      List<int> fibonacci = [];
      int a = 0, b = 1;
      int counter = 0;
      
      // ===== MENGGUNAKAN DO-WHILE UNTUK 20 BILANGAN FIBONACCI =====
      do {
        if (counter == 0) {
          fibonacci.add(a);
        } else if (counter == 1) {
          fibonacci.add(b);
        } else {
          int c = a + b;
          fibonacci.add(c);
          a = b;
          b = c;
        }
        counter++;
      } while (counter < 20);
      
      String numberList = '';
      for (int i = 0; i < fibonacci.length; i++) {
        numberList += 'Urutan ke-${(i+1).toString().padLeft(2)} : ${fibonacci[i].toString().padLeft(6)}\n';
      }
      
      _result = '''
[ 20 BILANGAN FIBONACCI - DO-WHILE ]
========================================
$numberList========================================
Total : 20 bilangan Fibonacci
Rumus : F(n) = F(n-1) + F(n-2)
''';
    });
  }

  void _reset() {
    setState(() {
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fibonacci (DO-WHILE)"),
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
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.purple.shade700),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Menampilkan 20 bilangan Fibonacci menggunakan DO-WHILE',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Klik tombol di bawah untuk menampilkan\n20 bilangan Fibonacci pertama',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Tampilkan 20 Fibonacci', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 24),
            if (_result.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple.shade300),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _result,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ============ BILANGAN GANJIL (PILIHAN) ============
class BilanganGanjilPilihanPage extends StatefulWidget {
  const BilanganGanjilPilihanPage({super.key});

  @override
  State<BilanganGanjilPilihanPage> createState() => _BilanganGanjilPilihanPageState();
}

class _BilanganGanjilPilihanPageState extends State<BilanganGanjilPilihanPage> {
  final _startController = TextEditingController();
  String _result = '';

  void _calculate() {
    final start = int.tryParse(_startController.text);

    if (start != null && start > 0) {
      setState(() {
        List<int> numbers = [];
        int counter = 0;
        int number = start;
        
        // ===== MENGGUNAKAN WHILE UNTUK 20 BILANGAN GANJIL DARI ANGKA YANG DIPILIH =====
        while (counter < 20) {
          if (number % 2 != 0) {
            numbers.add(number);
            counter++;
          }
          number++;
        }
        
        String numberList = '';
        for (int i = 0; i < numbers.length; i++) {
          numberList += 'Urutan ke-${(i+1).toString().padLeft(2)} : ${numbers[i].toString().padLeft(4)}\n';
        }
        
        _result = '''
[ 20 BILANGAN GANJIL - PILIHAN ]
========================================
Mulai dari angka : $start
----------------------------------------
$numberList========================================
Total : 20 bilangan ganjil
Rentang : ${numbers.first} - ${numbers.last}
''';
      });
    } else {
      setState(() {
        _result = '[ ERROR ] Masukkan angka awal yang valid (minimal 1)!';
      });
    }
  }

  void _reset() {
    _startController.clear();
    setState(() {
      _result = '';
    });
  }

  @override
  void dispose() {
    _startController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bilangan Ganjil (Pilihan)"),
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
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.teal.shade700),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Masukkan angka awal, sistem akan menampilkan 20 bilangan ganjil berikutnya',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _startController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Angka Awal',
                hintText: 'Contoh: 5',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.start),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Masukkan angka berapa pun,\nsistem akan mencari 20 bilangan ganjil berikutnya',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
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
                    child: const Text('Tampilkan', style: TextStyle(fontSize: 16)),
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
                      : Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _result.contains('ERROR') 
                        ? Colors.red.shade300 
                        : Colors.teal.shade300,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _result,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}