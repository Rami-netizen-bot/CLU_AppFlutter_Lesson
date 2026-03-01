import 'package:flutter/material.dart';

class Sliverappbar extends StatelessWidget {
  const Sliverappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.face),
            ),
            actions: <Widget>[
              IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
            ],
            pinned: false,
            title: const Text("Sliver App"),
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.pink, Colors.indigo],
                  ),
                ),
              ),
            ),
            expandedHeight: 80,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.face),
                    title: Text('Item #$index'),
                    subtitle: Text("Awesome item $index"),
                    trailing: const Icon(Icons.navigate_next),
                  ),
                );
              },
              childCount: 15, // ← moved OUTSIDE the builder function
            ),
          ),
        ],
      ),
    );
  }
}
