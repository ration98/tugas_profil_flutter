// main.dart - FULL VERSION WITH LOGIN SSO
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ===== IMPORT SCREENS =====
import 'screens/login_page.dart';
import 'screens/main_menu_page.dart';

// ===== IMPORT MODELS =====
import 'models/user_model.dart';


void main() => runApp(const GroupProfileApp());

// ============ MODEL MEMBER ============
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

// ============ MAIN APP ============
class GroupProfileApp extends StatelessWidget {
  const GroupProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kelompok 8 - Mobile Programming',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF00BFFF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF00BFFF),
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      // ✅ INI YANG DIUBAH: Login sebagai halaman awal
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
      },
      onGenerateRoute: (settings) {
        // Handle passing user data ke MainMenuPage
        if (settings.name == '/main' && settings.arguments != null) {
          return MaterialPageRoute(
            builder: (context) => MainMenuPage(
              user: settings.arguments as User,
            ),
          );
        }
        return null;
      },
    );
  }
}

// ============ HOMEPAGE (Profile Anggota) ============
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
        name: "Mirfa Nanda Syahiratia",
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
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage(members[index].imagePath),
              ),
              title: Text(
                members[index].name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                "NIM: ${members[index].nim}",
                style: const TextStyle(fontSize: 14),
              ),
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

// ============ PROFILE DETAIL PAGE ============
class ProfileDetailPage extends StatelessWidget {
  final Member member;
  const ProfileDetailPage({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil ${member.name}"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
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
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 20.0,
                ),
                child: Text(
                  member.bio,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
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
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
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

// ============ VIDEO PLAYER PAGE ============
class VideoPlayerPage extends StatefulWidget {
  final String videoPath;
  const VideoPlayerPage({super.key, required this.videoPath});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
      }).catchError((error) {
        debugPrint('Error loading video: $error');
        setState(() {
          _isInitialized = false;
        });
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
        elevation: 0,
      ),
      body: Center(
        child: _isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(
                    "Memuat video...",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isInitialized
            ? () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              }
            : null,
        backgroundColor: Colors.green,
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }
}

// ============ TUGAS RUMUS PAGE ============
class TugasRumusPage extends StatelessWidget {
  const TugasRumusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tugas Rumus"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
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

// ============ LUAS SEGITIGA PAGE ============
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
      appBar: AppBar(
        title: const Text("Hitung Luas Segitiga"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
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

// ============ ISI TABUNG PAGE ============
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
      appBar: AppBar(
        title: const Text("Hitung Isi Tabung"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
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

// ============ LUAS KOTAK PAGE ============
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
      appBar: AppBar(
        title: const Text("Hitung Luas Kotak"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
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

// ============ LUAS LINGKARAN PAGE ============
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
      appBar: AppBar(
        title: const Text("Hitung Luas Lingkaran"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
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

// ============ POLLING MENU PAGE ============
class PollingMenuPage extends StatelessWidget {
  const PollingMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Polling Menu"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
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
                  color: color.withValues(alpha:0.1),
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

// ============ QUESTIONER PAGE ============
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
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
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
                    ElevatedButton(
                      onPressed: _selectedSingleAnswer == null ? null : _checkSingleAnswer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Cek Jawaban"),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
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

// ============ POLLING PAGE ============
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
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
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

// ============ ZODIAC PAGE ============
class ZodiacPage extends StatefulWidget {
  const ZodiacPage({super.key});

  @override
  State<ZodiacPage> createState() => _ZodiacPageState();
}

class _ZodiacPageState extends State<ZodiacPage> {
  DateTime? _selectedDate;
  String _zodiacName = '';
  IconData _zodiacIcon = Icons.auto_awesome;
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
      info = 'Sebagai seorang Aries, kamu dilahirkan dengan jiwa pemimpin sejati yang penuh energi. Kamu adalah pribadi yang pemberani, kompetitif, dan selalu bersemangat menghadapi tantangan baru.';
    } else if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
      name = 'Taurus';
      icon = Icons.nature_people;
      color = Colors.teal;
      info = 'Sebagai seorang Taurus, kamu adalah definisi dari kesetiaan dan stabilitas. Kamu dikenal sebagai pribadi yang bisa diandalkan, sangat sabar, dan memiliki tekad sekuat baja.';
    } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
      name = 'Gemini';
      icon = Icons.sms;
      color = Colors.cyan;
      info = 'Sebagai seorang Gemini, kamu memiliki kecerdasan sosial yang luar biasa dan pemikiran yang sangat dinamis. Kamu adalah pribadi yang komunikatif dan mudah beradaptasi.';
    } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
      name = 'Cancer';
      icon = Icons.favorite;
      color = Colors.pinkAccent;
      info = 'Sebagai seorang Cancer, kamu dianugerahi hati yang sangat lembut dan intuisi yang mendalam. Kamu adalah pribadi yang penyayang, penuh empati, dan protektif.';
    } else if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
      name = 'Leo';
      icon = Icons.wb_sunny;
      color = Colors.orangeAccent;
      info = 'Sebagai seorang Leo, kamu memancarkan aura kepercayaan diri dan kehangatan yang memikat. Kamu terlahir sebagai sosok yang murah hati, setia kawan, dan berjiwa pemimpin.';
    } else if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
      name = 'Virgo';
      icon = Icons.assignment_turned_in;
      color = Colors.teal;
      info = 'Sebagai seorang Virgo, kamu adalah pribadi yang detail-oriented, analitis, dan terstruktur. Kamu dikenal sebagai pekerja keras yang praktis dan selalu mengutamakan kesempurnaan.';
    } else if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
      name = 'Libra';
      icon = Icons.balance;
      color = Colors.indigoAccent;
      info = 'Sebagai seorang Libra, hidupmu berpusat pada harmoni, kedamaian, dan keadilan. Kamu adalah sosok yang diplomatis, artistik, dan selalu berusaha melihat segala sesuatu secara objektif.';
    } else if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) {
      name = 'Scorpio';
      icon = Icons.psychology;
      color = Colors.purpleAccent;
      info = 'Sebagai seorang Scorpio, kamu menyimpan kekuatan emosional dan daya tarik yang misterius. Kamu adalah pribadi yang fokus, bertekad kuat, dan memiliki intuisi tajam.';
    } else if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) {
      name = 'Sagittarius';
      icon = Icons.explore;
      color = Colors.amber;
      info = 'Sebagai seorang Sagittarius, kamu adalah sang petualang sejati yang mencintai kebebasan. Jiwamu penuh optimisme, humor, dan pandangan hidup yang filosofis.';
    } else if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) {
      name = 'Capricorn';
      icon = Icons.trending_up;
      color = Colors.blueGrey;
      info = 'Sebagai seorang Capricorn, kamu adalah fondasi ketangguhan yang luar biasa. Kamu dikenal sangat disiplin, bertanggung jawab, bijaksana, dan penuh ambisi.';
    } else if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
      name = 'Aquarius';
      icon = Icons.lightbulb;
      color = Colors.blueAccent;
      info = 'Sebagai seorang Aquarius, kamu adalah pemikir bebas yang visioner dan penuh inovasi. Kamu berjiwa humanis, mandiri, dan memiliki sudut pandang yang unik.';
    } else if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
      name = 'Pisces';
      icon = Icons.water;
      color = Colors.lightBlueAccent;
      info = 'Sebagai seorang Pisces, jiwamu dipenuhi oleh imajinasi kreatif dan kepekaan seni yang tinggi. Kamu adalah pribadi yang tulus, penuh empati, dan penyayang.';
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
              primary: Colors.green,
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
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => _pickDate(context),
                icon: const Icon(Icons.calendar_month, color: Colors.green),
                label: Text(
                  _selectedDate == null
                      ? 'Pilih Tanggal Lahir Kamu'
                      : 'Tanggal Lahir: ${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  backgroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.green.withValues(alpha:0.1), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Card(
                elevation: 6,
                shadowColor: _zodiacColor.withValues(alpha:0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        _zodiacColor.withValues(alpha:0.1),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _zodiacColor.withValues(alpha:0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _zodiacIcon,
                          size: 65,
                          color: _zodiacColor,
                        ),
                      ),
                      const SizedBox(height: 16),
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
                      Text(
                        _zodiacCharacteristics,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.5,
                          color: Colors.black87,
                          height: 1.6,
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

// ============ FITUR PENCABANGAN PAGE ============
class FiturPencabanganPage extends StatelessWidget {
  const FiturPencabanganPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fitur Pencabangan"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
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
              title: "Diskon Bertingkat",
              subtitle: "Hitung diskon berdasarkan jumlah pembelian (Nested IF)",
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
                  color: color.withValues(alpha:0.15),
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
        // Menggunakan IF untuk menentukan maksimal dan minimal
        if (bil1 > bil2) {
          _result = '''
═══════════════════════════════
📊 HASIL PERBANDINGAN
═══════════════════════════════
Bilangan 1: ${bil1.toStringAsFixed(2)}
Bilangan 2: ${bil2.toStringAsFixed(2)}
───────────────────────────────
✅ NILAI MAKSIMAL: ${bil1.toStringAsFixed(2)}
📉 NILAI MINIMAL : ${bil2.toStringAsFixed(2)}
═══════════════════════════════
Bilangan 1 LEBIH BESAR dari Bilangan 2
''';
        } else if (bil2 > bil1) {
          _result = '''
═══════════════════════════════
📊 HASIL PERBANDINGAN
═══════════════════════════════
Bilangan 1: ${bil1.toStringAsFixed(2)}
Bilangan 2: ${bil2.toStringAsFixed(2)}
───────────────────────────────
✅ NILAI MAKSIMAL: ${bil2.toStringAsFixed(2)}
📉 NILAI MINIMAL : ${bil1.toStringAsFixed(2)}
═══════════════════════════════
Bilangan 2 LEBIH BESAR dari Bilangan 1
''';
        } else {
          _result = '''
═══════════════════════════════
📊 HASIL PERBANDINGAN
═══════════════════════════════
Bilangan 1: ${bil1.toStringAsFixed(2)}
Bilangan 2: ${bil2.toStringAsFixed(2)}
───────────────────────────────
⚠️ KEDUA BILANGAN SAMA BESAR!
Nilai: ${bil1.toStringAsFixed(2)}
═══════════════════════════════
''';
        }
      });
    } else {
      setState(() {
        _result = '⚠️ Masukkan angka yang valid!';
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
      body: Padding(
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
                  color: _result.contains('⚠️') 
                      ? Colors.red.shade50 
                      : _result.contains('SAMA') 
                          ? Colors.amber.shade50 
                          : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _result.contains('⚠️') 
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
                      height: 1.6,
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
        double diskon = 0;
        double diskonPersen = 0;
        String kategori = '';

        // ===== NESTED IF UNTUK MENENTUKAN DISKON =====
        if (pembelian >= 1500000) {
          diskonPersen = 0.30;
          kategori = '🏆 Platinum (≥ Rp 1.500.000)';
        } else {
          if (pembelian >= 1000000) {
            diskonPersen = 0.20;
            kategori = '🥇 Gold (Rp 1.000.000 - Rp 1.499.999)';
          } else {
            if (pembelian >= 500000) {
              diskonPersen = 0.10;
              kategori = '🥈 Silver (Rp 500.000 - Rp 999.999)';
            } else {
              diskonPersen = 0.00;
              kategori = '🥉 Bronze (< Rp 500.000)';
            }
          }
        }

        diskon = pembelian * diskonPersen;
        final totalBayar = pembelian - diskon;

        _result = '''
═══════════════════════════════════════
        📋 STRUK PEMBELANJAAN
═══════════════════════════════════════
💰 Total Pembelian : Rp ${_formatRupiah(pembelian)}
🏷️  Kategori        : $kategori
───────────────────────────────────────
🎯 Diskon          : ${(diskonPersen * 100).toStringAsFixed(0)}%
💸 Nilai Diskon    : Rp ${_formatRupiah(diskon)}
───────────────────────────────────────
✅ TOTAL BAYAR     : Rp ${_formatRupiah(totalBayar)}
═══════════════════════════════════════
''';
      });
    } else {
      setState(() {
        _result = '⚠️ Masukkan jumlah pembelian yang valid (minimal Rp 1)!';
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
      body: Padding(
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
                    '📌 Aturan Diskon (Nested IF):',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 6),
                  _buildRuleItem('≥ Rp 1.500.000', 'Diskon 30%', Colors.green),
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
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _result.contains('⚠️') 
                          ? Colors.red.shade50 
                          : Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _result.contains('⚠️') 
                            ? Colors.red.shade300 
                            : Colors.green.shade300,
                      ),
                    ),
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
          Text('$range → ', style: const TextStyle(fontSize: 13)),
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

  // Fungsi untuk menentukan level diskon menggunakan Switch-Case
  String _getDiscountLevel(double pembelian) {
    // Konversi ke integer untuk Switch-Case
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

    // ===== SWITCH-CASE UNTUK MENENTUKAN DISKON =====
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
        return '👑';
      case 'GOLD':
        return '🥇';
      case 'SILVER':
        return '🥈';
      case 'BRONZE':
        return '🥉';
      default:
        return '⭐';
    }
  }

  String _getLevelDescription(String level) {
    switch (level) {
      case 'PLATINUM':
        return '≥ Rp 1.500.000';
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

        // Menggunakan Switch-Case melalui fungsi
        final level = _getDiscountLevel(pembelian);
        final diskonPersen = _getDiscountPercentage(level);
        final icon = _getLevelIcon(level);
        final deskripsi = _getLevelDescription(level);
        final diskon = pembelian * diskonPersen;
        final totalBayar = pembelian - diskon;

        _result = '''
═══════════════════════════════════════
        📋 STRUK PEMBELANJAAN
        (Switch-Case)
═══════════════════════════════════════
💰 Total Pembelian : Rp ${_formatRupiah(pembelian)}
🏷️  Level          : $icon $level
📌 Syarat         : $deskripsi
───────────────────────────────────────
🎯 Diskon          : ${(diskonPersen * 100).toStringAsFixed(0)}%
💸 Nilai Diskon    : Rp ${_formatRupiah(diskon)}
───────────────────────────────────────
✅ TOTAL BAYAR     : Rp ${_formatRupiah(totalBayar)}
═══════════════════════════════════════
''';
      });
    } else {
      setState(() {
        _result = '⚠️ Masukkan jumlah pembelian yang valid (minimal Rp 1)!';
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
      body: Padding(
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
                    '📌 Level Diskon (Switch-Case):',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 6),
                  _buildLevelItem('👑 PLATINUM', '≥ Rp 1.500.000', '30%', Colors.green),
                  _buildLevelItem('🥇 GOLD', 'Rp 1.000.000 - Rp 1.499.999', '20%', Colors.blue),
                  _buildLevelItem('🥈 SILVER', 'Rp 500.000 - Rp 999.999', '10%', Colors.amber),
                  _buildLevelItem('🥉 BRONZE', '< Rp 500.000', '0%', Colors.grey),
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
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _result.contains('⚠️') 
                          ? Colors.red.shade50 
                          : Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _result.contains('⚠️') 
                            ? Colors.red.shade300 
                            : Colors.purple.shade300,
                      ),
                    ),
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
          Text('$level: ', style: const TextStyle(fontSize: 13)),
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