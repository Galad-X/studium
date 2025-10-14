import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studium_client/studium_client.dart';
import '../../../core/layout/responsive.dart';
import '../../history/screens/my_writings_screen.dart';
import '../../study_material/providers/study_material_provider.dart';
import '../providers/writing_provider.dart';
import 'dart:math' as math;

class StartAcademicWritingScreen extends ConsumerStatefulWidget {
  const StartAcademicWritingScreen({super.key});

  @override
  ConsumerState<StartAcademicWritingScreen> createState() =>
      _StartAcademicWritingScreenState();
}

class _StartAcademicWritingScreenState
    extends ConsumerState<StartAcademicWritingScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _wordCountController = TextEditingController(text: '1500');

  String _selectedDocType = 'undergraduate_project';
  StudyMaterial? _selectedSourceMaterial;

  late AnimationController _slideController;
  late AnimationController _neuralController;
  late AnimationController _logoController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _logoRotation;

  final Map<String, DocumentTypeInfo> _documentTypes = {
    'undergraduate_project': DocumentTypeInfo(
      name: 'Neural Research Project',
      description: 'AI-powered academic research for undergraduate studies',
      icon: Icons.psychology_rounded,
      color: const Color(0xFF4FC3F7),
      estimatedTime: '15-20 minutes',
    ),
    'dissertation': DocumentTypeInfo(
      name: 'Neural Dissertation',
      description: 'Comprehensive AI-assisted thesis or dissertation',
      icon: Icons.auto_awesome_rounded,
      color: const Color(0xFF7C4DFF),
      estimatedTime: '25-30 minutes',
    ),
    'business_plan': DocumentTypeInfo(
      name: 'Neural Business Plan',
      description: 'AI-driven strategic business planning document',
      icon: Icons.trending_up_rounded,
      color: const Color(0xFF00E676),
      estimatedTime: '20-25 minutes',
    ),
    'field_trip_report': DocumentTypeInfo(
      name: 'Neural Field Report',
      description: 'AI-enhanced field study and research documentation',
      icon: Icons.explore_rounded,
      color: const Color(0xFFFF9800),
      estimatedTime: '10-15 minutes',
    ),
  };

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _neuralController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
    _logoController = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat();

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _logoRotation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.linear),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _slideController.forward();
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _wordCountController.dispose();
    _slideController.dispose();
    _neuralController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      HapticFeedback.mediumImpact();
      ref.read(academicWritingProvider.notifier).generateDocument(
            title: _titleController.text.trim(),
            type: _selectedDocType,
            studyMaterialId: _selectedSourceMaterial?.id,
            wordCount: int.tryParse(_wordCountController.text),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final materialsState = ref.watch(studyMaterialProvider);
    final writingState = ref.watch(academicWritingProvider);

    ref.listen<WritingState>(academicWritingProvider, (prev, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (next.status == WritingStatus.success && next.result != null) {
          context.pushNamed('writingResult', extra: next.result!);
        }
        if (next.status == WritingStatus.error) {
          _showNeuralErrorSnackBar(next.errorMessage!);
        }
      });
    });

    return ResponsiveScaffold(
      mobile: _buildNeuralMobileLayout(materialsState, writingState),
      tablet: _buildNeuralTabletLayout(materialsState, writingState),
      desktop: _buildNeuralDesktopLayout(materialsState, writingState),
    );
  }

  Widget _buildNeuralMobileLayout(
      StudyMaterialState materialsState, WritingState writingState) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      appBar: _buildNeuralAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0E1A),
              Color(0xFF1A1F2E),
              Color(0xFF0A0E1A),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Neural Network Background
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _neuralController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _NeuralNetworkPainter(
                      animation: _neuralController,
                      nodeColor: const Color(0xFF4FC3F7),
                      connectionColor: const Color(0xFF7C4DFF),
                    ),
                  );
                },
              ),
            ),

            // Main Content
            SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildNeuralHeader(isMobile: true),
                      const SizedBox(height: 24),
                      _buildNeuralTitleSection(),
                      const SizedBox(height: 20),
                      _buildNeuralDocumentTypeSection(isMobile: true),
                      const SizedBox(height: 20),
                      _buildNeuralSourceMaterialSection(materialsState),
                      const SizedBox(height: 20),
                      _buildNeuralWordCountSection(),
                      const SizedBox(height: 32),
                      _buildNeuralGenerateButton(writingState),
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

  Widget _buildNeuralTabletLayout(
      StudyMaterialState materialsState, WritingState writingState) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      appBar: _buildNeuralAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0E1A),
              Color(0xFF1A1F2E),
              Color(0xFF0A0E1A),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Neural Network Background
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _neuralController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _NeuralNetworkPainter(
                      animation: _neuralController,
                      nodeColor: const Color(0xFF4FC3F7),
                      connectionColor: const Color(0xFF7C4DFF),
                    ),
                  );
                },
              ),
            ),

            // Main Content
            SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildNeuralHeader(),
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: _buildNeuralTitleSection(),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: _buildNeuralWordCountSection(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          _buildNeuralDocumentTypeSection(isTablet: true),
                          const SizedBox(height: 24),
                          _buildNeuralSourceMaterialSection(materialsState),
                          const SizedBox(height: 40),
                          _buildNeuralGenerateButton(writingState),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeuralDesktopLayout(
      StudyMaterialState materialsState, WritingState writingState) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      appBar: _buildNeuralAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0E1A),
              Color(0xFF1A1F2E),
              Color(0xFF0A0E1A),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Neural Network Background
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _neuralController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _NeuralNetworkPainter(
                      animation: _neuralController,
                      nodeColor: const Color(0xFF4FC3F7),
                      connectionColor: const Color(0xFF7C4DFF),
                    ),
                  );
                },
              ),
            ),

            // Main Content
            SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(48.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildNeuralHeader(),
                          const SizedBox(height: 40),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left column
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    _buildNeuralTitleSection(),
                                    const SizedBox(height: 32),
                                    _buildNeuralDocumentTypeSection(),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 40),
                              // Right column
                              Expanded(
                                child: Column(
                                  children: [
                                    _buildNeuralWordCountSection(),
                                    const SizedBox(height: 32),
                                    _buildNeuralSourceMaterialSection(
                                        materialsState),
                                    const SizedBox(height: 40),
                                    _buildNeuralGenerateButton(writingState),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
      title: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
        ).createShader(bounds),
        child: const Text(
          'Neural AI Writer',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Widget _buildNeuralHeader({bool isMobile = false}) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF4FC3F7).withAlpha(26),
            const Color(0xFF7C4DFF).withAlpha(26),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF4FC3F7).withAlpha(77),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4FC3F7).withAlpha(52),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _logoRotation,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Outer rotating ring
                  Transform.rotate(
                    angle: _logoRotation.value,
                    child: Container(
                      width: isMobile ? 60 : 70,
                      height: isMobile ? 60 : 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF4FC3F7).withAlpha(77),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  // Neural Logo Container
                  Container(
                    width: isMobile ? 40 : 48,
                    height: isMobile ? 40 : 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4FC3F7).withAlpha(104),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.auto_awesome_rounded,
                      size: isMobile ? 20 : 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: isMobile ? 12 : 16),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
            ).createShader(bounds),
            child: Text(
              'Neural AI Writing Assistant',
              style: TextStyle(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Generate high-quality academic documents with neural AI assistance',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withAlpha(204),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNeuralTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.title_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Neural Document Title',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1F2E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF4FC3F7).withAlpha(77),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(77),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: _titleController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'e.g., Neural Networks in Climate Change Analysis',
              hintStyle: TextStyle(color: Colors.white.withAlpha(128)),
              prefixIcon:
                  const Icon(Icons.edit_rounded, color: Color(0xFF4FC3F7)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.transparent,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a document title';
              }
              if (value.trim().length < 5) {
                return 'Title should be at least 5 characters long';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNeuralDocumentTypeSection(
      {bool isMobile = false, bool isTablet = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.category_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Neural Document Type',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Responsive document type cards layout
        if (isTablet) ...[
          // 2-column grid for tablet
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
            ),
            itemCount: _documentTypes.length,
            itemBuilder: (context, index) {
              final entry = _documentTypes.entries.elementAt(index);
              final typeCode = entry.key;
              final typeInfo = entry.value;
              final isSelected = _selectedDocType == typeCode;
              return _NeuralDocumentTypeCard(
                typeInfo: typeInfo,
                isSelected: isSelected,
                isCompact: true,
                onTap: () {
                  setState(() => _selectedDocType = typeCode);
                  HapticFeedback.selectionClick();
                },
              );
            },
          ),
        ] else ...[
          // Single column for mobile and desktop
          ...(_documentTypes.entries.map((entry) {
            final typeCode = entry.key;
            final typeInfo = entry.value;
            final isSelected = _selectedDocType == typeCode;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _NeuralDocumentTypeCard(
                typeInfo: typeInfo,
                isSelected: isSelected,
                isCompact: isMobile,
                onTap: () {
                  setState(() => _selectedDocType = typeCode);
                  HapticFeedback.selectionClick();
                },
              ),
            );
          }).toList()),
        ],
      ],
    );
  }

  Widget _buildNeuralSourceMaterialSection(StudyMaterialState materialsState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.source_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Flexible(
              child: Text(
                'Neural Source Material',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00E676), Color(0xFF4CAF50)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Optional',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1F2E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF4FC3F7).withAlpha(77),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(77),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: DropdownButtonFormField<StudyMaterial?>(
            value: _selectedSourceMaterial,
            dropdownColor: const Color(0xFF1A1F2E),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Select neural data source (optional)',
              hintStyle: TextStyle(color: Colors.white.withAlpha(128)),
              prefixIcon:
                  const Icon(Icons.folder_rounded, color: Color(0xFF4FC3F7)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.transparent,
            ),
            items: [
              DropdownMenuItem<StudyMaterial?>(
                value: null,
                child: Text(
                  'None - Generate from neural scratch',
                  style: TextStyle(color: Colors.white.withAlpha(204)),
                ),
              ),
              ...materialsState.materials.map((material) {
                return DropdownMenuItem<StudyMaterial?>(
                  value: material,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getFileIcon(material.fileType),
                        size: 20,
                        color: _getFileColor(material.fileType),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          material.title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
            onChanged: (value) {
              setState(() => _selectedSourceMaterial = value);
              HapticFeedback.selectionClick();
            },
          ),
        ),
        if (_selectedSourceMaterial != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4FC3F7).withAlpha(26),
                  const Color(0xFF7C4DFF).withAlpha(26),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF4FC3F7).withAlpha(77),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  color: Color(0xFF4FC3F7),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Neural AI will analyze "${_selectedSourceMaterial!.title}" as reference data for generating your document.',
                    style: const TextStyle(
                      color: Color(0xFF4FC3F7),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNeuralWordCountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.format_list_numbered_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Flexible(
              child: Text(
                'Neural Word Count',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1F2E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF4FC3F7).withAlpha(77),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(77),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: _wordCountController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'e.g., 1500',
              hintStyle: TextStyle(color: Colors.white.withAlpha(128)),
              prefixIcon: const Icon(Icons.text_fields_rounded,
                  color: Color(0xFF4FC3F7)),
              suffixText: 'words',
              suffixStyle: TextStyle(color: Colors.white.withAlpha(178)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.transparent,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a word count';
              }
              final wordCount = int.tryParse(value.trim());
              if (wordCount == null || wordCount < 100) {
                return 'Word count should be at least 100';
              }
              if (wordCount > 10000) {
                return 'Word count should not exceed 10,000';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              [500, 1000, 1500, 2000, 3000, 5000, 8000, 10000].map((count) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF4FC3F7).withAlpha(52),
                    const Color(0xFF7C4DFF).withAlpha(52),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF4FC3F7).withAlpha(77),
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    _wordCountController.text = count.toString();
                    HapticFeedback.selectionClick();
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      '${count}w',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNeuralGenerateButton(WritingState writingState) {
    final isLoading = writingState.status == WritingStatus.loading;
    final selectedType = _documentTypes[_selectedDocType]!;

    return Column(
      children: [
        if (isLoading) ...[
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4FC3F7).withAlpha(26),
                  const Color(0xFF7C4DFF).withAlpha(26),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF4FC3F7).withAlpha(77),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF4FC3F7)),
                    backgroundColor: Colors.white.withAlpha(26),
                  ),
                ),
                const SizedBox(height: 16),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
                  ).createShader(bounds),
                  child: const Text(
                    'Neural AI Processing...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Neural time: ${selectedType.estimatedTime}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(178),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: isLoading
                ? LinearGradient(
                    colors: [
                      Colors.grey.withAlpha(77),
                      Colors.grey.withAlpha(52),
                    ],
                  )
                : const LinearGradient(
                    colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
                  ),
            boxShadow: isLoading
                ? null
                : [
                    BoxShadow(
                      color: const Color(0xFF4FC3F7).withAlpha(104),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: isLoading ? null : _submit,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      color: isLoading ? Colors.grey : Colors.white,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      isLoading
                          ? 'Neural Processing...'
                          : 'Generate Neural Document',
                      style: TextStyle(
                        fontSize: 16,
                        color: isLoading ? Colors.grey : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showNeuralErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Neural Error: $message',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFE91E63),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  IconData _getFileIcon(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf_rounded;
      case 'docx':
      case 'doc':
        return Icons.description_rounded;
      case 'pptx':
      case 'ppt':
        return Icons.slideshow_rounded;
      default:
        return Icons.insert_drive_file_rounded;
    }
  }

  Color _getFileColor(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return Colors.red;
      case 'docx':
      case 'doc':
        return Colors.blue;
      case 'pptx':
      case 'ppt':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

class _NeuralDocumentTypeCard extends StatefulWidget {
  final DocumentTypeInfo typeInfo;
  final bool isSelected;
  final bool isCompact;
  final VoidCallback onTap;

  const _NeuralDocumentTypeCard({
    required this.typeInfo,
    required this.isSelected,
    required this.onTap,
    this.isCompact = false,
  });

  @override
  State<_NeuralDocumentTypeCard> createState() =>
      _NeuralDocumentTypeCardState();
}

class _NeuralDocumentTypeCardState extends State<_NeuralDocumentTypeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: widget.isSelected
              ? LinearGradient(
                  colors: [
                    widget.typeInfo.color.withAlpha(52),
                    widget.typeInfo.color.withAlpha(26),
                  ],
                )
              : LinearGradient(
                  colors: [
                    const Color(0xFF1A1F2E),
                    const Color(0xFF0A0E1A),
                  ],
                ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: widget.isSelected
                ? widget.typeInfo.color
                : const Color(0xFF4FC3F7).withAlpha(77),
            width: widget.isSelected ? 2 : 1,
          ),
          boxShadow: widget.isSelected
              ? [
                  BoxShadow(
                    color: widget.typeInfo.color.withAlpha(77),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withAlpha(77),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: widget.onTap,
            onTapDown: (_) => _controller.forward(),
            onTapUp: (_) => _controller.reverse(),
            onTapCancel: () => _controller.reverse(),
            child: Padding(
              padding: EdgeInsets.all(widget.isCompact ? 16 : 20),
              child:
                  widget.isCompact ? _buildCompactLayout() : _buildFullLayout(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.typeInfo.color,
                widget.typeInfo.color.withAlpha(178),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: widget.typeInfo.color.withAlpha(77),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            widget.typeInfo.icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.typeInfo.name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Icon(
          widget.isSelected
              ? Icons.radio_button_checked
              : Icons.radio_button_unchecked,
          color: widget.isSelected
              ? widget.typeInfo.color
              : Colors.white.withAlpha(128),
          size: 20,
        ),
      ],
    );
  }

  Widget _buildFullLayout() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.typeInfo.color,
                widget.typeInfo.color.withAlpha(178),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: widget.typeInfo.color.withAlpha(77),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            widget.typeInfo.icon,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.typeInfo.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.typeInfo.description!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(178),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      widget.typeInfo.color.withAlpha(52),
                      widget.typeInfo.color.withAlpha(26),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: widget.typeInfo.color.withAlpha(77),
                  ),
                ),
                child: Text(
                  widget.typeInfo.estimatedTime!,
                  style: TextStyle(
                    fontSize: 12,
                    color: widget.typeInfo.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Icon(
          widget.isSelected
              ? Icons.radio_button_checked
              : Icons.radio_button_unchecked,
          color: widget.isSelected
              ? widget.typeInfo.color
              : Colors.white.withAlpha(128),
        ),
      ],
    );
  }
}

// Neural Network Background Painter
class _NeuralNetworkPainter extends CustomPainter {
  final Animation<double> animation;
  final Color nodeColor;
  final Color connectionColor;

  _NeuralNetworkPainter({
    required this.animation,
    required this.nodeColor,
    required this.connectionColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = connectionColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final nodePaint = Paint()
      ..color = nodeColor
      ..style = PaintingStyle.fill;

    // Generate neural network nodes
    final nodes = <Offset>[];
    final random = math.Random(42); // Fixed seed for consistent pattern

    for (int i = 0; i < 12; i++) {
      nodes.add(Offset(
        random.nextDouble() * size.width,
        random.nextDouble() * size.height,
      ));
    }

    // Draw connections with animation
    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final distance = (nodes[i] - nodes[j]).distance;
        if (distance < 100) {
          final opacity = (1 - distance / 100) * 0.15;
          paint.color = connectionColor.withOpacity(opacity *
              (0.5 + 0.5 * math.sin(animation.value * 2 * math.pi + i)));
          canvas.drawLine(nodes[i], nodes[j], paint);
        }
      }
    }

    // Draw nodes with pulsing animation
    for (int i = 0; i < nodes.length; i++) {
      final pulseScale =
          1 + 0.3 * math.sin(animation.value * 2 * math.pi + i * 0.5);
      final radius = 2.0 * pulseScale;
      nodePaint.color = nodeColor.withAlpha(77);
      canvas.drawCircle(nodes[i], radius, nodePaint);

      // Inner glow
      nodePaint.color = nodeColor.withAlpha(152);
      canvas.drawCircle(nodes[i], radius * 0.5, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
