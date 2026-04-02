import 'package:flutter/material.dart';

void main() => runApp(const DropdownControllerApp());

class DropdownControllerApp extends StatelessWidget {
  const DropdownControllerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dropdown Controller',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0F),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF5B5FF5),
          secondary: Color(0xFFA78BFA),
          surface: Color(0xFF13131A),
        ),
        fontFamily: 'monospace',
      ),
      home: const DropdownControllerPage(),
    );
  }
}

// ─── Data ─────────────────────────────────────────────────────────────────────

class HobbyItem {
  final String label;
  final String badge;
  const HobbyItem(this.label, this.badge);
}

const _initial = [
  HobbyItem('Photography', 'visual'),
  HobbyItem('Hiking', 'outdoor'),
  HobbyItem('Cooking', 'culinary'),
  HobbyItem('Reading', 'leisure'),
  HobbyItem('Gaming', 'digital'),
  HobbyItem('Music', 'art'),
  HobbyItem('Travel', 'explore'),
  HobbyItem('Yoga', 'wellness'),
];

  List<HobbyItem> items = List.from(_initial);
const _extra = [
  HobbyItem('Painting', 'art'),
  HobbyItem('Cycling', 'sport'),
  HobbyItem('Writing', 'creative'),
];

// ─── Controller ───────────────────────────────────────────────────────────────

class DropdownController extends ChangeNotifier {
  List<HobbyItem> items = List.from(_initial);
  Set<int> selected = {};
  bool isOpen = false;
  bool _extraAdded = false;
  List<_LogEntry> log = [];

  void toggle(int i) {
    if (selected.contains(i)) {
      selected.remove(i);
      _log('Deselected: ${items[i].label}', _LogType.warn);
    } else {
      selected.add(i);
      _log('Selected: ${items[i].label}', _LogType.success);
    }
    notifyListeners();
  }

  void toggleOpen() {
    isOpen = !isOpen;
    _log(isOpen ? 'Dropdown opened' : 'Dropdown closed', _LogType.info);
    notifyListeners();
  }

  void selectAll() {
    selected = Set.from(List.generate(items.length, (i) => i));
    _log('All ${items.length} items selected', _LogType.success);
    notifyListeners();
  }

  void unselectAll() {
    selected.clear();
    _log('All items deselected', _LogType.warn);
    notifyListeners();
  }

  void addItems() {
    if (!_extraAdded) {
      items = [...items, ..._extra];
      _extraAdded = true;
      _log('Added ${_extra.length} new items', _LogType.success);
    } else {
      _log('Extra items already added', _LogType.warn);
    }
    notifyListeners();
  }

  void selectWhere() {
    final before = selected.length;
    for (var i = 0; i < items.length; i++) {
      if (['art', 'creative', 'visual'].contains(items[i].badge)) {
        selected.add(i);
      }
    }
    _log(
      'Select Where (art/creative/visual): +${selected.length - before}',
      _LogType.info,
    );
    notifyListeners();
  }

  void selectAtIndex(int idx) {
    if (idx < 0 || idx >= items.length) {
      _log('Invalid index: $idx (range 0–${items.length - 1})', _LogType.warn);
    } else {
      selected.add(idx);
      _log('Selected at index $idx: ${items[idx].label}', _LogType.success);
    }
    notifyListeners();
  }

  void submit() {
    if (selected.isEmpty) {
      _log('Submit: no items selected', _LogType.warn);
    } else {
      final vals = selected.map((i) => items[i].label).join(', ');
      _log('Submitted: [$vals]', _LogType.success);
      if (isOpen) toggleOpen();
    }
    notifyListeners();
  }

  void clearLog() {
    log.clear();
    notifyListeners();
  }

  void _log(String msg, _LogType type) {
    log.insert(0, _LogEntry(msg, type, DateTime.now()));
    if (log.length > 30) log.removeLast();
  }

  String get triggerLabel {
    if (selected.isEmpty) return 'Hobbies';
    if (selected.length == 1) return items[selected.first].label;
    return '${selected.length} selected';
  }
}

enum _LogType { info, success, warn }

class _LogEntry {
  final String msg;
  final _LogType type;
  final DateTime ts;
  const _LogEntry(this.msg, this.type, this.ts);
}

// ─── Page ─────────────────────────────────────────────────────────────────────

class DropdownControllerPage extends StatefulWidget {
  const DropdownControllerPage({super.key});

  @override
  State<DropdownControllerPage> createState() => _DropdownControllerPageState();
}

class _DropdownControllerPageState extends State<DropdownControllerPage> {
  final _ctrl = DropdownController();
  final _indexCtrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    _indexCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _ctrl,
      builder: (context, _) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(),
                const SizedBox(height: 24),
                _DropdownField(ctrl: _ctrl),
                const SizedBox(height: 10),
                _SelectedTags(ctrl: _ctrl),
                const SizedBox(height: 16),
                _ControllerPanel(ctrl: _ctrl, indexCtrl: _indexCtrl),
                const SizedBox(height: 16),
                _LogPanel(ctrl: _ctrl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Header ───────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, Color(0xFFA78BFA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
            'Dropdown\nController',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              height: 1.15,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'PROGRAMMATIC CONTROL DEMO',
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFF6B6B8A),
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}

// ─── Dropdown Field ───────────────────────────────────────────────────────────

class _DropdownField extends StatelessWidget {
  final DropdownController ctrl;
  const _DropdownField({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Trigger
        GestureDetector(
          onTap: ctrl.toggleOpen,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: const Color(0xFF13131A),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: ctrl.isOpen
                    ? const Color(0xFF5B5FF5)
                    : const Color(0xFF2A2A3D),
              ),
              boxShadow: ctrl.isOpen
                  ? [
                      BoxShadow(
                        color: const Color(0xFF5B5FF5).withOpacity(0.15),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            child: Row(
              children: [
                const Icon(
                  Icons.flag_outlined,
                  size: 16,
                  color: Color(0xFFA78BFA),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    ctrl.triggerLabel,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFE8E8F0),
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: ctrl.isOpen ? 0.5 : 0,
                  duration: const Duration(milliseconds: 250),
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: Color(0xFF6B6B8A),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Menu
        AnimatedSize(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeInOut,
          child: ctrl.isOpen
              ? Container(
                  margin: const EdgeInsets.only(top: 8),
                  constraints: const BoxConstraints(maxHeight: 240),
                  decoration: BoxDecoration(
                    color: const Color(0xFF13131A),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF2A2A3D)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: ctrl.items.length,
                      separatorBuilder: (_, __) =>
                          const Divider(height: 1, color: Color(0xFF2A2A3D)),
                      itemBuilder: (_, i) => _DropdownItem(
                        item: ctrl.items[i],
                        selected: ctrl.selected.contains(i),
                        onTap: () => ctrl.toggle(i),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _DropdownItem extends StatelessWidget {
  final HobbyItem item;
  final bool selected;
  final VoidCallback onTap;
  const _DropdownItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: selected
            ? const Color(0xFF5B5FF5).withOpacity(0.12)
            : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF5B5FF5) : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF5B5FF5)
                      : const Color(0xFF2A2A3D),
                ),
              ),
              child: selected
                  ? const Icon(Icons.check, size: 10, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                item.label,
                style: const TextStyle(fontSize: 13, color: Color(0xFFE8E8F0)),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E30),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                item.badge,
                style: const TextStyle(fontSize: 10, color: Color(0xFF6B6B8A)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Selected Tags ────────────────────────────────────────────────────────────

class _SelectedTags extends StatelessWidget {
  final DropdownController ctrl;
  const _SelectedTags({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    if (ctrl.selected.isEmpty) return const SizedBox(height: 4);
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: ctrl.selected.map((i) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF5B5FF5).withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: const Color(0xFF5B5FF5).withOpacity(0.35),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  ctrl.items[i].label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFA78BFA),
                  ),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => ctrl.toggle(i),
                  child: const Icon(
                    Icons.close,
                    size: 12,
                    color: Color(0xFF6B6B8A),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ─── Controller Panel ─────────────────────────────────────────────────────────

class _ControllerPanel extends StatelessWidget {
  final DropdownController ctrl;
  final TextEditingController indexCtrl;
  const _ControllerPanel({required this.ctrl, required this.indexCtrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF13131A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2A2A3D)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFF2A2A3D))),
            ),
            child: Row(
              children: [
                _PulseDot(),
                const SizedBox(width: 8),
                const Text(
                  'CONTROLLER',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6B6B8A),
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // Submit full width
                _Btn(
                  label: 'Submit',
                  icon: Icons.arrow_outward,
                  primary: true,
                  onTap: ctrl.submit,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _Btn(
                        label: 'Select All',
                        icon: Icons.done_all,
                        onTap: ctrl.selectAll,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _Btn(
                        label: 'Unselect All',
                        icon: Icons.remove_done,
                        danger: true,
                        onTap: ctrl.unselectAll,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _Btn(
                        label: 'Add Items',
                        icon: Icons.add,
                        onTap: ctrl.addItems,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _Btn(
                        label: 'Select Where',
                        icon: Icons.filter_alt_outlined,
                        onTap: ctrl.selectWhere,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Index row
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: indexCtrl,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: 'monospace',
                        ),
                        decoration: InputDecoration(
                          hintText: 'index…',
                          hintStyle: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF6B6B8A),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF1E1E30),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF2A2A3D),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF5B5FF5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _Btn(
                      label: 'At Index',
                      icon: Icons.tag,
                      onTap: () {
                        final v = int.tryParse(indexCtrl.text) ?? -1;
                        ctrl.selectAtIndex(v);
                        indexCtrl.clear();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _Btn(
                  label: 'Open / Close Dropdown',
                  icon: Icons.unfold_more,
                  fullWidth: true,
                  onTap: ctrl.toggleOpen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Btn extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool primary;
  final bool danger;
  final bool fullWidth;

  const _Btn({
    required this.label,
    required this.icon,
    required this.onTap,
    this.primary = false,
    this.danger = false,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: Material(
        color: primary ? const Color(0xFF5B5FF5) : const Color(0xFF1E1E30),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: primary
                    ? const Color(0xFF5B5FF5)
                    : const Color(0xFF2A2A3D),
              ),
            ),
            child: Row(
              mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: fullWidth
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 14,
                  color: primary
                      ? Colors.white
                      : danger
                      ? const Color(0xFFF87171)
                      : const Color(0xFFE8E8F0),
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                    color: primary
                        ? Colors.white
                        : danger
                        ? const Color(0xFFF87171)
                        : const Color(0xFFE8E8F0),
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

class _PulseDot extends StatefulWidget {
  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ac;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _anim = Tween(begin: 1.0, end: 0.3).animate(_ac);
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(
          color: const Color(0xFF5B5FF5),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5B5FF5).withOpacity(0.6),
              blurRadius: 6,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Log Panel ────────────────────────────────────────────────────────────────

class _LogPanel extends StatelessWidget {
  final DropdownController ctrl;
  const _LogPanel({required this.ctrl});

  Color _color(_LogType t) => switch (t) {
    _LogType.success => const Color(0xFF34D399),
    _LogType.warn => const Color(0xFFFBBF24),
    _LogType.info => const Color(0xFFA78BFA),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF13131A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2A2A3D)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFF2A2A3D))),
            ),
            child: Row(
              children: [
                const Text(
                  'EVENT LOG',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6B6B8A),
                    letterSpacing: 1.5,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: ctrl.clearLog,
                  child: const Text(
                    'clear',
                    style: TextStyle(fontSize: 11, color: Color(0xFF6B6B8A)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 160,
            child: ctrl.log.isEmpty
                ? const Center(
                    child: Text(
                      'No events yet…',
                      style: TextStyle(fontSize: 12, color: Color(0xFF6B6B8A)),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: ctrl.log.length,
                    itemBuilder: (_, i) {
                      final e = ctrl.log[i];
                      final ts =
                          '${e.ts.hour.toString().padLeft(2, '0')}:${e.ts.minute.toString().padLeft(2, '0')}:${e.ts.second.toString().padLeft(2, '0')}';
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ts,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF6B6B8A),
                                fontFamily: 'monospace',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                e.msg,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: _color(e.type),
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
