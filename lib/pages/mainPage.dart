import 'package:feelings/global/global.dart';
import 'package:flutter/material.dart';

import 'package:feelings/pages/tabs/settings.dart';
import 'package:feelings/pages/tabs/home.dart';
import 'package:feelings/pages/tabs/myMusic.dart';
import 'package:feelings/components/thePlayPanel.dart';
import 'package:feelings/global/localization.dart';

const int tabCount = 4;

class MainPage extends StatefulWidget {
  const MainPage();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 1,
      length: tabCount,
      vsync: this,
    )..addListener(() {
        if (_tabController.index == 0) {
          if (Global.loginData?.cookie == null) {
            Navigator.pushNamed(
              context,
              "login",
              arguments: {"showHint": true},
            );
          }
        }
        setState(() {});
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget tabBarView;

    tabBarView = Column(
      children: [
        _TheTabBar(
          tabs: _buildTabs(context: context, theme: theme),
          tabController: _tabController,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _buildTabViews(),
          ),
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Theme(
          data: theme.copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: tabBarView,
        ),
        top: true,
      ),
      bottomNavigationBar: ThePlayPanel(),
    );
  }

  List<Widget> _buildTabs({
    BuildContext context,
    ThemeData theme,
  }) {
    return [
      _PageTab(
        theme: theme,
        iconData: Icons.headset,
        title: FeelingsLocalization.of(context).tabNameMine,
        tabIndex: 0,
        tabController: _tabController,
      ),
      _PageTab(
        theme: theme,
        iconData: Icons.music_note,
        title:
            FeelingsLocalization.of(context).tabNameDiscovery,
        tabIndex: 1,
        tabController: _tabController,
      ),
      _PageTab(
        theme: theme,
        iconData: Icons.search,
        title: FeelingsLocalization.of(context).tabNameSearch,
        tabIndex: 2,
        tabController: _tabController,
      ),
      _PageTab(
        theme: theme,
        iconData: Icons.settings,
        title: FeelingsLocalization.of(context).tabNameSettings,
        tabIndex: 3,
        tabController: _tabController,
      ),
    ];
  }

  List<Widget> _buildTabViews() {
    return [
      MineView(),
      HomeView(),
      Center(child: Text("coming soon...")),
      SettingsView(),
    ];
  }
}

class _TheTabBar extends StatelessWidget {
  const _TheTabBar({Key key, this.tabs, this.tabController})
      : super(key: key);

  final List<Widget> tabs;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      labelPadding: EdgeInsets.zero,
      tabs: tabs,
      controller: tabController,
      indicatorColor:
          Theme.of(context).colorScheme.primaryVariant,
      labelColor: Theme.of(context).colorScheme.primary,
    );
  }
}

class _PageTab extends StatefulWidget {
  _PageTab({
    ThemeData theme,
    IconData iconData,
    String title,
    int tabIndex,
    TabController tabController,
  })  : titleText = Text(
          title,
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        isExpanded = tabController.index == tabIndex,
        icon = Icon(iconData, semanticLabel: title);

  final Text titleText;
  final Icon icon;
  final bool isExpanded;

  @override
  _PageTabState createState() => _PageTabState();
}

class _PageTabState extends State<_PageTab>
    with SingleTickerProviderStateMixin {
  Animation<double> _titleSizeAnimation;
  Animation<double> _titleFadeAnimation;
  Animation<double> _iconFadeAnimation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _titleSizeAnimation = _controller.view;
    _titleFadeAnimation =
        _controller.drive(CurveTween(curve: Curves.easeOut));
    _iconFadeAnimation =
        _controller.drive(Tween<double>(begin: 0.6, end: 1));
    if (widget.isExpanded) {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(_PageTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    const expandedTitleWidthMultiplier = 1;
    final unitWidth =
        width / (tabCount + expandedTitleWidthMultiplier);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: Row(
        children: [
          FadeTransition(
            child: SizedBox(
              width: unitWidth,
              child: widget.icon,
            ),
            opacity: _iconFadeAnimation,
          ),
          FadeTransition(
            child: SizeTransition(
              child: SizedBox(
                width: unitWidth * expandedTitleWidthMultiplier,
                child: Center(
                  child: widget.titleText,
                ),
              ),
              axis: Axis.horizontal,
              axisAlignment: -1,
              sizeFactor: _titleSizeAnimation,
            ),
            opacity: _titleFadeAnimation,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
