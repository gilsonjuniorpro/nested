import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Top Bar'),
        ),
        body: Stack(
          children: <Widget>[
            // Scrollable content
            Positioned.fill(
              top: 100.0, // height of the fixed header
              child: CustomScrollView(
                slivers: <Widget>[
                  // List items before the sticky title
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return ListTile(
                          title: Text('Item $index'),
                        );
                      },
                      childCount: 5,
                    ),
                  ),
                  // Sticky title
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      minHeight: 60.0,
                      maxHeight: 60.0,
                      child: Container(
                        color: Colors.red,
                        alignment: Alignment.center,
                        child: Text(
                          'Sticky Title',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // List items after the sticky title
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return ListTile(
                          title: Text('Item ${index + 6}'),
                        );
                      },
                      childCount: 20,
                    ),
                  ),
                ],
              ),
            ),
            // Fixed header
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 100.0,
              child: Container(
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text(
                  'Header Bar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}
