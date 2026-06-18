import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sorting_page.dart';

void main() => runApp(const GroupProfileApp());

class Member {
  final String name;
  final String nim;
  final String bio;
  final String imagePath;
  final String videoPath;

  Member({
    required this.name,
    required this.nim,
    required this.bio,
    required this.imagePath,
    required this.videoPath,
  });
}

class GroupProfileApp extends StatelessWidget {
  const GroupProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: const MainMenuPage(),
    );
  }
}

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kelompok 8 - Mobile Programming"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Icon(
                  Icons.school,
                  size: 80,
                  color: Colors.green,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Selamat Datang",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Pilih Menu",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),
                _buildMenuCard(
                  context,
                  title: "Profile",
                  subtitle: "Lihat profil anggota kelompok",
                  icon: Icons.people,
                  color: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildMenuCard(
                  context,
                  title: "Kalkulator",
                  subtitle: "Hitung rumus matematika",
                  icon: Icons.calculate,
                  color: Colors.green,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TugasRumusPage()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildMenuCard(
                  context,
                  title: "Polling",
                  subtitle: "Quesioner dan polling hobi olahraga",
                  icon: Icons.poll,
                  color: Colors.orange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PollingMenuPage()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildMenuCard(
                  context,
                  title: "Sorting Algoritma",
                  subtitle: "Urutkan angka dan huruf (Max 10)",
                  icon: Icons.sort,
                  color: Colors.deepPurple,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SortingPage()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                // --- MENU BARU: FITUR ZODIAK ---
                _buildMenuCard(
                  context,
                  title: "Fitur Zodiak",
                  subtitle: "Cek ramalan dan karakteristik zodiakmu",
                  icon: Icons.auto_awesome,
                  color: Colors.pink,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ZodiacPage()),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: color,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Member> members = [
      Member(
        name: "Yefta Kurnia P.",
        nim: "0112524038",
        bio: "Hobi mengeksplorasi alam, mendaki gunung, dan lari pagi.",
        imagePath: "assets/images/Gua.jpg",
        videoPath: "assets/videos/vid_perkenalan.mp4",
      ),
      Member(
        name: "Mirfa Nanda  Syahiratia",
        nim: "0112524018",
        bio: "Hobi bermain musik dan belajar pemrograman mobile.",
        imagePath: "assets/images/mirfa.jpeg",
        videoPath: "assets/videos/vid_mirfa.mp4",
      ),
      Member(
        name: "Adhima Tenripoliwati",
        nim: "0112523002",
        bio: "Berolahraga, membaca buku dan menulis.",
        imagePath: "assets/images/adhimatenri.jpg",
        videoPath: "assets/videos/vid_adhimatenri.mp4",
      ),
      Member(
        name: "Tio Anggie Hizbullah",
        nim: "0112523042",
        bio: "Troubleshooter and troublemaker | You can't grow in a trouble-free environment.",
        imagePath: "assets/images/tio.png",
        videoPath: "assets/videos/vid_tio.mp4",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Anggota Kelompok"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: members.length,
        itemExtent: 100,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(members[index].imagePath),
              ),
              title: Text(
                members[index].name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("NIM: ${members[index].nim}"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProfileDetailPage(member: members[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ProfileDetailPage extends StatelessWidget {
  final Member member;
  const ProfileDetailPage({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profil ${member.name}")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(member.imagePath),
              ),
              const SizedBox(height: 20),
              Text(
                member.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "NIM: ${member.nim}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 20.0,
                ),
                child: Text(
                  member.bio,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VideoPlayerPage(videoPath: member.videoPath),
                    ),
                  );
                },
                icon: const Icon(Icons.play_circle_fill),
                label: const Text("Tonton Video Perkenalan"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerPage extends StatefulWidget {
  final String videoPath;
  const VideoPlayerPage({super.key, required this.videoPath});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Preview Video"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}

class TugasRumusPage extends StatelessWidget {
  const TugasRumusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tugas Rumus"),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildCalculatorCard(
            context,
            "Luas Segitiga",
            Icons.change_history,
            Colors.blue,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LuasSegitigaPage()),
            ),
          ),
          _buildCalculatorCard(
            context,
            "Isi Tabung",
            Icons.circle_outlined,
            Colors.green,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const IsiTabungPage()),
            ),
          ),
          _buildCalculatorCard(
            context,
            "Luas Kotak",
            Icons.square_outlined,
            Colors.orange,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LuasKotakPage()),
            ),
          ),
          _buildCalculatorCard(
            context,
            "Luas Lingkaran",
            Icons.circle,
            Colors.purple,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LuasLingkaranPage()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatorCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LuasSegitigaPage extends StatefulWidget {
  const LuasSegitigaPage({super.key});

  @override
  State<LuasSegitigaPage> createState() => _LuasSegitigaPageState();
}

class _LuasSegitigaPageState extends State<LuasSegitigaPage> {
  final _alasController = TextEditingController();
  final _tinggiController = TextEditingController();
  String _result = '';

  void _calculate() {
    final alas = double.tryParse(_alasController.text);
    final tinggi = double.tryParse(_tinggiController.text);

    if (alas != null && tinggi != null && alas > 0 && tinggi > 0) {
      final luas = 0.5 * alas * tinggi;
      setState(() {
        _result = 'Luas Segitiga: ${luas.toStringAsFixed(2)} cm²';
      });
    } else {
      setState(() {
        _result = 'Masukkan nilai yang valid';
      });
    }
  }

  @override
  void dispose() {
    _alasController.dispose();
    _tinggiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hitung Luas Segitiga")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Rumus: ½ × alas × tinggi',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _alasController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Alas (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tinggiController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tinggi (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Hitung'),
            ),
            const SizedBox(height: 24),
            Text(
              _result,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class IsiTabungPage extends StatefulWidget {
  const IsiTabungPage({super.key});

  @override
  State<IsiTabungPage> createState() => _IsiTabungPageState();
}

class _IsiTabungPageState extends State<IsiTabungPage> {
  final _jariJariController = TextEditingController();
  final _tinggiController = TextEditingController();
  String _result = '';

  void _calculate() {
    final r = double.tryParse(_jariJariController.text);
    final t = double.tryParse(_tinggiController.text);

    if (r != null && t != null && r > 0 && t > 0) {
      final volume = 3.14159 * r * r * t;
      setState(() {
        _result = 'Volume Tabung: ${volume.toStringAsFixed(2)} cm³';
      });
    } else {
      setState(() {
        _result = 'Masukkan nilai yang valid';
      });
    }
  }

  @override
  void dispose() {
    _jariJariController.dispose();
    _tinggiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hitung Isi Tabung")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Rumus: π × r² × tinggi',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _jariJariController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jari-jari (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tinggiController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tinggi (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Hitung'),
            ),
            const SizedBox(height: 24),
            Text(
              _result,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class LuasKotakPage extends StatefulWidget {
  const LuasKotakPage({super.key});

  @override
  State<LuasKotakPage> createState() => _LuasKotakPageState();
}

class _LuasKotakPageState extends State<LuasKotakPage> {
  final _sisiController = TextEditingController();
  String _result = '';

  void _calculate() {
    final sisi = double.tryParse(_sisiController.text);

    if (sisi != null && sisi > 0) {
      final luas = sisi * sisi;
      setState(() {
        _result = 'Luas Persegi: ${luas.toStringAsFixed(2)} cm²';
      });
    } else {
      setState(() {
        _result = 'Masukkan nilai yang valid';
      });
    }
  }

  @override
  void dispose() {
    _sisiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hitung Luas Kotak")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Rumus: sisi × sisi',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _sisiController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Sisi (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Hitung'),
            ),
            const SizedBox(height: 24),
            Text(
              _result,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class LuasLingkaranPage extends StatefulWidget {
  const LuasLingkaranPage({super.key});

  @override
  State<LuasLingkaranPage> createState() => _LuasLingkaranPageState();
}

class _LuasLingkaranPageState extends State<LuasLingkaranPage> {
  final _jariJariController = TextEditingController();
  String _result = '';

  void _calculate() {
    final r = double.tryParse(_jariJariController.text);

    if (r != null && r > 0) {
      final luas = 3.14159 * r * r;
      setState(() {
        _result = 'Luas Lingkaran: ${luas.toStringAsFixed(2)} cm²';
      });
    } else {
      setState(() {
        _result = 'Masukkan nilai yang valid';
      });
    }
  }

  @override
  void dispose() {
    _jariJariController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hitung Luas Lingkaran")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Rumus: π × r²',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _jariJariController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jari-jari (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Hitung'),
            ),
            const SizedBox(height: 24),
            Text(
              _result,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class PollingMenuPage extends StatelessWidget {
  const PollingMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Polling Menu"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.poll,
              size: 80,
              color: Colors.orange,
            ),
            const SizedBox(height: 40),
            _buildSubmenuCard(
              context,
              title: "Quesioner",
              subtitle: "Kuis dengan pilihan jawaban",
              icon: Icons.quiz,
              color: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuestionerPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildSubmenuCard(
              context,
              title: "Polling Hobi Olahraga",
              subtitle: "Vote hobi olahraga favorit",
              icon: Icons.sports_soccer,
              color: Colors.teal,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PollingPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmenuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: color,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionerPage extends StatefulWidget {
  const QuestionerPage({super.key});

  @override
  State<QuestionerPage> createState() => _QuestionerPageState();
}

class _QuestionerPageState extends State<QuestionerPage> {
  int? _selectedSingleAnswer;
  Set<int> _selectedMultipleAnswers = {};
  bool _showSingleResult = false;
  bool _showMultipleResult = false;

  final int _correctSingleAnswer = 2;
  final Set<int> _correctMultipleAnswers = {1, 3};

  void _checkSingleAnswer() {
    if (_selectedSingleAnswer != null) {
      setState(() {
        _showSingleResult = true;
      });
    }
  }

  void _checkMultipleAnswers() {
    if (_selectedMultipleAnswers.isNotEmpty) {
      setState(() {
        _showMultipleResult = true;
      });
    }
  }

  void _resetQuiz() {
    setState(() {
      _selectedSingleAnswer = null;
      _selectedMultipleAnswers = {};
      _showSingleResult = false;
      _showMultipleResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quesioner"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetQuiz,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Pertanyaan 1 (Pilih Satu)",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Apa bahasa pemrograman yang digunakan Flutter?",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    _buildSingleChoiceOption(0, "Java"),
                    _buildSingleChoiceOption(1, "Python"),
                    _buildSingleChoiceOption(2, "Dart"),
                    _buildSingleChoiceOption(3, "JavaScript"),
                    _buildSingleChoiceOption(4, "Kotlin"),
                    const SizedBox(height: 20),
                    ButtonTheme(
                      alignedDropdown: true,
                      child: ElevatedButton(
                        onPressed: _selectedSingleAnswer == null ? null : _checkSingleAnswer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Cek Jawaban"),
                      ),
                    ),
                    if (_showSingleResult) ...[
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _selectedSingleAnswer == _correctSingleAnswer
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _selectedSingleAnswer == _correctSingleAnswer
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: _selectedSingleAnswer == _correctSingleAnswer
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                _selectedSingleAnswer == _correctSingleAnswer
                                    ? "Benar! Jawabannya adalah Dart"
                                    : "Salah! Jawaban yang benar adalah: Dart",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _selectedSingleAnswer == _correctSingleAnswer
                                      ? Colors.green.shade900
                                      : Colors.red.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Pertanyaan 2 (Pilih Lebih dari Satu)",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Widget mana yang termasuk Stateless Widget?",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    _buildMultipleChoiceOption(0, "TextField"),
                    _buildMultipleChoiceOption(1, "Text"),
                    _buildMultipleChoiceOption(2, "Checkbox"),
                    _buildMultipleChoiceOption(3, "Icon"),
                    _buildMultipleChoiceOption(4, "Slider"),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _selectedMultipleAnswers.isEmpty ? null : _checkMultipleAnswers,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Cek Jawaban"),
                    ),
                    if (_showMultipleResult) ...[
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _selectedMultipleAnswers.containsAll(_correctMultipleAnswers) &&
                                  _correctMultipleAnswers.containsAll(_selectedMultipleAnswers)
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _selectedMultipleAnswers.containsAll(_correctMultipleAnswers) &&
                                      _correctMultipleAnswers.containsAll(_selectedMultipleAnswers)
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: _selectedMultipleAnswers.containsAll(_correctMultipleAnswers) &&
                                      _correctMultipleAnswers.containsAll(_selectedMultipleAnswers)
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                _selectedMultipleAnswers.containsAll(_correctMultipleAnswers) &&
                                        _correctMultipleAnswers.containsAll(_selectedMultipleAnswers)
                                    ? "Benar! Jawabannya adalah Text dan Icon"
                                    : "Salah! Jawaban yang benar adalah: Text dan Icon",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _selectedMultipleAnswers.containsAll(_correctMultipleAnswers) &&
                                          _correctMultipleAnswers.containsAll(_selectedMultipleAnswers)
                                      ? Colors.green.shade900
                                      : Colors.red.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleChoiceOption(int index, String text) {
    return RadioListTile<int>(
      title: Text(text),
      value: index,
      groupValue: _selectedSingleAnswer,
      onChanged: _showSingleResult
          ? null
          : (value) {
              setState(() {
                _selectedSingleAnswer = value;
              });
            },
      activeColor: Colors.purple,
    );
  }

  Widget _buildMultipleChoiceOption(int index, String text) {
    return CheckboxListTile(
      title: Text(text),
      value: _selectedMultipleAnswers.contains(index),
      onChanged: _showMultipleResult
          ? null
          : (bool? value) {
              setState(() {
                if (value == true) {
                  _selectedMultipleAnswers.add(index);
                } else {
                  _selectedMultipleAnswers.remove(index);
                }
              });
            },
      activeColor: Colors.teal,
    );
  }
}

class PollingPage extends StatefulWidget {
  const PollingPage({super.key});

  @override
  State<PollingPage> createState() => _PollingPageState();
}

class _PollingPageState extends State<PollingPage> {
  final Map<String, int> _votes = {
    'Badminton': 0,
    'Catur': 0,
    'Padel': 0,
    'Basket': 0,
    'Lari Marathon': 0,
  };

  String? _selectedSport;
  bool _hasVoted = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVotes();
  }

  Future<void> _loadVotes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _votes['Badminton'] = prefs.getInt('vote_badminton') ?? 0;
      _votes['Catur'] = prefs.getInt('vote_catur') ?? 0;
      _votes['Padel'] = prefs.getInt('vote_padel') ?? 0;
      _votes['Basket'] = prefs.getInt('vote_basket') ?? 0;
      _votes['Lari Marathon'] = prefs.getInt('vote_lari_marathon') ?? 0;
      _hasVoted = prefs.getBool('has_voted') ?? false;
      _selectedSport = prefs.getString('selected_sport');
      _isLoading = false;
    });
  }

  Future<void> _saveVotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('vote_badminton', _votes['Badminton']!);
    await prefs.setInt('vote_catur', _votes['Catur']!);
    await prefs.setInt('vote_padel', _votes['Padel']!);
    await prefs.setInt('vote_basket', _votes['Basket']!);
    await prefs.setInt('vote_lari_marathon', _votes['Lari Marathon']!);
    await prefs.setBool('has_voted', _hasVoted);
    if (_selectedSport != null) {
      await prefs.setString('selected_sport', _selectedSport!);
    }
  }

  void _submitVote() {
    if (_selectedSport != null) {
      setState(() {
        _votes[_selectedSport!] = _votes[_selectedSport!]! + 1;
        _hasVoted = true;
      });
      _saveVotes();
    }
  }

  Future<void> _resetPolling() async {
    setState(() {
      _votes.updateAll((key, value) => 0);
      _selectedSport = null;
      _hasVoted = false;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  int get _totalVotes => _votes.values.fold(0, (sum, votes) => sum + votes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Polling Hobi Olahraga"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetPolling,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 3,
                    color: Colors.teal.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.sports,
                            size: 60,
                            color: Colors.teal,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Apa hobi olahraga favorit Anda?",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Total Votes: $_totalVotes",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (!_hasVoted) ...[
                    const Text(
                      "Pilih olahraga favorit Anda:",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    ..._votes.keys.map((sport) => _buildSportOption(sport)),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _selectedSport == null ? null : _submitVote,
                      icon: const Icon(Icons.how_to_vote),
                      label: const Text("Submit Vote"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ] else ...[
                    const Text(
                      "Hasil Polling:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    ..._votes.entries.map((entry) => _buildResultBar(entry.key, entry.value)),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Terima kasih! Vote Anda untuk $_selectedSport telah tercatat.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade900,
                              ),
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

  Widget _buildSportOption(String sport) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: RadioListTile<String>(
        title: Text(
          sport,
          style: const TextStyle(fontSize: 16),
        ),
        value: sport,
        groupValue: _selectedSport,
        onChanged: (value) {
          setState(() {
            _selectedSport = value;
          });
        },
        activeColor: Colors.teal,
      ),
    );
  }

  Widget _buildResultBar(String sport, int votes) {
    final percentage = _totalVotes > 0 ? (votes / _totalVotes * 100) : 0.0;
    final isWinner = votes > 0 && votes == _votes.values.reduce((a, b) => a > b ? a : b);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      sport,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isWinner ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (isWinner) ...[
                      const SizedBox(width: 5),
                      const Icon(Icons.emoji_events, color: Colors.amber, size: 20),
                    ],
                  ],
                ),
                Text(
                  "$votes votes (${percentage.toStringAsFixed(1)}%)",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: _totalVotes > 0 ? votes / _totalVotes : 0,
                minHeight: 10,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isWinner ? Colors.amber : Colors.teal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== FITUR BARU: ZODIAK ====================
class ZodiacPage extends StatefulWidget {
  const ZodiacPage({super.key});

  @override
  State<ZodiacPage> createState() => _ZodiacPageState();
}

class _ZodiacPageState extends State<ZodiacPage> {
  DateTime? _selectedDate;
  String _zodiacName = '';
  IconData _zodiacIcon = Icons.auto_awesome; // Menggunakan IconData standar Flutter
  Color _zodiacColor = Colors.grey;
  String _zodiacCharacteristics = 'Ketuk tombol di atas untuk memilih tanggal lahirmu. Mari kita lihat kisah dan rahasia yang tersimpan di balik zodiakmu!';

  void _calculateZodiac(DateTime date) {
    int day = date.day;
    int month = date.month;
    String name = '';
    IconData icon = Icons.auto_awesome;
    Color color = Colors.green;
    String info = '';

    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) {
      name = 'Aries';
      icon = Icons.local_fire_department;
      color = Colors.redAccent;
      info = 'Sebagai seorang Aries, kamu dilahirkan dengan jiwa pemimpin sejati yang penuh energi. Kamu adalah pribadi yang pemberani, kompetitif, dan selalu bersemangat menghadapi tantangan baru. Kemandirianmu yang kuat membuatmu tidak takut melangkah sendirian demi meraih impian.';
    } else if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
      name = 'Taurus';
      icon = Icons.nature_people;
      color = Colors.teal;
      info = 'Sebagai seorang Taurus, kamu adalah definisi dari kesetiaan dan stabilitas. Kamu dikenal sebagai pribadi yang bisa diandalkan, sangat sabar, dan memiliki tekad sekuat baja. Meskipun terkadang dinilai keras kepala, itu sebenarnya adalah wujud dari konsistensimu dalam mempertahankan prinsip hidup.';
    } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
      name = 'Gemini';
      icon = Icons.sms;
      color = Colors.cyan;
      info = 'Sebagai seorang Gemini, kamu memiliki kecerdasan sosial yang luar biasa dan pemikiran yang sangat dinamis. Kamu adalah pribadi yang komunikatif, ekspresif, dan sangat mudah beradaptasi dengan lingkungan baru. Rasa ingin tahumu yang tinggi membuatmu selalu menyenangkan untuk diajak bertukar cerita.';
    } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
      name = 'Cancer';
      icon = Icons.favorite;
      color = Colors.pinkAccent;
      info = 'Sebagai seorang Cancer, kamu dianugerahi hati yang sangat lembut dan intuisi yang mendalam. Kamu adalah pribadi yang penyayang, penuh empati, dan protektif terhadap orang-orang terdekatmu. Bagimu, kenyamanan keluarga dan sahabat adalah segalanya dalam hidup.';
    } else if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
      name = 'Leo';
      icon = Icons.wb_sunny;
      color = Colors.orangeAccent;
      info = 'Sebagai seorang Leo, kamu memancarkan aura kepercayaan diri dan kehangatan yang memikat. Kamu terlahir sebagai sosok yang murah hati, setia kawan, dan berjiwa pemimpin tinggi. Kehadiranmu sering kali menjadi pusat perhatian karena sifatmu yang ceria dan penuh karisma.';
    } else if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
      name = 'Virgo';
      icon = Icons.assignment_turned_in;
      color = Colors.teal;
      info = 'Sebagai seorang Virgo, kamu adalah pribadi yang sangat detail-oriented, analitis, dan terstruktur. Kamu dikenal sebagai pekerja keras yang praktis dan selalu mengutamakan kesempurnaan dalam setiap hal yang kamu lakukan. Ketulusanmu menolong sesama membuatmu menjadi sahabat yang sangat berharga.';
    } else if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
      name = 'Libra';
      icon = Icons.balance;
      color = Colors.indigoAccent;
      info = 'Sebagai seorang Libra, hidupmu berpusat pada harmoni, kedamaian, dan keadilan. Kamu adalah sosok yang diplomatis, artistik, dan selalu berusaha melihat segala sesuatu dari sudut pandang yang objektif. Pesona alamimu membuat orang lain merasa nyaman berada di dekatmu.';
    } else if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) {
      name = 'Scorpio';
      icon = Icons.psychology;
      color = Colors.purpleAccent;
      info = 'Sebagai seorang Scorpio, kamu menyimpan kekuatan emosional dan daya tarik yang sangat misterius. Kamu adalah pribadi yang penuh fokus, bertekad kuat, dan memiliki intuisi yang tajam. Di balik pembawaanmu yang tenang dan penuh rahasia, kamu adalah tipe pejuang yang enggan menyerah.';
    } else if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) {
      name = 'Sagittarius';
      icon = Icons.explore;
      color = Colors.amber;
      info = 'Sebagai seorang Sagittarius, kamu adalah sang petualang sejati yang mencintai kebebasan. Jiwamu penuh dengan optimisme, humor yang menghibur, dan pandangan hidup yang filosofis. Kamu selalu haus akan pengetahuan baru dan sangat menikmati setiap perjalanan hidup.';
    } else if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) {
      name = 'Capricorn';
      icon = Icons.trending_up;
      color = Colors.blueGrey;
      info = 'Sebagai seorang Capricorn, kamu adalah fondasi ketangguhan yang luar biasa. Kamu dikenal sangat disiplin, bertanggung jawab, bijaksana, dan penuh ambisi. Bagimu, kesuksesan diraih lewat kerja keras yang konsisten dan perencanaan masa depan yang matang.';
    } else if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
      name = 'Aquarius';
      icon = Icons.lightbulb;
      color = Colors.blueAccent;
      info = 'Sebagai seorang Aquarius, kamu adalah pemikir bebas yang visioner dan penuh inovasi. Kamu berjiwa humanis, mandiri, dan sering kali memiliki sudut pandang yang unik serta out-of-the-box. Kamu sangat peduli pada perubahan sosial dan kemajuan masa depan.';
    } else if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
      name = 'Pisces';
      icon = Icons.water;
      color = Colors.lightBlueAccent;
      info = 'Sebagai seorang Pisces, jiwamu dipenuhi oleh imajinasi kreatif dan kepekaan seni yang tinggi. Kamu adalah pribadi yang sangat tulus, penuh empati, dan penyayang. Kedalaman perasaanmu membuatmu mampu memahami dan terhubung dengan hati orang lain secara mendalam.';
    }

    setState(() {
      _selectedDate = date;
      _zodiacName = name;
      _zodiacIcon = icon;
      _zodiacColor = color;
      _zodiacCharacteristics = info;
    });
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green, // Menyelaraskan dengan tema utama aplikasi kelompok
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _calculateZodiac(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitur Zodiak'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              // Tombol Pemilih Tanggal yang Dipercantik
              ElevatedButton.icon(
                onPressed: () => _pickDate(context),
                icon: const Icon(Icons.calendar_month, color: Colors.green),
                label: Text(
                  _selectedDate == null
                      ? 'Pilih Tanggal Lahir Kamu'
                      : 'Tanggal Lahir: ${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  backgroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.green.withOpacity(0.3), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              
              // Card Hasil Karakteristik dengan Tampilan Elegan
              Card(
                elevation: 6,
                shadowColor: _zodiacColor.withOpacity(0.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        _zodiacColor.withOpacity(0.05),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Lingkaran Ikon Zodiak Modern
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _zodiacColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _zodiacIcon,
                          size: 65,
                          color: _zodiacColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Nama Zodiak
                      Text(
                        _zodiacName.isEmpty ? 'Kisah Zodiakmu' : _zodiacName,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: _zodiacName.isEmpty ? Colors.grey : _zodiacColor,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (_zodiacName.isNotEmpty)
                        Container(
                          width: 60,
                          height: 3,
                          decoration: BoxDecoration(
                            color: _zodiacColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      const SizedBox(height: 20),
                      // Deskripsi Bergaya Cerita/Narasi
                      Text(
                        _zodiacCharacteristics,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.5,
                          color: Colors.black87,
                          height: 1.6, // Mengatur line spacing agar nyaman dibaca seperti cerita
                          fontStyle: _zodiacName.isEmpty ? FontStyle.italic : FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}