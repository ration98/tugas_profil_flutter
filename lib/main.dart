import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
      home: const HomePage(),
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
        title: const Text("Kelompok 8 - Mobile Programming"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.calculate),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TugasRumusPage()),
              );
            },
          ),
        ],
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
          // Ditambahkan agar isi Column bisa benar-benar di tengah
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Pusatkan secara vertikal
            crossAxisAlignment:
                CrossAxisAlignment.center, // Pusatkan secara horizontal
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
        // Memastikan frame pertama muncul
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

