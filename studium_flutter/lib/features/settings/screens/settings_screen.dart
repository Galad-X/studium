import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../api/serverpod_client.dart';
import '../../../core/providers/theme_provider.dart';
import '../../profile/providers/profile_provider.dart';
import '../../../services/export_service.dart';

const _privacyUrl = String.fromEnvironment('STUDIUM_PRIVACY_URL');
const _termsUrl = String.fromEnvironment('STUDIUM_TERMS_URL');
const _supportEmail = String.fromEnvironment(
  'STUDIUM_SUPPORT_EMAIL',
  defaultValue: 'support@studium.app',
);

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _backgroundController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _backgroundAnimation;
  final _nameController = TextEditingController();
  final _preferences = SharedPreferencesAsync();
  bool _pushAlerts = true;
  bool _progressReports = false;
  bool _studyReminders = true;
  bool _analyticsOptOut = false;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider).valueOrNull?.profile;
    if (profile != null) {
      _nameController.text = profile.name ?? '';
    }
    _loadSettings();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _backgroundAnimation = CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.linear,
    );

    _slideController.forward();
  }

  Future<void> _loadSettings() async {
    final values = await Future.wait<bool?>([
      _preferences.getBool('settings.push_alerts'),
      _preferences.getBool('settings.progress_reports'),
      _preferences.getBool('settings.study_reminders'),
      _preferences.getBool('settings.analytics_opt_out'),
    ]);
    if (!mounted) return;
    setState(() {
      _pushAlerts = values[0] ?? true;
      _progressReports = values[1] ?? false;
      _studyReminders = values[2] ?? true;
      _analyticsOptOut = values[3] ?? false;
    });
  }

  Future<void> _setPreference(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  @override
  void dispose() {
    _slideController.dispose();
    _backgroundController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    final newName = _nameController.text.trim();
    if (newName.isEmpty) {
      _showErrorSnackBar('Neural Error: Name cannot be empty');
      return;
    }

    try {
      await client.user.updateProfile(name: newName);
      ref.invalidate(profileProvider);
      if (mounted) {
        _showSuccessSnackBar('Neural profile updated successfully! 🧠');
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Neural Error: Failed to update profile - $e');
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: const Color(0xFFFF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: const Color(0xFF00D4AA),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Stack(
        children: [
          // Neural network background
          AnimatedBuilder(
            animation: _backgroundAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: NeuralNetworkPainter(_backgroundAnimation.value),
                size: Size.infinite,
              );
            },
          ),
          SafeArea(
            child: Column(
              children: [
                // Neural App Bar
                _buildNeuralAppBar(),
                Expanded(
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Neural Header
                          _buildNeuralHeader(),
                          const SizedBox(height: 32),

                          // Neural Account Section
                          _buildNeuralAccountSection(),
                          const SizedBox(height: 24),

                          // Neural Appearance Section
                          _buildNeuralAppearanceSection(themeMode, ref),
                          const SizedBox(height: 24),

                          // Neural Notifications Section
                          _buildNeuralNotificationsSection(),
                          const SizedBox(height: 24),

                          // Neural Privacy Section
                          _buildNeuralPrivacySection(),
                          const SizedBox(height: 24),

                          // Neural About Section
                          _buildNeuralAboutSection(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNeuralAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          ),
          const SizedBox(width: 8),
          AnimatedBuilder(
            animation: _backgroundAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _backgroundAnimation.value * 2 * 3.14159,
                child: const Icon(
                  Icons.settings_rounded,
                  color: Color(0xFF00D4AA),
                  size: 24,
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          const Text(
            'Neural Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNeuralHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1A2E),
            Color(0xFF16213E),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF00D4AA).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF00D4AA).withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: AnimatedBuilder(
              animation: _backgroundAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_backgroundAnimation.value * 0.1),
                  child: const Icon(
                    Icons.psychology_rounded,
                    size: 32,
                    color: Color(0xFF00D4AA),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Neural Configuration Center',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Customize your AI-powered learning experience',
                  style: TextStyle(
                    color: Color(0xFFB0B0B0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNeuralAccountSection() {
    return _NeuralSettingsSection(
      title: 'Neural Account',
      icon: Icons.person_rounded,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF00D4AA).withValues(alpha: 0.3),
                  ),
                ),
                child: TextField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Neural Identity Name',
                    labelStyle: TextStyle(color: Color(0xFF00D4AA)),
                    hintText: 'Enter your neural identity',
                    hintStyle: TextStyle(color: Color(0xFFB0B0B0)),
                    prefixIcon: Icon(Icons.psychology_rounded,
                        color: Color(0xFF00D4AA)),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Color(0xFF1A1A2E),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _updateProfile,
                icon: const Icon(Icons.save_rounded),
                label: const Text('Save Neural Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00D4AA),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNeuralAppearanceSection(ThemeMode themeMode, WidgetRef ref) {
    return _NeuralSettingsSection(
      title: 'Neural Interface',
      icon: Icons.palette_rounded,
      children: [
        _NeuralThemeSelector(
          currentTheme: themeMode,
          onThemeChanged: (newTheme) {
            HapticFeedback.selectionClick();
            ref.read(themeProvider.notifier).setTheme(newTheme);
          },
        ),
      ],
    );
  }

  Widget _buildNeuralNotificationsSection() {
    return _NeuralSettingsSection(
      title: 'Neural Notifications',
      icon: Icons.notifications_rounded,
      children: [
        _NeuralSettingsTile(
          title: 'Neural Push Alerts',
          subtitle: 'Get notified about AI analysis results',
          trailing: Switch(
            value: _pushAlerts,
            onChanged: (value) async {
              HapticFeedback.lightImpact();
              setState(() => _pushAlerts = value);
              await _setPreference('settings.push_alerts', value);
            },
            activeThumbColor: const Color(0xFF00D4AA),
          ),
        ),
        _NeuralSettingsTile(
          title: 'Neural Progress Reports',
          subtitle: 'Weekly AI-powered learning insights',
          trailing: Switch(
            value: _progressReports,
            onChanged: (value) async {
              HapticFeedback.lightImpact();
              setState(() => _progressReports = value);
              await _setPreference('settings.progress_reports', value);
            },
            activeThumbColor: const Color(0xFF00D4AA),
          ),
        ),
        _NeuralSettingsTile(
          title: 'Neural Study Reminders',
          subtitle: 'AI-optimized study session alerts',
          trailing: Switch(
            value: _studyReminders,
            onChanged: (value) async {
              HapticFeedback.lightImpact();
              setState(() => _studyReminders = value);
              await _setPreference('settings.study_reminders', value);
            },
            activeThumbColor: const Color(0xFF00D4AA),
          ),
        ),
      ],
    );
  }

  Future<void> _showInfoDialog(String title, String message) async {
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _exportAccountData() async {
    try {
      final profile = ref.read(profileProvider).valueOrNull?.profile;
      final content = [
        'Studium account export',
        'Name: ${profile?.name ?? 'Unknown'}',
        'Role: ${profile?.role ?? 'Unknown'}',
        'Notifications: push=$_pushAlerts, progress=$_progressReports, reminders=$_studyReminders',
        'Analytics opt-out: $_analyticsOptOut',
      ].join('\n');
      final path = await ExportService().exportDocument(
        title: 'studium_account_export',
        content: content,
        format: ExportFormat.pdf,
      );
      if (!mounted) return;
      _showSuccessSnackBar('Account export created.');
      await ExportService().openFile(path);
    } catch (error) {
      if (mounted) _showErrorSnackBar('Export failed: $error');
    }
  }

  Future<void> _openConfiguredLink(String url, String title) async {
    if (url.isEmpty) {
      await _showInfoDialog(
        title,
        '$title is not configured for this build. Please contact your institution administrator.',
      );
      return;
    }
    final launched = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    if (!launched && mounted) _showErrorSnackBar('Could not open $title.');
  }

  Future<void> _openSupport() async {
    final launched = await launchUrl(
      Uri(scheme: 'mailto', path: _supportEmail),
      mode: LaunchMode.externalApplication,
    );
    if (!launched && mounted) _showErrorSnackBar('Could not open support email.');
  }

  Widget _buildNeuralPrivacySection() {
    return _NeuralSettingsSection(
      title: 'Neural Privacy',
      icon: Icons.security_rounded,
      children: [
        _NeuralSettingsTile(
          title: 'Neural Data Encryption',
          subtitle: 'Advanced AI data protection',
          trailing: const Icon(Icons.lock_rounded, color: Color(0xFF00D4AA)),
          onTap: () {
            HapticFeedback.lightImpact();
            _showInfoDialog(
              'Data encryption',
              'Studium uses encrypted transport for API calls. Stored account and collaboration data is protected by the server database and access-control policies.',
            );
          },
        ),
        _NeuralSettingsTile(
          title: 'Neural Analytics Opt-out',
          subtitle: 'Control AI learning data usage',
          trailing:
              Switch(
                value: _analyticsOptOut,
                onChanged: (value) async {
                  HapticFeedback.lightImpact();
                  setState(() => _analyticsOptOut = value);
                  await _setPreference('settings.analytics_opt_out', value);
                },
              ),
          onTap: () {
            HapticFeedback.lightImpact();
            _showInfoDialog(
              'Analytics controls',
              _analyticsOptOut
                  ? 'Optional product analytics are disabled on this device.'
                  : 'Optional product analytics are enabled. You can disable them with the switch.',
            );
          },
        ),
        _NeuralSettingsTile(
          title: 'Neural Data Export',
          subtitle: 'Download your AI learning data',
          trailing:
              const Icon(Icons.download_rounded, color: Color(0xFF00D4AA)),
          onTap: () {
            HapticFeedback.lightImpact();
            _exportAccountData();
          },
        ),
      ],
    );
  }

  Widget _buildNeuralAboutSection() {
    return _NeuralSettingsSection(
      title: 'Neural System Info',
      icon: Icons.info_rounded,
      children: [
        _NeuralSettingsTile(
          title: 'Neural Engine Version',
          subtitle: 'v2.1.0 (Neural Build 42)',
          onTap: () {
            HapticFeedback.lightImpact();
            _showInfoDialog(
              'System information',
              'Studium collaboration client\nBuild metadata is supplied by the release pipeline.',
            );
          },
        ),
        _NeuralSettingsTile(
          title: 'Neural Privacy Policy',
          subtitle: 'AI data protection guidelines',
          trailing:
              const Icon(Icons.chevron_right_rounded, color: Color(0xFFB0B0B0)),
          onTap: () {
            HapticFeedback.lightImpact();
            _openConfiguredLink(_privacyUrl, 'Privacy policy');
          },
        ),
        _NeuralSettingsTile(
          title: 'Neural Terms of Service',
          subtitle: 'AI learning platform agreement',
          trailing:
              const Icon(Icons.chevron_right_rounded, color: Color(0xFFB0B0B0)),
          onTap: () {
            HapticFeedback.lightImpact();
            _openConfiguredLink(_termsUrl, 'Terms of service');
          },
        ),
        _NeuralSettingsTile(
          title: 'Neural Support Center',
          subtitle: 'Get help with AI features',
          trailing:
              const Icon(Icons.support_agent_rounded, color: Color(0xFF00D4AA)),
          onTap: () {
            HapticFeedback.lightImpact();
            _openSupport();
          },
        ),
      ],
    );
  }
}

class _NeuralSettingsSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _NeuralSettingsSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1A2E),
            Color(0xFF16213E),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF00D4AA).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFF00D4AA)),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

class _NeuralSettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _NeuralSettingsTile({
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8, left: 20, right: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0F).withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF00D4AA).withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFB0B0B0),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NeuralThemeSelector extends StatelessWidget {
  final ThemeMode currentTheme;
  final ValueChanged<ThemeMode> onThemeChanged;

  const _NeuralThemeSelector({
    required this.currentTheme,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final themeOptions = [
      _NeuralThemeOption(
        mode: ThemeMode.system,
        title: 'Neural Auto-Adapt',
        subtitle: 'AI-powered theme switching',
        icon: Icons.auto_awesome_rounded,
      ),
      _NeuralThemeOption(
        mode: ThemeMode.light,
        title: 'Neural Light Mode',
        subtitle: 'Optimized for daylight learning',
        icon: Icons.light_mode_rounded,
      ),
      _NeuralThemeOption(
        mode: ThemeMode.dark,
        title: 'Neural Dark Mode',
        subtitle: 'Enhanced focus interface',
        icon: Icons.dark_mode_rounded,
      ),
    ];

    return Column(
      children: themeOptions.map((option) {
        final isSelected = currentTheme == option.mode;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
              gradient: isSelected
                  ? const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF00D4AA),
                        Color(0xFF00B894),
                      ],
                    )
                  : null,
              color: isSelected
                  ? null
                  : const Color(0xFF0A0A0F).withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF00D4AA)
                    : const Color(0xFF00D4AA).withValues(alpha: 0.1),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => onThemeChanged(option.mode),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white.withValues(alpha: 0.2)
                              : const Color(0xFF00D4AA).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          option.icon,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF00D4AA),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              option.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              option.subtitle,
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected
                                    ? Colors.white.withValues(alpha: 0.8)
                                    : const Color(0xFFB0B0B0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked_rounded
                            : Icons.radio_button_unchecked_rounded,
                        color:
                            isSelected ? Colors.white : const Color(0xFFB0B0B0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _NeuralThemeOption {
  final ThemeMode mode;
  final String title;
  final String subtitle;
  final IconData icon;

  _NeuralThemeOption({
    required this.mode,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class NeuralNetworkPainter extends CustomPainter {
  final double animationValue;

  NeuralNetworkPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00D4AA).withValues(alpha: 0.1)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final nodePaint = Paint()
      ..color = const Color(0xFF00D4AA).withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    // Draw neural network connections
    for (int i = 0; i < 20; i++) {
      final startX = (i * size.width / 20) + (animationValue * 50);
      final startY = size.height * 0.3 + (i % 3) * size.height * 0.2;

      for (int j = 0; j < 15; j++) {
        final endX = (j * size.width / 15) + (animationValue * 30);
        final endY = size.height * 0.7 + (j % 2) * size.height * 0.1;

        if ((i + j) % 4 == 0) {
          canvas.drawLine(
            Offset(startX % size.width, startY),
            Offset(endX % size.width, endY),
            paint,
          );
        }
      }
    }

    // Draw neural nodes
    for (int i = 0; i < 30; i++) {
      final x = (i * size.width / 30 + animationValue * 20) % size.width;
      final y = size.height * 0.2 + (i % 5) * size.height * 0.15;

      canvas.drawCircle(
        Offset(x, y),
        2.0 + (animationValue * 2),
        nodePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
