import 'dart:async';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HomePage(),
    );
  }
}

const _horizontalPadding = 32.0;
const _carouselItemMargin = 8.0;
const _carouselHeightMin = 150.0 + 2 * _carouselItemMargin;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final carouselCards = <Widget>[
      _CarouselCard(
        asset: const NetworkImage(
          'http://p1.music.126.net/gKI_h8Wki8nVsyRBZ0VSPg==/109951165355202344.jpg',
        ),
      ),
      _CarouselCard(
        asset: const NetworkImage(
          'http://p1.music.126.net/gKI_h8Wki8nVsyRBZ0VSPg==/109951165355202344.jpg',
        ),
      ),
      _CarouselCard(
        asset: const NetworkImage(
          'http://p1.music.126.net/gKI_h8Wki8nVsyRBZ0VSPg==/109951165355202344.jpg',
        ),
      ),
      _CarouselCard(
        asset: const NetworkImage(
          'http://p1.music.126.net/gKI_h8Wki8nVsyRBZ0VSPg==/109951165355202344.jpg',
        ),
      ),
      _CarouselCard(
        asset: const NetworkImage(
          'http://p1.music.126.net/gKI_h8Wki8nVsyRBZ0VSPg==/109951165355202344.jpg',
        ),
      ),
      _CarouselCard(
        asset: const NetworkImage(
          'http://p1.music.126.net/gKI_h8Wki8nVsyRBZ0VSPg==/109951165355202344.jpg',
        ),
      ),
    ];

    return Scaffold(
      body: _AnimatedHomePage(
        carouselCards: carouselCards,
      ),
    );
  }
}

class _AnimatedHomePage extends StatefulWidget {
  const _AnimatedHomePage({
    Key key,
    @required this.carouselCards,
  }) : super(key: key);

  final List<Widget> carouselCards;

  @override
  _AnimatedHomePageState createState() =>
      _AnimatedHomePageState();
}

class _AnimatedHomePageState extends State<_AnimatedHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Timer _launchTimer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Start our animation halfway through the splash page animation.
    _launchTimer = Timer(
      const Duration(
        milliseconds: 100,
      ),
      () {
        _animationController.forward();
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _launchTimer?.cancel();
    _launchTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 8),
        _Carousel(
          children: widget.carouselCards,
          animationController: _animationController,
        ),
      ],
    );
  }
}

/// Animates the carousel to come in from the right.
class _AnimatedCarousel extends StatelessWidget {
  _AnimatedCarousel({
    Key key,
    @required this.child,
    @required this.controller,
  })  : startPositionAnimation = Tween(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.200,
              0.800,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final Widget child;
  final AnimationController controller;
  final Animation<double> startPositionAnimation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: _carouselHeightMin,
        width: constraints.maxWidth,
        child: child,
      );
    });
  }
}

class _Carousel extends StatefulWidget {
  const _Carousel({
    Key key,
    this.children,
    this.animationController,
  }) : super(key: key);

  final List<Widget> children;
  final AnimationController animationController;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<_Carousel>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin {
  PageController _controller;
  int _currentPage = 0;
  Timer bannerTimer;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    bannerTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentPage =
            (_currentPage + 1) % widget.children.length;
        print(_currentPage);
      });
    });

    Timer(Duration(seconds: 9), () {
      bannerTimer.cancel();
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller == null) {
      // The viewPortFraction is calculated as the width of the device minus the
      // padding.
      final width = MediaQuery.of(context).size.width;
      final padding =
          (_horizontalPadding * 2) - (_carouselItemMargin * 2);
      _controller = PageController(
        initialPage: _currentPage,
        viewportFraction: (width - padding) / width,
        keepPage: true,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget builder(int index) {
    final carouselCard = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double value;
        if (_controller.position.haveDimensions) {
          value = _controller.page - index;
        } else {
          // If haveDimensions is false, use _currentPage to calculate value.
          value = (_currentPage - index).toDouble();
        }
        // We want the peeking cards to be 160 in height and 0.38 helps
        // achieve that.
        value =
            (1 - (value.abs() * .38)).clamp(0, 1).toDouble();
        value = Curves.easeOut.transform(value);

        return Center(
          child: Transform(
            transform: Matrix4.diagonal3Values(1.0, value, 1.0),
            alignment: Alignment.center,
            child: child,
          ),
        );
      },
      child: widget.children[index],
    );

    return carouselCard;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _AnimatedCarousel(
      child: PageView.builder(
        onPageChanged: (value) {
          setState(() {
            _currentPage = value;
          });
        },
        controller: _controller,
        itemCount: widget.children.length,
        itemBuilder: (context, index) => builder(index),
        allowImplicitScrolling: true,
      ),
      controller: widget.animationController,
    );
  }
}

class _CarouselCard extends StatelessWidget {
  const _CarouselCard({
    Key key,
    this.asset,
  }) : super(key: key);

  final ImageProvider asset;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(_carouselItemMargin),
      child: Material(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image(
                image: asset,
                fit: BoxFit.cover,
                height: 150,
              ),
              Positioned(
                child: ClipRRect(
                    child: Container(
                      child: Padding(
                        padding:
                            EdgeInsets.fromLTRB(8, 5, 8, 5),
                        child: Text(
                          'test',
                          style: textTheme.caption,
                        ),
                      ),
                      decoration: new BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary,
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8))),
                right: -2,
                bottom: -2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
