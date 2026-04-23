import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lesson_flutter/ScaffoldWidget/lessonScreen.dart';

class Profileapp extends StatefulWidget {
  const Profileapp({super.key});

  @override
  State<Profileapp> createState() => _ProfileappState();
}

class _ProfileappState extends State<Profileapp> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'ផ្សេងៗទៀត',
          style: GoogleFonts.kantumruyPro(color: Colors.white),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildSectionTitle('មុខងារផ្សេងៗទៀត'),
          _buildSettingGroup([
            _buildSettingItem('រាប់ថយក្រោយដល់ការប្រឡង'),
            _buildSettingItem('គណនានិទ្ទេសបាក់ឌុប'),
            _buildSettingItem('គណិតថ្នាក់ទី១២', isLast: true),
          ]),
          SizedBox(height: 24),
          _buildSectionTitle('ការកំណត់'),
          _buildSettingGroup([
            _buildThemeToggleItem(),
            _buildSettingItem('ភាសា', isLast: true),
          ]),
          SizedBox(height: 24),
          _buildSectionTitle('ផ្សេងៗទៀត'),
          _buildSettingGroup([
            _buildSettingItem('វាយតម្លៃកម្មវិធី'),
            _buildSettingItem('សហគមន៍របស់យើង'),
            _buildSettingItem('អំពីកម្មវិធី'),
            _buildSettingItem('តាមដានយើងខ្ញុំ', isLast: true),
          ]),
        ],
      ),
    );
  }

  Widget _buildSettingGroup(List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: items),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        title,
        style: GoogleFonts.kantumruyPro(color: Colors.white, fontSize: 20),
      ),
    );
  }

  Widget _buildSettingItem(String title, {bool isLast = false}) {
    return Container(
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: Colors.white24, width: 0.5)),
      ),
      child: ListTile(
        title: Text(
          title,
          style: GoogleFonts.kantumruyPro(color: Colors.white, fontSize: 16),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {},
      ),
    );
  }

  Widget _buildThemeToggleItem() {
    return ListTile(
      title: Text(
        'រចនាបថ',
        style: GoogleFonts.kantumruyPro(color: Colors.white, fontSize: 16),
      ),
      trailing: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildToggleBtn('ស្វ័យប្រវត្តិ', true),
            _buildToggleBtn('ងងឹត', false),
            _buildToggleBtn('ភ្លឺ', false),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleBtn(String label, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF444444) : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: GoogleFonts.kantumruyPro(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.redAccent,
      unselectedItemColor: Colors.grey,
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ទំព័រដើម'),

        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'ផ្សេងៗ'),
      ],
    );
  }
}
