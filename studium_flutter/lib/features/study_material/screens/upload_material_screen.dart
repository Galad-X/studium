import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studium_client/studium_client.dart';
import 'dart:math' as math;
import '../../../core/providers/service_providers.dart';
import '../../dashboard/providers/dashboard_provider.dart';

final uploadStateProvider =
    StateProvider<AsyncValue<StudyMaterial?>>((ref) => const AsyncData(null));

class UploadMaterialScreen extends ConsumerStatefulWidget {
  const UploadMaterialScreen({super.key});

  @override
  ConsumerState<UploadMaterialScreen> createState() =>
      _UploadMaterialScreenState();
}

class _UploadMaterialScreenState extends ConsumerState<UploadMaterialScreen>
    with TickerProviderStateMixin {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  PlatformFile? _pickedFile;

  late AnimationController _neuralController;
  late AnimationController _logoController;
  late AnimationController _uploadController;
  late AnimationController _successController;
  late AnimationController _slideController;

  late Animation<double> _neuralAnimation;
  late Animation<double> _logoRotation;
  late Animation<double> _uploadAnimation;
  late Animation<double> _successAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _neuralController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _logoController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    _uploadController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _successController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _neuralAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _neuralController, curve: Curves.easeInOut),
    );

    _logoRotation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.linear),
    );

    _uploadAnimation = CurvedAnimation(
      parent: _uploadController,
      curve: Curves.easeInOut,
    );

    _successAnimation = CurvedAnimation(
      parent: _successController,
      curve: Curves.elasticOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _neuralController.repeat();
    _logoController.repeat();
    _slideController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _neuralController.dispose();
    _logoController.dispose();
    _uploadController.dispose();
    _successController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx', 'pptx', 'txt'],
        withData: true,
      );

      if (result != null) {
        setState(() {
          _pickedFile = result.files.first;
          _titleController.text = _pickedFile!.name.split('.').first;
        });
        HapticFeedback.mediumImpact();
      }
    } catch (e) {
      _showNeuralErrorSnackBar('Neural Error: Failed to select file - $e');
    }
  }

  Future<void> _uploadMaterial() async {
    if (_pickedFile == null || _titleController.text.trim().isEmpty) {
      _showNeuralErrorSnackBar(
          'Neural Error: Please select a file and enter a neural title.');
      return;
    }

    final uploadStateNotifier = ref.read(uploadStateProvider.notifier);
    uploadStateNotifier.state = const AsyncLoading();
    _uploadController.repeat();

    try {
      final material =
          await ref.read(studyMaterialServiceProvider).uploadMaterial(
                title: _titleController.text.trim(),
                fileType: _pickedFile!.extension!,
                fileData: ByteData.view(_pickedFile!.bytes!.buffer),
              );

      await ref.read(analyticsServiceProvider).log('neural_upload_material',
          metadata:
              'Neural Title: ${material.title}, Neural Type: ${material.fileType}');

      await ref.read(studyMaterialProvider.notifier).fetchMaterials();

      uploadStateNotifier.state = AsyncData(material);
      ref.invalidate(studyMaterialProvider);
      ref.invalidate(dashboardProvider);

      _uploadController.stop();
      _successController.forward();
      HapticFeedback.heavyImpact();
      _showNeuralSuccessDialog();
    } catch (e) {
      _uploadController.stop();
      uploadStateNotifier.state = AsyncError(e, StackTrace.current);
      _showNeuralErrorSnackBar('Neural Upload Failed: $e');
    }
  }

  void _showNeuralErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.red, Colors.redAccent],
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.error_outline,
                  color: Colors.white, size: 16),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1A1A2E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.red.withValues(alpha: 0.3)),
        ),
      ),
    );
  }

  void _showNeuralSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black87,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1A1A2E),
                Color(0xFF16213E),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFF00D4FF).withValues(alpha: 0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00D4FF).withValues(alpha: 0.2),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _successAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _successAnimation.value,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF00D4FF).withValues(alpha: 0.2),
                                const Color(0xFF0099CC).withValues(alpha: 0.1),
                              ],
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF00D4FF)
                                  .withValues(alpha: 0.5),
                              width: 2,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF00D4FF)
                                    .withValues(alpha: 0.4),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.psychology_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                ).createShader(bounds),
                child: const Text(
                  'Neural Upload Complete! 🧠',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your material has been uploaded to the neural network and is being processed by our AI systems.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00D4FF).withValues(alpha: 0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.goNamed('materials');
                    },
                    child: const Center(
                      child: Text(
                        'Continue to Neural Library',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final uploadState = ref.watch(uploadStateProvider);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0A0A0F),
            Color(0xFF1A1A2E),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: _buildNeuralAppBar(),
        body: Stack(
          children: [
            _NeuralBackground(animation: _neuralAnimation),
            SlideTransition(
              position: _slideAnimation,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildNeuralHeader(),
                      const SizedBox(height: 32),
                      _buildNeuralFilePicker(),
                      const SizedBox(height: 32),
                      _buildNeuralTextField(
                        controller: _titleController,
                        label: 'Neural Document Title',
                        hint: 'Enter a descriptive neural title',
                        icon: Icons.psychology_rounded,
                      ),
                      const SizedBox(height: 24),
                      _buildNeuralTextField(
                        controller: _descriptionController,
                        label: 'Neural Description (Optional)',
                        hint: 'Add a brief neural description',
                        icon: Icons.description_outlined,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 40),
                      _buildNeuralUploadButton(uploadState),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildNeuralAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A2E).withValues(alpha: 0.9),
              const Color(0xFF16213E).withValues(alpha: 0.8),
            ],
          ),
        ),
      ),
      title: Row(
        children: [
          AnimatedBuilder(
            animation: _logoRotation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _logoRotation.value,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00D4FF).withValues(alpha: 0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.psychology_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
            ).createShader(bounds),
            child: const Text(
              'Neural Upload',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Widget _buildNeuralHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF00D4FF).withValues(alpha: 0.1),
            const Color(0xFF0099CC).withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF00D4FF).withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D4FF).withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00D4FF).withValues(alpha: 0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.cloud_upload_rounded,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
            ).createShader(bounds),
            child: const Text(
              'Neural Material Upload',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Upload your documents to the neural network for AI-powered analysis and processing',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNeuralFilePicker() {
    return GestureDetector(
      onTap: _pickFile,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 200,
        decoration: BoxDecoration(
          gradient: _pickedFile != null
              ? LinearGradient(
                  colors: [
                    const Color(0xFF00D4FF).withValues(alpha: 0.2),
                    const Color(0xFF0099CC).withValues(alpha: 0.1),
                  ],
                )
              : LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.1),
                    Colors.white.withValues(alpha: 0.05),
                  ],
                ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _pickedFile != null
                ? const Color(0xFF00D4FF)
                : Colors.white.withValues(alpha: 0.3),
            width: _pickedFile != null ? 2 : 1,
          ),
          boxShadow: _pickedFile != null
              ? [
                  BoxShadow(
                    color: const Color(0xFF00D4FF).withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: _pickedFile == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF00D4FF).withValues(alpha: 0.2),
                            const Color(0xFF0099CC).withValues(alpha: 0.1),
                          ],
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF00D4FF).withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        size: 48,
                        color: Color(0xFF00D4FF),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Tap to Select Neural File',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Neural Supported: PDF, DOCX, PPTX, TXT',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(0xFF00D4FF).withValues(alpha: 0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Icon(
                        _getNeuralFileIcon(_pickedFile!.extension ?? ''),
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        _pickedFile!.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00D4FF).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF00D4FF).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        'Neural Ready • ${(_pickedFile!.size / 1024 / 1024).toStringAsFixed(2)} MB',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF00D4FF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildNeuralTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D4FF).withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF00D4FF)),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
          prefixIcon: Icon(icon, color: const Color(0xFF00D4FF)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: const Color(0xFF00D4FF).withValues(alpha: 0.3),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFF00D4FF),
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.1),
        ),
      ),
    );
  }

  Widget _buildNeuralUploadButton(AsyncValue<StudyMaterial?> uploadState) {
    final isLoading = uploadState.isLoading;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: isLoading
            ? LinearGradient(
                colors: [
                  Colors.grey.withValues(alpha: 0.3),
                  Colors.grey.withValues(alpha: 0.2),
                ],
              )
            : const LinearGradient(
                colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
              ),
        boxShadow: isLoading
            ? null
            : [
                BoxShadow(
                  color: const Color(0xFF00D4FF).withValues(alpha: 0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isLoading ? null : _uploadMaterial,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  AnimatedBuilder(
                    animation: _uploadAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _uploadAnimation.value * 2 * math.pi,
                        child: const Icon(
                          Icons.psychology_rounded,
                          color: Colors.grey,
                          size: 24,
                        ),
                      );
                    },
                  )
                else
                  const Icon(
                    Icons.psychology_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                const SizedBox(width: 12),
                Text(
                  isLoading
                      ? 'Neural Processing...'
                      : 'Upload to Neural Network',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isLoading ? Colors.grey : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getNeuralFileIcon(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf_rounded;
      case 'docx':
      case 'doc':
        return Icons.description_rounded;
      case 'pptx':
      case 'ppt':
        return Icons.slideshow_rounded;
      case 'txt':
        return Icons.text_snippet_rounded;
      default:
        return Icons.insert_drive_file_rounded;
    }
  }
}

class _NeuralBackground extends StatelessWidget {
  final Animation<double> animation;

  const _NeuralBackground({required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return CustomPaint(
          painter: _NeuralNetworkPainter(animation.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class _NeuralNetworkPainter extends CustomPainter {
  final double animationValue;

  _NeuralNetworkPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00D4FF).withValues(alpha: 0.1)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final nodePaint = Paint()
      ..color = const Color(0xFF00D4FF).withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    // Generate neural network nodes
    final nodes = <Offset>[];
    for (int i = 0; i < 25; i++) {
      final x = (i * 0.2 * size.width + animationValue * 50) % size.width;
      final y =
          (i * 0.15 * size.height + math.sin(animationValue * 2 + i) * 30) %
              size.height;
      nodes.add(Offset(x, y));
    }

    // Draw connections
    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final distance = (nodes[i] - nodes[j]).distance;
        if (distance < 150) {
          final opacity = (1 - distance / 150) * 0.3;
          paint.color = const Color(0xFF00D4FF).withValues(alpha: opacity);
          canvas.drawLine(nodes[i], nodes[j], paint);
        }
      }
    }

    // Draw nodes
    for (final node in nodes) {
      final pulseRadius = 3 + math.sin(animationValue * 3) * 1;
      canvas.drawCircle(node, pulseRadius, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
