import 'package:flutter/material.dart';
import 'package:sejuta_cita/themes/theme.dart';
import 'package:sejuta_cita/views/widgets/home_header.dart';
import 'package:sejuta_cita/views/widgets/list_item.dart';
import 'package:sejuta_cita/views/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  double headerHeight = 0;
  bool showTitle = false;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final offset = _scrollController.offset;

    setState(() {
      showTitle = offset > headerHeight - kToolbarHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    headerHeight = context.screenSize.height * heightFraction;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: const NetworkImage(
                  'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png'),
              radius: sRadius,
            ),
            HSpacer(defaultSpacer),
            const Text('GitHub'),
          ],
        ),
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (_, __) => [
          HeaderAppBar(
            height: headerHeight,
            showTitle: showTitle,
          ),
        ],
        body: ListData(),
      ),
    );
  }
}
