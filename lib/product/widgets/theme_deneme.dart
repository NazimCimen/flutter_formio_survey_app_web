import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThemeTabs extends StatefulWidget {
  const ThemeTabs({super.key});

  @override
  State<ThemeTabs> createState() => _ThemeTabsState();
}

class _ThemeTabsState extends State<ThemeTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _selectedIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        setState(() {
          _selectedIndex = _tabController.index;
        });
      });
    WidgetsBinding.instance.addPostFrameCallback((_) {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(8 * 5),
      ),
      child: TabBar(
        controller: _tabController,
        dividerHeight: 0,
        splashBorderRadius: BorderRadius.circular(8 * 5),
        padding: const EdgeInsets.symmetric(
          horizontal: 16 * 0.5,
          vertical: 16 * 0.5,
        ),
        indicator: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8 * 5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
            )
          ],
          color: Color(0xFFFCFCFC),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          TabWithIcon(
            index: 0,
            isSelected: _selectedIndex == 0,
            title: 'Light',
            iconSrc: 'assets/images/sun_filled.svg',
          ),
          TabWithIcon(
            index: 1,
            isSelected: _selectedIndex == 1,
            title: 'Dark',
            iconSrc: 'assets/images/moon_light.svg',
          ),
        ],
      ),
    );
  }
}

class TabWithIcon extends StatelessWidget {
  const TabWithIcon({
    super.key,
    required this.title,
    required this.iconSrc,
    required this.index,
    this.isSelected = false,
  });

  final bool isSelected;
  final int index;
  final String title, iconSrc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 16 * 0.25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          index == 0
              ? SvgPicture.asset(
                  iconSrc,
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    isSelected ? Color(0xFF1A1D1F) : Color(0xFF6F767E),
                    BlendMode.srcIn,
                  ),
                )
              : Image.asset(
                  'assets/images/moon.png',
                  height: 24,
                  width: 24,
                  /*  colorFilter: ColorFilter.mode(
                    isSelected ? Color(0xFF1A1D1F) : Color(0xFF6F767E),
                    BlendMode.srcIn,
                  ),*/
                  color: isSelected ? Color(0xFF1A1D1F) : Color(0xFF6F767E),
                ),
          SizedBox(width: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: isSelected ? Color(0xFF1A1D1F) : Color(0xFF6F767E),
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
