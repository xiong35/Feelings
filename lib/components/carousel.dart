import 'package:flutter/material.dart';
import 'dart:async';

const _horizontalPadding = 32.0;
const _carouselItemMargin = 8.0;
const _carouselHeightMin = 150.0 + 2 * _carouselItemMargin;
const _duration = Duration(milliseconds: 800);

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

class Carousel extends StatefulWidget {
  const Carousel({
    Key key,
    this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin {
  PageController _controller;
  int _currentPage = 0;
  Timer bannerTimer;

  AnimationController _animationController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    bannerTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      _controller.animateToPage(
        (_currentPage + 1) % widget.children.length,
        duration: _duration,
        curve: Curves.ease,
      );
    });
    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
      );
    }
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
      controller: _animationController,
    );
  }
}

class CarouselCard extends StatelessWidget {
  const CarouselCard({
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
