import 'package:flutter/material.dart';

class HeaderDrawer extends StatelessWidget {
  final void Function(int) sectionNavButton;

  const HeaderDrawer({required this.sectionNavButton, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //elevation: 0,

      child: Column(
        children: <Widget>[
          _DrawerListTile(
            iconData: Icons.home_outlined,
            text: 'Home',
            onTapSection: () {
              sectionNavButton(0);
            },
          ),
          _DrawerListTile(
            iconData: Icons.star_outline,
            text: 'Features',
            onTapSection: () {
              sectionNavButton(1);
            },
          ),
          _DrawerListTile(
            iconData: Icons.sentiment_satisfied_outlined,
            text: 'Use Case',
            onTapSection: () {
              sectionNavButton(2);
            },
          ),
          _DrawerListTile(
            iconData: Icons.app_shortcut_outlined,
            text: 'About',
            onTapSection: () {
              sectionNavButton(3);
            },
          ),
          _DrawerListTile(
            iconData: Icons.app_shortcut_outlined,
            text: 'Tema',
            onTapSection: () {
              sectionNavButton(3);
            },
          ),
          _DrawerListTile(
            iconData: Icons.app_shortcut_outlined,
            text: 'Tema',
            onTapSection: () {
              sectionNavButton(3);
            },
          ),
        ],
      ),
    );
  }
}

class _DrawerListTile extends StatelessWidget {
  final IconData iconData;
  final String text;
  final VoidCallback onTapSection;
  const _DrawerListTile({
    required this.iconData,
    required this.text,
    required this.onTapSection,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData, color: Theme.of(context).colorScheme.onSurface),
      title: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      onTap: onTapSection,
    );
  }
}
