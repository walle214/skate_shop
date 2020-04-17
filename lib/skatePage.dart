import 'package:flutter/material.dart';
import 'package:skate_shop/SkateBoard.dart';

class SkatePage extends StatelessWidget {
  final SkateBoard skateBoard;
  const SkatePage({Key key, @required this.skateBoard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomPaint(
        painter: LinePinter(skateBoard.colors.color),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              appBar(context),
              content(context),
              button(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        MaterialButton(
          child: Icon(Icons.arrow_back, color: Colors.white, size: 32.0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(width: 48.0),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(height: 8.0),
              Text(
                'SLIME MONSTER',
                style: Theme.of(context).textTheme.title.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0,
                    letterSpacing: 12.0),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget content(BuildContext context) {
    return Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 32.0),
          child: Row(
            children: <Widget>[
              Hero(
                tag: '${skateBoard.imagePath}',
                child: Container(
                  width: 140,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0,0,0,0.1),
                        offset: Offset(-20, 18),
                        blurRadius: 20,
                        spreadRadius: 0
                        
                      ),
                    ],
                    image: DecorationImage(
                      image: ExactAssetImage(skateBoard.imagePath),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 48.0, bottom: 48.0, left: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'cghdfhnjftghfghmghd sdfhdfgnh ddgn',
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(fontSize: 22.0),
                      ),
                      Expanded(child: Container()),
                      Divider(),
                      Expanded(child: Container()),
                      Text(
                        'S I Z E',
                        style: Theme.of(context).textTheme.caption.copyWith(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        '8" x 32"',
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(fontSize: 22.0),
                      ),
                      Expanded(child: Container()),
                      Text(
                        'M A T E R I A L',
                        style: Theme.of(context).textTheme.caption.copyWith(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'Canadian Maple',
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(fontSize: 22.0),
                      ),
                      Expanded(flex: 3, child: Container()),
                      CustomPaint(
                        painter: DieCuttingPainter(),
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          color: skateBoard.colors.color,
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              '\$240',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 10.0,
                                      color: skateBoard.colors.bodyTextColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget button(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Container(
      width: double.infinity,
      height: height * .1 >= 120.0 ? 120 : 100,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      child: FlatButton(
        onPressed: () {},
        child: Text(
          'ADD TO CAR',
          style: TextStyle(
              color: Colors.white, fontSize: 25.0, letterSpacing: 10.0),
        ),
      ),
    );
  }
}

class DieCuttingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;
    var x = size.height / 6;
    var path = Path();
    path.moveTo(0, -2 * x);

    for (int i = 0; i < 5; i++) {
      path.relativeLineTo(x, x);
      path.relativeLineTo(-x, x);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class LinePinter extends CustomPainter {
  final Color color;
  LinePinter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;

    final Rect rect = Rect.fromLTWH(0, 0, size.width * .25, size.height);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
