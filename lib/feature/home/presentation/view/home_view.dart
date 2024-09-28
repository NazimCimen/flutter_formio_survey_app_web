import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/feature/home/presentation/widgets/feature_section/features_section_tablet.dart';
import 'package:flutter_survey_app_web/feature/home/presentation/widgets/footer_section/footer_section.dart';
import 'package:flutter_survey_app_web/feature/home/presentation/widgets/header/header_desktop.dart';
import 'package:flutter_survey_app_web/product/widgets/register_button_widget.dart';
import 'package:flutter_survey_app_web/product/widgets/theme_deneme.dart';
import 'package:flutter_survey_app_web/product/widgets/theme_widget.dart';
import 'package:flutter_survey_app_web/responsive/responsive.dart';
import 'package:flutter_survey_app_web/core/size/dynamic_size.dart';
import 'package:flutter_survey_app_web/core/utils/image_enum.dart';
import 'package:flutter_survey_app_web/feature/home/presentation/mixin/home_view_mixin.dart';
import 'package:flutter_survey_app_web/feature/home/presentation/widgets/home_section/home_section.dart';
import 'package:flutter_survey_app_web/feature/home/presentation/widgets/feature_section/features_section_desktop.dart';
import 'package:flutter_survey_app_web/feature/home/presentation/widgets/feature_section/feature_section_mobile.dart';
import 'package:flutter_survey_app_web/feature/home/presentation/widgets/use_case_section/use_case_section_desktop.dart';
import 'package:flutter_survey_app_web/feature/home/presentation/widgets/use_case_section/use_case_section.dart';
import 'package:flutter_survey_app_web/feature/home/presentation/widgets/header/header_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      key: scaffoldKey,
      drawer: isMobile ? HeaderDrawer(sectionNavButton: scrollToSection) : null,
      appBar: isMobile ? const _AppBar() : null,
      body: SafeArea(
        child: Stack(
          children: [
            _BodyContent(
              scrollController: scrollController,
              sectionKeys: sectionKeys,
              isMobile: isMobile,
            ),
            if (!isMobile)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: HeaderDesktop(
                  sectionNavButton: scrollToSection,
                ),
              )
          ],
        ),
      ),
    );
  }
}

class _BodyContent extends StatelessWidget {
  const _BodyContent({
    required this.scrollController,
    required this.sectionKeys,
    required this.isMobile,
  });

  final ScrollController scrollController;
  final List<GlobalKey<State<StatefulWidget>>> sectionKeys;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                key: sectionKeys.first,
                height: isMobile ? 20 : 100,
              ),
              HomeSection(isMobile: isMobile),
              Responsive(
                mobile: FeatureSectionMobile(key: sectionKeys[1]),
                tablet: FeaturesSectionTablet(key: sectionKeys[1]),
                desktop: FeaturesSectionDesktop(key: sectionKeys[1]),
              ),
              Responsive(
                mobile: UseCaseSection(key: sectionKeys[2]),
                tablet: UseCaseSection(key: sectionKeys[2]),
                desktop: UseCaseSectionDesktop(key: sectionKeys[2]),
              ),
              FooterSection(
                key: sectionKeys[3],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      forceMaterialTransparency: true,
      actions: [
        RegisterButtonWidget(
          navigateLogin: () {},
          navigateSignup: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
