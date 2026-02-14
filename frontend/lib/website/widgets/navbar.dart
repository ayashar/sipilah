import 'package:flutter/material.dart';

class NavbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const NavbarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
      leadingWidth: 120,

      leading: const Padding(
        padding: EdgeInsets.only(left: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "SIPILAH",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),

      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          NavItem(
            icon: Icons.dashboard,
            title: "Overview",
            route: "/overview",
            isActive: currentRoute == "/overview",
          ),

          NavItem(
            icon: Icons.analytics,
            title: "Analytics",
            route: "/analytics",
            isActive: currentRoute == "/analytics",
          ),

          NavItem(
            icon: Icons.account_balance_wallet,
            title: "Keuangan",
            route: "/keuangan",
            isActive: currentRoute == "/keuangan",
          ),

          const SizedBox(width: 24),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;
  final bool isActive;

  const NavItem({
    super.key,
    required this.icon,
    required this.title,
    required this.route,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? Colors.green : Colors.black87;

    return TextButton.icon(
      onPressed: () {
        if (!isActive) {
          Navigator.pushReplacementNamed(context, route);
        }
      },

      icon: Icon(icon, size: 20, color: color),

      label: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
