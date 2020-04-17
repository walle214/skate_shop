import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:skate_shop/SkateBoard.dart';
import 'package:skate_shop/skatePage.dart';

class SkateShop extends StatefulWidget {
  SkateShop({Key key}) : super(key: key);
  @override
  _SkateShopState createState() => _SkateShopState();
}

class _SkateShopState extends State<SkateShop>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  AnimationController _animationController;

  List<SkateBoard> data = null;

  double rotation = 0;
  double scrollStartAt = 0;

  Color backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animationController.addListener(() {
      setState(() {
        rotation = rotation.sign * _animationController.value;
      });
    });
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      var dx = _scrollController.offset - scrollStartAt;
      setState(() {
        rotation = dx / 50;
        if (rotation > 1)
          rotation = 1;
        else if (rotation < -1) rotation = -1;
        if (_scrollController.offset > 50)
          backgroundColor = data.last.colors.color;
        else
          backgroundColor = data.first.colors.color;
      });
    });

    _inicializeColors().then((list) {
      setState(() {
        data = list;
        backgroundColor = data.first.colors.color;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<List<SkateBoard>> _inicializeColors() async {
    var images = [
      'tabla_arbol.png',
      'tabla_carretera_lluviosa.png',
      'tabla_collar_amarillo.png',
      'tabla_dragon.png',
      'tabla_just_purple.png',
      'tabla_luces.png',
      'tabla_man_purple.png',
      'tabla_mujer.png',
      'tabla_naranjas.png',
      'tabla_pastillas_blancas.png',
      'tabla_pastillas_blancas_fondo_amarillo.png',
      'tabla_pastillas_rojas.png',
      'tabla_umbrella.png'
    ];
    List<SkateBoard> skateBoards = [];

    for (String image in images) {
      String imagePath = 'assets/skates/$image';
      PaletteGenerator colors =
          await PaletteGenerator.fromImageProvider(AssetImage(imagePath));
      skateBoards.add(SkateBoard(
          imagePath,
          colors.vibrantColor != null
              ? colors.vibrantColor
              : colors.lightVibrantColor != null
                  ? colors.lightVibrantColor
                  : colors.dominantColor));
    }
    return skateBoards;
  }

  @override
  Widget build(BuildContext context) {
    if (data == null)
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      backgroundColor: backgroundColor,
      body: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollEndNotification)
            _animationController.reverse(from: rotation.abs());

          if (notification is ScrollStartNotification)
            scrollStartAt = _scrollController.offset;
        },
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            for (SkateBoard board in data)
              SkateItemWidget(
                title: 'MISTIC TREE',
                imagePath: board.imagePath,
                price: '\$ 240',
                colors: board.colors,
                rotation: rotation,
              )
          ],
        ),
      ),
    );
  }
}

class SkateItemWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final String price;
  final PaletteColor colors;
  final double rotation;

  const SkateItemWidget({
    Key key,
    this.title,
    this.imagePath,
    this.price,
    this.colors,
    this.rotation,
  }) : super(key: key);
// const SkateItemWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(rotation);
    return Container(
      color: colors.color,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.titleTextColor,
                  letterSpacing: 10.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Text(
                price,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.titleTextColor,
                  letterSpacing: 10.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Transform(
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: colors.titleTextColor,
                        blurRadius: 50,
                        offset: Offset(50 * rotation, 0),
                        spreadRadius: -20,
                      )
                    ],
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SkatePage(
                              skateBoard: SkateBoard(imagePath, colors),
                            ),
                          ),
                        );
                      },
                      child: Hero(
                          tag: '$imagePath', child: Image.asset(imagePath)),
                    ),
                  ),
                ),
                transform: Matrix4.rotationY(rotation),
                alignment: FractionalOffset.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
