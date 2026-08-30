// lib/routing/app_layout.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studium_client/studium_client.dart';
import '../core/layout/responsive.dart';
import '../features/profile/providers/profile_provider.dart';
import 'dart:math' as math;

class AppLayout extends ConsumerWidget {
  final Widget child;

  const AppLayout({required this.child, super.key});

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/collaboration')) return 1;
    if (location.startsWith('/materials')) return 2;
    if (location.startsWith('/writer')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final selectedIndex = _calculateSelectedIndex(context);

    return profileState.when(
      data: (bundle) => ResponsiveScaffold(
        mobile: _MobileLayout(
          selectedIndex: selectedIndex,
          child: child,
        ),
        tablet: _TabletLayout(
          selectedIndex: selectedIndex,
          child: child,
        ),
        desktop: _DesktopLayout(
          selectedIndex: selectedIndex,
          bundle: bundle,
          child: child,
        ),
      ),
      loading: () => _buildNeuralLoadingScreen(context),
      error: (error, stackTrace) =>
          _buildNeuralErrorScreen(context, error.toString()),
    );
  }

  Widget _buildNeuralLoadingScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
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
              child: _NeuralLoadingBackground(),
            ),

            // Loading Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Neural Logo Container
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4FC3F7).withAlpha(104),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.psychology_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Neural Loading Indicator
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor:
                          const AlwaysStoppedAnimation(Color(0xFF4FC3F7)),
                      backgroundColor: Colors.white.withAlpha(26),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Loading Text
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
                    ).createShader(bounds),
                    child: const Text(
                      'Initializing Neural Network...',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Connecting to Studium AI',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(178),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeuralErrorScreen(BuildContext context, String error) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE91E63), Color(0xFFFF5722)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE91E63).withAlpha(104),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.error_outline_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFFE91E63), Color(0xFFFF5722)],
                  ).createShader(bounds),
                  child: const Text(
                    'Neural Network Error',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SelectableText(
                  error,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(178),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// NEURAL MOBILE LAYOUT
class _MobileLayout extends StatefulWidget {
  final int selectedIndex;
  final Widget child;

  const _MobileLayout({required this.selectedIndex, required this.child});

  @override
  State<_MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<_MobileLayout>
    with TickerProviderStateMixin {
  late AnimationController _neuralController;

  @override
  void initState() {
    super.initState();
    _neuralController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _neuralController.dispose();
    super.dispose();
  }

  void _onItemTapped(BuildContext context, int index) {
    HapticFeedback.lightImpact();
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/collaboration');
        break;
      case 2:
        context.go('/materials');
        break;
      case 3:
        context.go('/writer');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
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
            SafeArea(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.1, 0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      )),
                      child: child,
                    ),
                  );
                },
                child: Container(
                  key: ValueKey(widget.selectedIndex),
                  child: widget.child,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1F2E),
              Color(0xFF0A0E1A),
            ],
          ),
          border: Border(
            top: BorderSide(
              color: const Color(0xFF4FC3F7).withAlpha(52),
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(77),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NeuralMobileNavItem(
                  icon: Icons.dashboard_outlined,
                  selectedIcon: Icons.dashboard_rounded,
                  label: 'Neural Hub',
                  isSelected: widget.selectedIndex == 0,
                  onTap: () => _onItemTapped(context, 0),
                ),
                _NeuralMobileNavItem(
                  icon: Icons.groups_outlined,
                  selectedIcon: Icons.groups_rounded,
                  label: 'Communities',
                  isSelected: widget.selectedIndex == 1,
                  onTap: () => _onItemTapped(context, 1),
                ),
                _NeuralMobileNavItem(
                  icon: Icons.folder_copy_outlined,
                  selectedIcon: Icons.folder_copy_rounded,
                  label: 'Data Bank',
                  isSelected: widget.selectedIndex == 2,
                  onTap: () => _onItemTapped(context, 2),
                ),
                _NeuralMobileNavItem(
                  icon: Icons.edit_document,
                  selectedIcon: Icons.edit_document,
                  label: 'AI Writer',
                  isSelected: widget.selectedIndex == 3,
                  onTap: () => _onItemTapped(context, 3),
                  hasNewBadge: true,
                ),
                _NeuralMobileNavItem(
                  icon: Icons.person_outlined,
                  selectedIcon: Icons.person_rounded,
                  label: 'Neural ID',
                  isSelected: widget.selectedIndex == 4,
                  onTap: () => _onItemTapped(context, 4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Neural Mobile Navigation Item
class _NeuralMobileNavItem extends StatefulWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool hasNewBadge;

  const _NeuralMobileNavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.hasNewBadge = false,
  });

  @override
  State<_NeuralMobileNavItem> createState() => _NeuralMobileNavItemState();
}

class _NeuralMobileNavItemState extends State<_NeuralMobileNavItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
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
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        onTap: widget.onTap,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: widget.isSelected
                            ? const LinearGradient(
                                colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
                              )
                            : null,
                        color: widget.isSelected ? null : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: widget.isSelected
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF4FC3F7).withAlpha(104),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: Icon(
                        widget.isSelected ? widget.selectedIcon : widget.icon,
                        color: widget.isSelected
                            ? Colors.white
                            : Colors.white.withAlpha(152),
                        size: 24,
                      ),
                    ),
                    if (widget.hasNewBadge)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFE91E63), Color(0xFFFF5722)],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFE91E63).withAlpha(104),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const SizedBox(width: 6, height: 6),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    fontSize: 12,
                    color: widget.isSelected
                        ? Colors.white
                        : Colors.white.withAlpha(152),
                    fontWeight:
                        widget.isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  child: Text(widget.label),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// NEURAL TABLET LAYOUT
class _TabletLayout extends StatefulWidget {
  final int selectedIndex;
  final Widget child;

  const _TabletLayout({required this.selectedIndex, required this.child});

  @override
  State<_TabletLayout> createState() => _TabletLayoutState();
}

class _TabletLayoutState extends State<_TabletLayout>
    with TickerProviderStateMixin {
  late AnimationController _neuralController;

  @override
  void initState() {
    super.initState();
    _neuralController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _neuralController.dispose();
    super.dispose();
  }

  void _onDestinationSelected(BuildContext context, int index) {
    HapticFeedback.lightImpact();
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/collaboration');
        break;
      case 2:
        context.go('/materials');
        break;
      case 3:
        context.go('/writer');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
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

            // Main Layout
            Row(
              children: [
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF1A1F2E),
                        Color(0xFF0A0E1A),
                      ],
                    ),
                    border: Border(
                      right: BorderSide(
                        color: const Color(0xFF4FC3F7).withAlpha(52),
                        width: 1,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(77),
                        blurRadius: 10,
                        offset: const Offset(2, 0),
                      ),
                    ],
                  ),
                  child: NavigationRail(
                    selectedIndex: widget.selectedIndex,
                    onDestinationSelected: (index) =>
                        _onDestinationSelected(context, index),
                    labelType: NavigationRailLabelType.selected,
                    backgroundColor: Colors.transparent,
                    selectedIconTheme: const IconThemeData(
                      color: Colors.white,
                    ),
                    selectedLabelTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedIconTheme: IconThemeData(
                      color: Colors.white.withAlpha(152),
                    ),
                    indicatorColor: const Color(0xFF4FC3F7).withAlpha(77),
                    destinations: [
                      const NavigationRailDestination(
                        icon: Icon(Icons.dashboard_outlined),
                        selectedIcon: Icon(Icons.dashboard_rounded),
                        label: Text('Neural Hub'),
                      ),
                      const NavigationRailDestination(
                        icon: Icon(Icons.groups_outlined),
                        selectedIcon: Icon(Icons.groups_rounded),
                        label: Text('Communities'),
                      ),
                      const NavigationRailDestination(
                        icon: Icon(Icons.folder_copy_outlined),
                        selectedIcon: Icon(Icons.folder_copy_rounded),
                        label: Text('Data Bank'),
                      ),
                      NavigationRailDestination(
                        icon: Stack(
                          children: [
                            const Icon(Icons.edit_document),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFE91E63),
                                      Color(0xFFFF5722)
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        selectedIcon: Stack(
                          children: [
                            const Icon(Icons.edit_document),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFE91E63),
                                      Color(0xFFFF5722)
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        label: const Text('AI Writer'),
                      ),
                      const NavigationRailDestination(
                        icon: Icon(Icons.person_outlined),
                        selectedIcon: Icon(Icons.person_rounded),
                        label: Text('Neural ID'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.1, 0),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          )),
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      key: ValueKey(widget.selectedIndex),
                      child: widget.child,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// NEURAL DESKTOP LAYOUT
class _DesktopLayout extends ConsumerStatefulWidget {
  final int selectedIndex;
  final UserProfileBundle bundle;
  final Widget child;

  const _DesktopLayout({
    required this.selectedIndex,
    required this.bundle,
    required this.child,
  });

  @override
  ConsumerState<_DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends ConsumerState<_DesktopLayout>
    with TickerProviderStateMixin {
  late AnimationController _neuralController;
  late AnimationController _logoController;
  late Animation<double> _logoRotation;

  @override
  void initState() {
    super.initState();
    _neuralController = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat();
    _logoController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();

    _logoRotation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _neuralController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  void _onItemTapped(BuildContext context, int index) {
    HapticFeedback.lightImpact();
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/collaboration');
        break;
      case 2:
        context.go('/materials');
        break;
      case 3:
        context.go('/writer');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
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

            // Main Layout
            Row(
              children: [
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF1A1F2E),
                        Color(0xFF0A0E1A),
                      ],
                    ),
                    border: Border(
                      right: BorderSide(
                        color: const Color(0xFF4FC3F7).withAlpha(52),
                        width: 1,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(77),
                        blurRadius: 15,
                        offset: const Offset(2, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Neural Header Section
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF4FC3F7).withAlpha(26),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Row(
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
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFF4FC3F7)
                                                .withAlpha(77),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Brain Logo Container
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF4FC3F7),
                                            Color(0xFF7C4DFF),
                                          ],
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF4FC3F7)
                                                .withAlpha(104),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.psychology_rounded,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShaderMask(
                                    shaderCallback: (bounds) =>
                                        const LinearGradient(
                                      colors: [
                                        Color(0xFF4FC3F7),
                                        Color(0xFF7C4DFF)
                                      ],
                                    ).createShader(bounds),
                                    child: const Text(
                                      'Studium AI',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Neural Learning Platform',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withAlpha(178),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: ListView(
                          children: [
                            _NeuralDesktopNavItem(
                              icon: Icons.dashboard_outlined,
                              selectedIcon: Icons.dashboard_rounded,
                              label: 'Neural Dashboard',
                              isSelected: widget.selectedIndex == 0,
                              onTap: () => _onItemTapped(context, 0),
                            ),
                            _NeuralDesktopNavItem(
                              icon: Icons.groups_outlined,
                              selectedIcon: Icons.groups_rounded,
                              label: 'Study Communities',
                              isSelected: widget.selectedIndex == 1,
                              onTap: () => _onItemTapped(context, 1),
                            ),
                            _NeuralDesktopNavItem(
                              icon: Icons.folder_copy_outlined,
                              selectedIcon: Icons.folder_copy_rounded,
                              label: 'Neural Data Bank',
                              isSelected: widget.selectedIndex == 2,
                              onTap: () => _onItemTapped(context, 2),
                            ),
                            _NeuralDesktopNavItem(
                              icon: Icons.edit_document,
                              selectedIcon: Icons.edit_document,
                              label: 'AI Neural Writer',
                              isSelected: widget.selectedIndex == 3,
                              onTap: () => _onItemTapped(context, 3),
                              badge: 'NEW',
                            ),
                            _NeuralDesktopNavItem(
                              icon: Icons.person_outlined,
                              selectedIcon: Icons.person_rounded,
                              label: 'Neural Profile',
                              isSelected: widget.selectedIndex == 4,
                              onTap: () => _onItemTapped(context, 4),
                            ),
                          ],
                        ),
                      ),

                      // Neural User Profile Section
                      Container(
                        margin: const EdgeInsets.all(16),
                        child: _NeuralUserProfileSection(bundle: widget.bundle),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.05, 0),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          )),
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      key: ValueKey(widget.selectedIndex),
                      child: widget.child,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Neural Desktop Navigation Item Widget
class _NeuralDesktopNavItem extends StatefulWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final String? badge;

  const _NeuralDesktopNavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.badge,
  });

  @override
  State<_NeuralDesktopNavItem> createState() => _NeuralDesktopNavItemState();
}

class _NeuralDesktopNavItemState extends State<_NeuralDesktopNavItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              gradient: widget.isSelected
                  ? const LinearGradient(
                      colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
                    )
                  : _isHovered
                      ? LinearGradient(
                          colors: [
                            Colors.white.withAlpha(26),
                            Colors.white.withAlpha(13),
                          ],
                        )
                      : null,
              borderRadius: BorderRadius.circular(12),
              border: widget.isSelected
                  ? Border.all(
                      color: const Color(0xFF4FC3F7).withAlpha(128),
                      width: 1,
                    )
                  : null,
              boxShadow: widget.isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xFF4FC3F7).withAlpha(77),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                onTapDown: (_) => _controller.forward(),
                onTapUp: (_) => _controller.reverse(),
                onTapCancel: () => _controller.reverse(),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Icon(
                        widget.isSelected ? widget.selectedIcon : widget.icon,
                        color: widget.isSelected
                            ? Colors.white
                            : Colors.white.withAlpha(178),
                        size: 24,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          widget.label,
                          style: TextStyle(
                            color: widget.isSelected
                                ? Colors.white
                                : Colors.white.withAlpha(178),
                            fontWeight: widget.isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      if (widget.badge != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFE91E63), Color(0xFFFF5722)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFE91E63).withAlpha(104),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            widget.badge!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Neural User Profile Section for Desktop
class _NeuralUserProfileSection extends ConsumerWidget {
  final UserProfileBundle bundle;

  const _NeuralUserProfileSection({required this.bundle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = bundle.profile;
    final isPremium = profile.role == 'premium';

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isPremium
              ? [
                  const Color(0xFFFFB300).withAlpha(52),
                  const Color(0xFFFF8F00).withAlpha(26),
                ]
              : [
                  Colors.white.withAlpha(26),
                  Colors.white.withAlpha(13),
                ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPremium
              ? const Color(0xFFFFB300).withAlpha(77)
              : const Color(0xFF4FC3F7).withAlpha(52),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(52),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isPremium
                        ? const LinearGradient(
                            colors: [Color(0xFFFFB300), Color(0xFFFF8F00)],
                          )
                        : const LinearGradient(
                            colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
                          ),
                    boxShadow: [
                      BoxShadow(
                        color: (isPremium
                                ? const Color(0xFFFFB300)
                                : const Color(0xFF4FC3F7))
                            .withAlpha(104),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.transparent,
                    child: Text(
                      profile.name?.substring(0, 1).toUpperCase() ?? 'U',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name ?? 'Neural User',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: isPremium
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFFFFB300),
                                    Color(0xFFFF8F00)
                                  ],
                                )
                              : const LinearGradient(
                                  colors: [
                                    Color(0xFF4FC3F7),
                                    Color(0xFF7C4DFF)
                                  ],
                                ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isPremium) ...[
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.white,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                            ] else ...[
                              const Icon(
                                Icons.psychology_rounded,
                                color: Colors.white,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                            ],
                            Text(
                              isPremium ? 'NEURAL PREMIUM' : 'NEURAL USER',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _NeuralProfileActionButton(
                    icon: Icons.settings_rounded,
                    label: 'Settings',
                    onTap: () {
                      HapticFeedback.lightImpact();
                      context.pushNamed('settings');
                    },
                  ),
                ),
                const SizedBox(width: 12),
                _NeuralProfileActionButton(
                  icon: Icons.logout_rounded,
                  label: '',
                  onTap: () => _showNeuralSignOutDialog(context, ref),
                  isIconOnly: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showNeuralSignOutDialog(
      BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1F2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
          ).createShader(bounds),
          child: const Text(
            'Disconnect Neural Link?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: Text(
          'Are you sure you want to disconnect from your neural learning session?',
          style: TextStyle(
            color: Colors.white.withAlpha(204),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white.withAlpha(178),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE91E63), Color(0xFFFF5722)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Disconnect',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      HapticFeedback.mediumImpact();
      ref.read(signOutProvider)();
    }
  }
}

class _NeuralProfileActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isIconOnly;

  const _NeuralProfileActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isIconOnly = false,
  });

  @override
  State<_NeuralProfileActionButton> createState() =>
      _NeuralProfileActionButtonState();
}

class _NeuralProfileActionButtonState extends State<_NeuralProfileActionButton>
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
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
      child: Material(
        color: Colors.white.withAlpha(26),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: widget.onTap,
          onTapDown: (_) => _controller.forward(),
          onTapUp: (_) => _controller.reverse(),
          onTapCancel: () => _controller.reverse(),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.all(widget.isIconOnly ? 8 : 12),
            child: widget.isIconOnly
                ? Icon(
                    widget.icon,
                    size: 16,
                    color: Colors.white.withAlpha(204),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        widget.icon,
                        size: 16,
                        color: Colors.white.withAlpha(204),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.label,
                        style: TextStyle(
                          color: Colors.white.withAlpha(204),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
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

    for (int i = 0; i < 10; i++) {
      nodes.add(Offset(
        random.nextDouble() * size.width,
        random.nextDouble() * size.height,
      ));
    }

    // Draw connections with animation
    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final distance = (nodes[i] - nodes[j]).distance;
        if (distance < 80) {
          final opacity = (1 - distance / 80) * 0.1;
          paint.color = connectionColor.withValues(
              alpha: opacity *
                  (0.5 + 0.5 * math.sin(animation.value * 2 * math.pi + i)));
          canvas.drawLine(nodes[i], nodes[j], paint);
        }
      }
    }

    // Draw nodes with pulsing animation
    for (int i = 0; i < nodes.length; i++) {
      final pulseScale =
          1 + 0.2 * math.sin(animation.value * 2 * math.pi + i * 0.5);
      final radius = 1.5 * pulseScale;
      nodePaint.color = nodeColor.withAlpha(52);
      canvas.drawCircle(nodes[i], radius, nodePaint);

      // Inner glow
      nodePaint.color = nodeColor.withAlpha(104);
      canvas.drawCircle(nodes[i], radius * 0.5, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Neural Loading Background
class _NeuralLoadingBackground extends StatefulWidget {
  @override
  State<_NeuralLoadingBackground> createState() =>
      _NeuralLoadingBackgroundState();
}

class _NeuralLoadingBackgroundState extends State<_NeuralLoadingBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _NeuralNetworkPainter(
            animation: _controller,
            nodeColor: const Color(0xFF4FC3F7),
            connectionColor: const Color(0xFF7C4DFF),
          ),
        );
      },
    );
  }
}
