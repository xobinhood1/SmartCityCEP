import 'package:flutter/material.dart';
import './page_view_indicator.dart';
import 'package:namma_chennai/get_started/page_model.dart';

class WalkThrough extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        // Add box decoration
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Colors.redAccent,
              Colors.redAccent,
              Colors.orangeAccent,
              Colors.orangeAccent,
            ],
          ),
        ),
        child: WalkThroughBody(),
      ),
    );
  }
}

class WalkThroughBody extends StatefulWidget {
  WalkThroughBody({Key key}) : super(key: key);

  @override
  WalkThroughBodyState createState() => WalkThroughBodyState();
}

class WalkThroughBodyState extends State<WalkThroughBody> {
  PageController _pageController;
  CrossFadeState _bottomState = CrossFadeState.showFirst;
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(_pageListener);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
  }

  void _pageListener() {
    if (_pageController.hasClients) {
      double page = _pageController.page ?? _pageController.initialPage;
      setState(() {
        if (page >= 2.5) {
          _bottomState = CrossFadeState.showSecond;
        } else {
          _bottomState = CrossFadeState.showFirst;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        PageView.builder(
          controller: _pageController,
          itemCount: pages.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 100.0),
                new Container(
                    child: new Image(
                      image: AssetImage(pages[index].assetImagePath),
                      width: 300,
                    ),
                    // new CircleAvatar(
                    //   backgroundColor: Color(0xFFf7fbff),
                    //   backgroundImage: AssetImage(pages[index].assetImagePath),
                    //   radius: 150.0,
                    // ),
                    height: 300,
                    padding: const EdgeInsets.all(0.0), // borde width
                    decoration: new BoxDecoration(
                      color: Colors.white, // border color
                      // shape: BoxShape.circle,
                      borderRadius: new BorderRadius.only(
                            topLeft:  const  Radius.circular(40.0),
                            topRight: const  Radius.circular(40.0),
                            bottomLeft:  const  Radius.circular(40.0),
                            bottomRight: const  Radius.circular(40.0),),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 40.0,
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 100.0, left: 60.0, right: 40.0, bottom: 100.0),
                  child: Text(
                    pages[index].text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 30.0),
                  ),
                ),
              ],
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 96.0,
            alignment: Alignment.center,
            child: AnimatedCrossFade(
              crossFadeState: _bottomState,
              duration: Duration(milliseconds: 300),
              firstChild: PageIndicators(
                pageController: _pageController,
              ),
              secondChild: FlatButton(
                color: Colors.white,
                onPressed: () {
                  if (_pageController.page >= 2.5) {
                    Navigator.pushNamed(context, "/language");
                  }
                },
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 98.0),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PageIndicators extends StatelessWidget {
  final PageController pageController;

  const PageIndicators({Key key, this.pageController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
            alignment: Alignment.center,
            child: PageViewIndicator(
              controller: pageController,
              pageCount: 4,
              color: Colors.blueGrey,
            )),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              pageController.animateToPage(3,
                  curve: Curves.decelerate,
                  duration: Duration(milliseconds: 500));
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              child: Text(
                'Skip',
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Color(0xFF475d9a),
                    fontWeight: FontWeight.w700,
                    fontSize: 19.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
