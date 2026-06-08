import 'package:flutter/material.dart';

class SortingPage extends StatefulWidget {
  const SortingPage({super.key});

  @override
  State<SortingPage> createState() => _SortingPageState();
}

class _SortingPageState extends State<SortingPage> {
  final TextEditingController _inputController = TextEditingController();
  List<String> _originalData = [];
  List<String> _sortedData = [];
  String _selectedAlgorithm = 'Bubble Sort';
  bool _isAscending = true;
  bool _hasSorted = false;
  bool _isSorting = false;

  final Map<String, String> _algorithmExplanations = {
    'Bubble Sort': 'Membandingkan dua data yang bersebelahan dan menukarnya jika urutannya salah. Proses ini diulang terus menerus sampai tidak ada lagi data yang perlu ditukar.',
    'Selection Sort': 'Mencari elemen terkecil (atau terbesar) dari data yang belum terurut dan meletakkannya di posisi yang tepat di awal daftar.',
    'Insertion Sort': 'Mengambil satu per satu data dan menyisipkannya ke posisi yang benar dalam daftar data yang sudah terurut, mirip seperti menyusun kartu di tangan.',
    'Merge Sort': 'Membagi daftar menjadi beberapa bagian kecil sampai masing-masing bagian hanya berisi satu data, lalu menggabungkannya kembali secara terurut.',
    'Quick Sort': 'Memilih satu data sebagai "pivot", lalu memindahkan data yang lebih kecil ke kiri pivot dan data yang lebih besar ke kanan pivot secara rekursif.',
  };

  void _sort() {
    String input = _inputController.text.replaceAll(',', ' ');
    List<String> list = input.split(RegExp(r'\s+')).where((s) => s.isNotEmpty).toList();

    if (list.isEmpty || list.length > 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Masukkan 1-10 data!")),
      );
      return;
    }

    setState(() {
      _isSorting = true;
      _originalData = List.from(list);
    });

    List<String> tempList = List.from(list);
    if (_selectedAlgorithm == 'Bubble Sort') _bubbleSort(tempList);
    else if (_selectedAlgorithm == 'Selection Sort') _selectionSort(tempList);
    else if (_selectedAlgorithm == 'Insertion Sort') _insertionSort(tempList);
    else if (_selectedAlgorithm == 'Merge Sort') _runMergeSort(tempList);
    else if (_selectedAlgorithm == 'Quick Sort') _runQuickSort(tempList);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _sortedData = tempList;
          _hasSorted = true;
          _isSorting = false;
        });
      }
    });
  }

  // --- Sorting Algorithms (Logic Tetap) ---
  int _compare(String a, String b) {
    double? numA = double.tryParse(a);
    double? numB = double.tryParse(b);
    if (numA != null && numB != null) return numA.compareTo(numB);
    return a.toLowerCase().compareTo(b.toLowerCase());
  }
  bool _shouldSwap(String a, String b) => _isAscending ? _compare(a, b) > 0 : _compare(a, b) < 0;
  void _bubbleSort(List<String> l) { for (int i = 0; i < l.length-1; i++) for (int j = 0; j < l.length-i-1; j++) if (_shouldSwap(l[j], l[j+1])) { String t = l[j]; l[j]=l[j+1]; l[j+1]=t; } }
  void _selectionSort(List<String> l) { for (int i = 0; i < l.length-1; i++) { int m = i; for (int j = i+1; j < l.length; j++) if (_shouldSwap(l[m], l[j])) m = j; String t = l[m]; l[m]=l[i]; l[i]=t; } }
  void _insertionSort(List<String> l) { for (int i = 1; i < l.length; i++) { String k = l[i]; int j = i-1; while (j >= 0 && _shouldSwap(l[j], k)) { l[j+1]=l[j]; j--; } l[j+1]=k; } }
  void _runMergeSort(List<String> l) { _mS(l, 0, l.length-1); }
  void _mS(List<String> l, int lo, int hi) { if (lo<hi) { int m = (lo+hi)~/2; _mS(l, lo, m); _mS(l, m+1, hi); _merge(l, lo, m, hi); } }
  void _merge(List<String> l, int lo, int m, int hi) {
    int n1 = m-lo+1, n2 = hi-m;
    List<String> L = List.generate(n1, (i)=>l[lo+i]), R = List.generate(n2, (i)=>l[m+1+i]);
    int i=0, j=0, k=lo;
    while(i<n1 && j<n2) if (!_shouldSwap(L[i], R[j])) { l[k]=L[i]; i++; k++; } else { l[k]=R[j]; j++; k++; }
    while(i<n1) { l[k]=L[i]; i++; k++; } while(j<n2) { l[k]=R[j]; j++; k++; }
  }
  void _runQuickSort(List<String> l) { _qS(l, 0, l.length-1); }
  void _qS(List<String> l, int lo, int hi) { if (lo<hi) { int p = _partition(l, lo, hi); _qS(l, lo, p-1); _qS(l, p+1, hi); } }
  int _partition(List<String> l, int lo, int hi) {
    String p = l[hi]; int i = lo-1;
    for(int j=lo; j<hi; j++) if(!_shouldSwap(l[j], p)) { i++; String t=l[i]; l[i]=l[j]; l[j]=t; }
    String t=l[i+1]; l[i+1]=l[hi]; l[hi]=t; return i+1;
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Colors.teal;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Sorting Algoritma"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() { _inputController.clear(); _hasSorted = false; }),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Minimalist (Solid & Readable)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: primaryColor.withOpacity(0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(Icons.sort_by_alpha, size: 50, color: primaryColor),
                    SizedBox(height: 12),
                    Text(
                      "Urutkan Data Alfanumerik",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Masukkan hingga 10 data dipisahkan spasi",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Input Section
            const Text("Input Data", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                hintText: "Contoh: z 10 a 2",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                prefixIcon: const Icon(Icons.edit, color: primaryColor),
              ),
            ),
            const SizedBox(height: 20),

            // Control Section
            const Text("Pengaturan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedAlgorithm,
                        isExpanded: true,
                        items: _algorithmExplanations.keys.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (v) => setState(() => _selectedAlgorithm = v!),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _isAscending = !_isAscending),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: primaryColor.withOpacity(0.3)),
                      ),
                      child: Center(
                        child: Text(
                          _isAscending ? "ASC" : "DESC",
                          style: const TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Button Section
            ElevatedButton(
              onPressed: _isSorting ? null : _sort,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: _isSorting
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Text("URUTKAN SEKARANG", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
            ),
            const SizedBox(height: 30),

            // Result Section (Serupa Polling Bar Style)
            if (_hasSorted) ...[
              const Text("Hasil Pengurutan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              _resultCard("Data Awal", _originalData, Colors.grey),
              const SizedBox(height: 15),
              _resultCard("Hasil $_selectedAlgorithm", _sortedData, primaryColor),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: primaryColor.withOpacity(0.1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, size: 18, color: primaryColor),
                        const SizedBox(width: 8),
                        const Text(
                          "Penjelasan Algoritma:",
                          style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _algorithmExplanations[_selectedAlgorithm] ?? "",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _resultCard(String label, List<String> data, Color color) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: data.map((e) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(e, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
