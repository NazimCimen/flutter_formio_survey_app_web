import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/feature/home/presentation/view/home_view.dart';

mixin HomeViewMixin on State<HomeView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> sectionKeys = List.generate(4, (index) => GlobalKey());

  void scrollToSection(int sectionIndex) {
    scaffoldKey.currentState?.closeDrawer();
    final key = sectionKeys[sectionIndex];
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
