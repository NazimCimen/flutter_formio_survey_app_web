import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThemeIconTile extends StatefulWidget {
  const ThemeIconTile({super.key, this.isDark = false, this.onPressed});

  final bool isDark;
  final Function()? onPressed;

  @override
  State<ThemeIconTile> createState() => _ThemeIconTileState();
}

class _ThemeIconTileState extends State<ThemeIconTile> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: _isHover ? Colors.white : Color(0xFFEFEFEF).withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(16.0 * 0.25),
      child: InkWell(
        onTap: widget.onPressed,
        onHover: (value) {
          setState(() {
            _isHover = value;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 2,
              )
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              widget.isDark
                  ? 'assets/images/moon_filled.svg'
                  : 'assets/images/sun_filled.svg',
              height: 24,
              width: 24,
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
