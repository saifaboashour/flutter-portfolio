import 'package:flutter/material.dart';

import '../core/constants/breakpoints.dart';
import '../core/constants/nav_items.dart';
import '../core/content/portfolio_data.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../features/about/about_section.dart';
import '../features/contact/contact_section.dart';
import '../features/experience/experience_section.dart';
import '../features/home/home_section.dart';
import '../features/projects/projects_section.dart';
import '../features/skills/skills_section.dart';
import '../shared/widgets/mobile_navigation.dart';
import '../shared/widgets/section_block.dart';
import '../shared/widgets/side_navigation.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => PortfolioPageState();
}

class PortfolioPageState extends State<PortfolioPage> {
  final _scrollController = ScrollController();
  final _profile = PortfolioData.profile;

  late final Map<PortfolioSection, GlobalKey> _sectionKeys = {
    for (final section in PortfolioSection.values) section: GlobalKey(),
  };

  PortfolioSection _activeSection = PortfolioSection.home;
  bool _isScrollingProgrammatically = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isScrollingProgrammatically) return;

    PortfolioSection? closest;
    var closestDistance = double.infinity;

    for (final entry in _sectionKeys.entries) {
      final context = entry.value.currentContext;
      if (context == null) continue;
      final box = context.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) continue;

      final offset = box.localToGlobal(Offset.zero).dy;
      final distance = (offset - 120).abs();
      if (distance < closestDistance) {
        closestDistance = distance;
        closest = entry.key;
      }
    }

    if (closest != null && closest != _activeSection) {
      setState(() => _activeSection = closest!);
    }
  }

  Future<void> scrollToSection(PortfolioSection section) async {
    final keyContext = _sectionKeys[section]?.currentContext;
    if (keyContext == null) return;

    setState(() {
      _activeSection = section;
      _isScrollingProgrammatically = true;
    });

    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    await Scrollable.ensureVisible(
      keyContext,
      duration: reduceMotion
          ? Duration.zero
          : const Duration(milliseconds: 520),
      curve: Curves.easeInOutCubic,
      alignment: 0.05,
    );

    if (!mounted) return;
    setState(() => _isScrollingProgrammatically = false);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = Breakpoints.isCompact(width);

    return Scaffold(
      backgroundColor: AppColors.charcoal,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            compact ? AppSpacing.sm : AppSpacing.shellPadding,
          ),
          child: compact ? _buildCompact() : _buildDesktop(),
        ),
      ),
    );
  }

  Widget _buildDesktop() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.outline),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SideNavigation(
              monogram: _profile.monogram,
              activeSection: _activeSection,
              onSelect: scrollToSection,
            ),
            Container(width: 1, color: AppColors.outline),
            Expanded(child: _buildScrollContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildCompact() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.outline),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Column(
          children: [
            MobileTopBar(
              monogram: _profile.monogram,
              activeSection: _activeSection,
              onSelect: scrollToSection,
            ),
            Expanded(child: _buildScrollContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollContent() {
    return SelectionArea(
      child: PrimaryScrollController(
        controller: _scrollController,
        child: Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppSpacing.contentMaxWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SectionBlock(
                      sectionKey: _sectionKeys[PortfolioSection.home]!,
                      child: HomeSection(
                        profile: _profile,
                        onViewProjects: () =>
                            scrollToSection(PortfolioSection.projects),
                      ),
                    ),
                    SectionBlock(
                      sectionKey: _sectionKeys[PortfolioSection.about]!,
                      child: AboutSection(profile: _profile),
                    ),
                    SectionBlock(
                      sectionKey: _sectionKeys[PortfolioSection.experience]!,
                      child: ExperienceSection(
                        experiences: _profile.experiences,
                      ),
                    ),
                    SectionBlock(
                      sectionKey: _sectionKeys[PortfolioSection.projects]!,
                      child: ProjectsSection(projects: _profile.projects),
                    ),
                    SectionBlock(
                      sectionKey: _sectionKeys[PortfolioSection.skills]!,
                      child: SkillsSection(
                        categories: _profile.skillCategories,
                      ),
                    ),
                    SectionBlock(
                      sectionKey: _sectionKeys[PortfolioSection.contact]!,
                      child: ContactSection(profile: _profile),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.xl,
                        0,
                        AppSpacing.xl,
                        AppSpacing.lg,
                      ),
                      child: Text(
                        '© ${DateTime.now().year} ${_profile.name}',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
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
