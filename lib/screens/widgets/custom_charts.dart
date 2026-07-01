import 'dart:math';
import 'package:flutter/material.dart';
import '../../models/user_model.dart'; // Import User model

// ==========================================
// 1. WIDGET SLIDESHOW GRAFIK UTAMA
// ==========================================
class GraphSlideshow extends StatefulWidget {
  final User user;
  const GraphSlideshow({super.key, required this.user});

  @override
  State<GraphSlideshow> createState() => _GraphSlideshowState();
}

class _GraphSlideshowState extends State<GraphSlideshow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, dynamic>> get _chartsData => [
    {
      'title': 'Grafik Berat Badan (Line Chart)',
      'subtitle': 'Perkembangan berat badan ${widget.user.namaLengkap} (Jan - Mei)',
      'widget': const WeightLineChart(),
    },
    {
      'title': 'Grafik Tinggi Badan (Bar Chart)',
      'subtitle': 'Perbandingan tinggi badan anggota kelompok (cm)',
      'widget': const HeightBarChart(),
    },
    {
      'title': 'Grafik Ukuran Baju (Donut Chart)',
      'subtitle': 'Distribusi ukuran baju anggota/staf (%)',
      'widget': const ClothingSizeDonutChart(),
    },
    {
      'title': 'Grafik Ukuran Sepatu (Area Chart)',
      'subtitle': 'Distribusi ukuran sepatu anggota kelompok',
      'widget': const ShoeSizeAreaChart(),
    },
    {
      'title': 'Grafik Umur Anggota (Radar Chart)',
      'subtitle': 'Visualisasi umur anggota kelompok (Tahun)',
      'widget': const AgeRadarChart(),
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header Slideshow
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _chartsData[_currentPage]['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00BFFF),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _chartsData[_currentPage]['subtitle'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                // Tombol Navigasi Kiri & Kanan
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left, color: Color(0xFF00BFFF)),
                      onPressed: _currentPage > 0
                          ? () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right, color: Color(0xFF00BFFF)),
                      onPressed: _currentPage < _chartsData.length - 1
                          ? () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                    ),
                  ],
                )
              ],
            ),
            const Divider(height: 20),
            
            // Area Konten Grafik
            SizedBox(
              height: 220,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _chartsData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _chartsData[index]['widget'] as Widget,
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            
            // Indikator Titik (Page Indicators)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _chartsData.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 20 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? const Color(0xFF00BFFF)
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. GRAFIK BERAT BADAN (LINE CHART)
// ==========================================
class WeightLineChart extends StatelessWidget {
  const WeightLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _WeightLineChartPainter(),
    );
  }
}

class _WeightLineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = const Color(0xFF00BFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..isAntiAlias = true;

    final paintPoint = Paint()
      ..color = const Color(0xFF00BFFF)
      ..style = PaintingStyle.fill;

    final paintPointInner = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final paintGrid = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 1;

    // Data: Jan=68, Feb=70, Mar=69, Apr=72, May=71
    final data = [68.0, 70.0, 69.0, 72.0, 71.0];
    final labels = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei'];
    
    const minVal = 65.0;
    const maxVal = 75.0;
    const paddingLeft = 30.0;
    const paddingBottom = 25.0;
    const paddingTop = 15.0;
    const paddingRight = 15.0;

    final drawWidth = size.width - paddingLeft - paddingRight;
    final drawHeight = size.height - paddingTop - paddingBottom;

    // Draw Grid & Y-Axis Labels
    const gridLines = 4;
    for (int i = 0; i <= gridLines; i++) {
      final y = paddingTop + (drawHeight / gridLines) * i;
      final val = maxVal - ((maxVal - minVal) / gridLines) * i;
      
      canvas.drawLine(Offset(paddingLeft, y), Offset(size.width - paddingRight, y), paintGrid);
      
      // Text Y
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${val.toInt()}kg',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(2, y - textPainter.height / 2));
    }

    // Hitung posisi koordinat
    final points = <Offset>[];
    final stepX = drawWidth / (data.length - 1);
    for (int i = 0; i < data.length; i++) {
      final x = paddingLeft + i * stepX;
      final y = paddingTop + drawHeight - ((data[i] - minVal) / (maxVal - minVal)) * drawHeight;
      points.add(Offset(x, y));
    }

    // Path area di bawah garis (gradient fill)
    final pathArea = Path()
      ..moveTo(points.first.dx, paddingTop + drawHeight);
    
    for (int i = 0; i < points.length; i++) {
      if (i == 0) {
        pathArea.lineTo(points[i].dx, points[i].dy);
      } else {
        // Curve smoothing
        final prev = points[i - 1];
        final curr = points[i];
        final cp1 = Offset(prev.dx + stepX / 2, prev.dy);
        final cp2 = Offset(curr.dx - stepX / 2, curr.dy);
        pathArea.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, curr.dx, curr.dy);
      }
    }
    pathArea.lineTo(points.last.dx, paddingTop + drawHeight);
    pathArea.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF00BFFF).withValues(alpha: 0.3),
          const Color(0xFF00BFFF).withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(paddingLeft, paddingTop, drawWidth, drawHeight));
    
    canvas.drawPath(pathArea, fillPaint);

    // Path Garis Grafik
    final pathLine = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      final prev = points[i - 1];
      final curr = points[i];
      final cp1 = Offset(prev.dx + stepX / 2, prev.dy);
      final cp2 = Offset(curr.dx - stepX / 2, curr.dy);
      pathLine.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, curr.dx, curr.dy);
    }
    canvas.drawPath(pathLine, paintLine);

    // Draw data points & X-Axis Labels
    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], 6, paintPoint);
      canvas.drawCircle(points[i], 3, paintPointInner);

      // Label X
      final textPainter = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(color: Colors.grey.shade600, fontSize: 10, fontWeight: FontWeight.bold),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(points[i].dx - textPainter.width / 2, size.height - paddingBottom + 6));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==========================================
// 3. GRAFIK TINGGI BADAN (BAR CHART)
// ==========================================
class HeightBarChart extends StatelessWidget {
  const HeightBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _HeightBarChartPainter(),
    );
  }
}

class _HeightBarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Data: Yefta=172, Mirfan=168, Adhima=165, Tio=175
    final data = [172.0, 168.0, 165.0, 175.0];
    final labels = ['Yefta', 'Mirfan', 'Adhima', 'Tio'];

    const minVal = 150.0;
    const maxVal = 180.0;
    const paddingLeft = 35.0;
    const paddingBottom = 25.0;
    const paddingTop = 20.0;
    const paddingRight = 10.0;

    final drawWidth = size.width - paddingLeft - paddingRight;
    final drawHeight = size.height - paddingTop - paddingBottom;
    final barWidth = (drawWidth / data.length) * 0.55;
    final groupWidth = drawWidth / data.length;

    final paintGrid = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 1;

    // Draw Y grid & labels
    const gridLines = 3;
    for (int i = 0; i <= gridLines; i++) {
      final y = paddingTop + (drawHeight / gridLines) * i;
      final val = maxVal - ((maxVal - minVal) / gridLines) * i;

      canvas.drawLine(Offset(paddingLeft, y), Offset(size.width - paddingRight, y), paintGrid);

      final textPainter = TextPainter(
        text: TextSpan(
          text: '${val.toInt()}cm',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(2, y - textPainter.height / 2));
    }

    // Draw Bars
    for (int i = 0; i < data.length; i++) {
      final centerX = paddingLeft + (i * groupWidth) + (groupWidth / 2);
      final left = centerX - (barWidth / 2);
      final right = centerX + (barWidth / 2);
      final top = paddingTop + drawHeight - ((data[i] - minVal) / (maxVal - minVal)) * drawHeight;
      final bottom = paddingTop + drawHeight;

      final rect = Rect.fromLTRB(left, top, right, bottom);
      final rrect = RRect.fromRectAndCorners(
        rect,
        topLeft: const Radius.circular(6),
        topRight: const Radius.circular(6),
      );

      final paintBar = Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF00BFFF),
            Color(0xFF80E5FF),
          ],
        ).createShader(rect);

      canvas.drawRRect(rrect, paintBar);

      // Value label on top of bar
      final valPainter = TextPainter(
        text: TextSpan(
          text: '${data[i].toInt()}',
          style: const TextStyle(color: Color(0xFF00BFFF), fontSize: 10, fontWeight: FontWeight.bold),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      valPainter.paint(canvas, Offset(centerX - valPainter.width / 2, top - 15));

      // Label X
      final textPainter = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(color: Colors.grey.shade600, fontSize: 10, fontWeight: FontWeight.bold),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(centerX - textPainter.width / 2, size.height - paddingBottom + 6));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==========================================
// 4. GRAFIK UKURAN BAJU (DONUT CHART)
// ==========================================
class ClothingSizeDonutChart extends StatelessWidget {
  const ClothingSizeDonutChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Donut Chart
        Expanded(
          flex: 4,
          child: CustomPaint(
            size: Size.infinite,
            painter: _ClothingSizeDonutChartPainter(),
          ),
        ),
        // Legend
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _LegendItem(color: Color(0xFF004C66), label: 'S (15%)'),
              SizedBox(height: 6),
              _LegendItem(color: Color(0xFF00BFFF), label: 'M (35%)'),
              SizedBox(height: 6),
              _LegendItem(color: Color(0xFF80E5FF), label: 'L (30%)'),
              SizedBox(height: 6),
              _LegendItem(color: Color(0xFFB3F0FF), label: 'XL (20%)'),
            ],
          ),
        ),
      ],
    );
  }
}

class _ClothingSizeDonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Data: S=15%, M=35%, L=30%, XL=20%
    final percentages = [0.15, 0.35, 0.30, 0.20];
    final colors = [
      const Color(0xFF004C66),
      const Color(0xFF00BFFF),
      const Color(0xFF80E5FF),
      const Color(0xFFB3F0FF),
    ];

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) * 0.4;
    final strokeWidth = radius * 0.45;

    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);

    double startAngle = -pi / 2;

    for (int i = 0; i < percentages.length; i++) {
      final sweepAngle = percentages[i] * 2 * pi;
      
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..isAntiAlias = true;

      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle;
    }

    // Inner Text (Total)
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'Total\n40 Pcs',
        style: TextStyle(
          color: Color(0xFF004C66),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF004C66)),
        ),
      ],
    );
  }
}

// ==========================================
// 5. GRAFIK UKURAN SEPATU (CURVED AREA CHART)
// ==========================================
class ShoeSizeAreaChart extends StatelessWidget {
  const ShoeSizeAreaChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _ShoeSizeAreaChartPainter(),
    );
  }
}

class _ShoeSizeAreaChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Data: Size 38=2, 39=5, 40=12, 41=8, 42=3
    final data = [2.0, 5.0, 12.0, 8.0, 3.0];
    final labels = ['38', '39', '40', '41', '42'];

    const minVal = 0.0;
    const maxVal = 15.0;
    const paddingLeft = 25.0;
    const paddingBottom = 25.0;
    const paddingTop = 15.0;
    const paddingRight = 15.0;

    final drawWidth = size.width - paddingLeft - paddingRight;
    final drawHeight = size.height - paddingTop - paddingBottom;

    final paintGrid = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 1;

    // Draw Y grid
    const gridLines = 3;
    for (int i = 0; i <= gridLines; i++) {
      final y = paddingTop + (drawHeight / gridLines) * i;
      final val = maxVal - ((maxVal - minVal) / gridLines) * i;

      canvas.drawLine(Offset(paddingLeft, y), Offset(size.width - paddingRight, y), paintGrid);

      final textPainter = TextPainter(
        text: TextSpan(
          text: '${val.toInt()}',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(2, y - textPainter.height / 2));
    }

    // Points calculation
    final points = <Offset>[];
    final stepX = drawWidth / (data.length - 1);
    for (int i = 0; i < data.length; i++) {
      final x = paddingLeft + i * stepX;
      final y = paddingTop + drawHeight - ((data[i] - minVal) / (maxVal - minVal)) * drawHeight;
      points.add(Offset(x, y));
    }

    // Fill Spline area
    final path = Path()..moveTo(points.first.dx, paddingTop + drawHeight);
    path.lineTo(points.first.dx, points.first.dy);
    
    for (int i = 1; i < points.length; i++) {
      final prev = points[i - 1];
      final curr = points[i];
      final cp1 = Offset(prev.dx + stepX / 2, prev.dy);
      final cp2 = Offset(curr.dx - stepX / 2, curr.dy);
      path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, curr.dx, curr.dy);
    }
    path.lineTo(points.last.dx, paddingTop + drawHeight);
    path.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF00BFFF).withValues(alpha: 0.4),
          const Color(0xFF00BFFF).withValues(alpha: 0.05),
        ],
      ).createShader(Rect.fromLTWH(paddingLeft, paddingTop, drawWidth, drawHeight));

    canvas.drawPath(path, fillPaint);

    // Draw spline border line
    final linePaint = Paint()
      ..color = const Color(0xFF00BFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..isAntiAlias = true;

    final borderPath = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      final prev = points[i - 1];
      final curr = points[i];
      final cp1 = Offset(prev.dx + stepX / 2, prev.dy);
      final cp2 = Offset(curr.dx - stepX / 2, curr.dy);
      borderPath.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, curr.dx, curr.dy);
    }
    canvas.drawPath(borderPath, linePaint);

    // Draw dots and X labels
    final paintPoint = Paint()
      ..color = const Color(0xFF004C66)
      ..style = PaintingStyle.fill;
    final paintPointInner = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], 5, paintPoint);
      canvas.drawCircle(points[i], 2.5, paintPointInner);

      // Label X
      final textPainter = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(color: Colors.grey.shade600, fontSize: 10, fontWeight: FontWeight.bold),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(points[i].dx - textPainter.width / 2, size.height - paddingBottom + 6));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==========================================
// 6. GRAFIK UMUR ANGGOTA (RADAR CHART)
// ==========================================
class AgeRadarChart extends StatelessWidget {
  const AgeRadarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _AgeRadarChartPainter(),
    );
  }
}

class _AgeRadarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Data: Yefta=20, Mirfan=21, Adhima=22, Tio=23
    final data = [20.0, 21.0, 22.0, 23.0];
    final labels = ['Yefta (20)', 'Mirfan (21)', 'Adhima (22)', 'Tio (23)'];
    const maxVal = 25.0; // Max age reference for full radius

    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = min(size.width, size.height) * 0.38;

    final paintGrid = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final paintLine = Paint()
      ..color = const Color(0xFF00BFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final paintFill = Paint()
      ..color = const Color(0xFF00BFFF).withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    // 1. Draw Radar Grid Lines (Circles / Concentric Rings)
    const gridCircles = 3;
    for (int i = 1; i <= gridCircles; i++) {
      final r = maxRadius * (i / gridCircles);
      canvas.drawCircle(center, r, paintGrid);
    }

    // 2. Calculate Axis positions (4 directions for 4 members)
    final points = <Offset>[];
    final angleStep = 2 * pi / data.length;

    for (int i = 0; i < data.length; i++) {
      final angle = (i * angleStep) - pi / 2; // Start from top
      
      // Axis Line
      final endX = center.dx + maxRadius * cos(angle);
      final endY = center.dy + maxRadius * sin(angle);
      canvas.drawLine(center, Offset(endX, endY), paintGrid);

      // Data point position
      final scale = data[i] / maxVal;
      final x = center.dx + (maxRadius * scale) * cos(angle);
      final y = center.dy + (maxRadius * scale) * sin(angle);
      points.add(Offset(x, y));

      // Draw Axis label text
      final labelText = labels[i];
      final textPainter = TextPainter(
        text: TextSpan(
          text: labelText,
          style: const TextStyle(color: Color(0xFF004C66), fontSize: 9, fontWeight: FontWeight.bold),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      // Label offset placement based on angle
      double labelX = endX;
      double labelY = endY;
      if (cos(angle).abs() < 0.1) {
        // Top or Bottom
        labelX -= textPainter.width / 2;
        labelY += sin(angle) > 0 ? 4 : -textPainter.height - 4;
      } else {
        // Left or Right
        labelX += cos(angle) > 0 ? 6 : -textPainter.width - 6;
        labelY -= textPainter.height / 2;
      }

      textPainter.paint(canvas, Offset(labelX, labelY));
    }

    // 3. Draw Radar Area Polyline & Fill
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    path.close();

    canvas.drawPath(path, paintFill);
    canvas.drawPath(path, paintLine);

    // 4. Draw Radar Point Dots
    final paintPoint = Paint()
      ..color = const Color(0xFF00BFFF)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], 4, paintPoint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
