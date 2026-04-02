import 'package:flutter/material.dart';

void main() {
  runApp(const DrawerWidgetDemo());
}

class DrawerWidgetDemo extends StatelessWidget {
  const DrawerWidgetDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Drawer Widget',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),
      home: const DrawerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawerWidget(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color(0xFF6366F1),
            elevation: 0,
            floating: true,
            pinned: true,
            expandedHeight: 180.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.indigo.shade400, Colors.blue.shade400],
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.dashboard, size: 60, color: Colors.white54),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.indigo.shade50, Colors.blue.shade50],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.menu, size: 80, color: Color(0xFF6366F1)),
                    const SizedBox(height: 20),
                    Text(
                      'Tap the menu icon',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Swipe from left or tap hamburger menu',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDrawerWidget extends StatefulWidget {
  const CustomDrawerWidget({Key? key}) : super(key: key);

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int selectedIndex = 0;

  final List<DrawerItem> drawerItems = [
    DrawerItem(icon: Icons.home, label: 'Home', color: Colors.blue),
    DrawerItem(icon: Icons.person, label: 'Profile', color: Colors.purple),
    DrawerItem(icon: Icons.settings, label: 'Settings', color: Colors.orange),
    DrawerItem(
      icon: Icons.notifications,
      label: 'Notifications',
      color: Colors.red,
    ),
    DrawerItem(icon: Icons.message, label: 'Messages', color: Colors.green),
    DrawerItem(
      icon: Icons.heart_broken,
      label: 'Favorites',
      color: Colors.pink,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeOutCubic,
            ),
          ),
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo.shade900, Colors.indigo.shade700],
          ),
        ),
        child: Column(
          children: [
            // Header Section
            _buildDrawerHeader(),
            const SizedBox(height: 20),

            // Menu Items
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: drawerItems.length,
                itemBuilder: (context, index) {
                  return _buildDrawerMenuItem(
                    item: drawerItems[index],
                    index: index,
                    isSelected: selectedIndex == index,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      Navigator.pop(context);
                      _showSnackBar(drawerItems[index].label);
                    },
                  );
                },
              ),
            ),

            // Footer Section
            _buildDrawerFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [Colors.cyan, Colors.blue]),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyan,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 28),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'John Doe',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'john.doe@example.com',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerMenuItem({
    required DrawerItem item,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.2 + (index * 0.08), 1, curve: Curves.easeOut),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero)
            .animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Interval(0.2 + (index * 0.08), 1, curve: Curves.easeOut),
              ),
            ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(12),
              splashColor: Colors.white.withOpacity(0.1),
              highlightColor: Colors.white.withOpacity(0.05),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            item.color.withOpacity(0.8),
                            item.color.withOpacity(0.6),
                          ],
                        )
                      : null,
                  color: isSelected ? null : Colors.white.withOpacity(0.05),
                  border: isSelected
                      ? Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        )
                      : null,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: item.color.withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  children: [
                    Icon(item.icon, color: Colors.white, size: 22),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        item.label,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                    if (isSelected)
                      Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
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

  Widget _buildDrawerFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red.shade300, size: 22),
                    const SizedBox(width: 16),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red.shade300,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigated to $label'),
        duration: const Duration(milliseconds: 1500),
        backgroundColor: Colors.indigo.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class DrawerItem {
  final IconData icon;
  final String label;
  final Color color;

  DrawerItem({required this.icon, required this.label, required this.color});
}
