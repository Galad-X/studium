import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:studium_client/studium_client.dart';
import 'package:intl/intl.dart';

class MaterialDetailScreen extends StatefulWidget {
  final StudyMaterial material;

  const MaterialDetailScreen({super.key, required this.material});

  @override
  State<MaterialDetailScreen> createState() => _MaterialDetailScreenState();
}

class _MaterialDetailScreenState extends State<MaterialDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _staggerController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _slideController.forward();
    _staggerController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: _buildAppBar(theme),
      body: SlideTransition(
        position: _slideAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Material info header
              _buildMaterialHeader(theme),
              const SizedBox(height: 32),

              // AI Tools section
              _buildAIToolsSection(theme),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        widget.material.title,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildMaterialHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getFileColor(widget.material.fileType).withAlpha(26),
            _getFileColor(widget.material.fileType).withAlpha(13),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _getFileColor(widget.material.fileType).withAlpha(77),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _getFileColor(widget.material.fileType).withAlpha(26),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  _getFileIcon(widget.material.fileType),
                  size: 32,
                  color: _getFileColor(widget.material.fileType),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.material.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getFileColor(widget.material.fileType)
                            .withAlpha(52),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.material.fileType.toUpperCase(),
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: _getFileColor(widget.material.fileType),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Material details
          _DetailRow(
            icon: Icons.calendar_today_rounded,
            label: 'Uploaded',
            value: DateFormat.yMMMd().format(widget.material.uploadDate),
          ),
          const SizedBox(height: 12),

          if (widget.material.size != null)
            _DetailRow(
              icon: Icons.storage_rounded,
              label: 'File Size',
              value:
                  '${(widget.material.size! / 1024 / 1024).toStringAsFixed(2)} MB',
            ),
        ],
      ),
    );
  }

  Widget _buildAIToolsSection(ThemeData theme) {
    final aiTools = [
      _AIToolInfo(
        title: 'Take a Quiz',
        subtitle: 'Test your knowledge with AI-generated questions',
        icon: Icons.quiz_rounded,
        color: Colors.orange.shade600,
        isPremium: false,
        onTap: () {
          HapticFeedback.lightImpact();
          context.pushNamed(
            'startQuiz',
            pathParameters: {'id': widget.material.id!.toString()},
            extra: widget.material,
          );
        },
      ),
      _AIToolInfo(
        title: 'Generate Summary',
        subtitle: 'Get a concise summary of the key points',
        icon: Icons.summarize_rounded,
        color: Colors.blue.shade600,
        isPremium: false,
        onTap: () {
          HapticFeedback.lightImpact();
          context.pushNamed(
            'summary',
            pathParameters: {'id': widget.material.id!.toString()},
            extra: widget.material,
          );
        },
      ),
      _AIToolInfo(
        title: 'Research Comparison',
        subtitle: 'Compare with the latest research findings',
        icon: Icons.science_rounded,
        color: Colors.purple.shade600,
        isPremium: true,
        onTap: () {
          HapticFeedback.lightImpact();
          context.pushNamed(
            'compare',
            pathParameters: {'id': widget.material.id!.toString()},
          );
        },
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.auto_awesome_rounded,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Text(
              'AI Tools',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Enhance your learning with AI-powered features',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 20),
        ...aiTools.asMap().entries.map((entry) {
          final index = entry.key;
          final tool = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _AIToolCard(
              tool: tool,
              delay: Duration(milliseconds: index * 150),
              staggerController: _staggerController,
            ),
          );
        }),
      ],
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
      case 'txt':
        return Icons.text_snippet_rounded;
      default:
        return Icons.insert_drive_file_rounded;
    }
  }

  Color _getFileColor(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return Colors.red.shade600;
      case 'docx':
      case 'doc':
        return Colors.blue.shade600;
      case 'pptx':
      case 'ppt':
        return Colors.orange.shade600;
      case 'txt':
        return Colors.green.shade600;
      default:
        return Colors.grey.shade600;
    }
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

class _AIToolInfo {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isPremium;
  final VoidCallback onTap;

  _AIToolInfo({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.isPremium,
    required this.onTap,
  });
}

class _AIToolCard extends StatefulWidget {
  final _AIToolInfo tool;
  final Duration delay;
  final AnimationController staggerController;

  const _AIToolCard({
    required this.tool,
    required this.delay,
    required this.staggerController,
  });

  @override
  State<_AIToolCard> createState() => _AIToolCardState();
}

class _AIToolCardState extends State<_AIToolCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.outline.withAlpha(52),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withAlpha(13),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: widget.tool.onTap,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.tool.color,
                            widget.tool.color.withAlpha(206),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: widget.tool.color.withAlpha(77),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        widget.tool.icon,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.tool.title,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              if (widget.tool.isPremium) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.amber.shade600,
                                        Colors.orange.shade600,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'PRO',
                                        style: theme.textTheme.labelSmall
                                            ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.tool.subtitle,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: theme.colorScheme.outline,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
