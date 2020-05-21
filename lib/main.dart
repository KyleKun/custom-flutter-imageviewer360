import 'package:flutter/material.dart';
import 'package:xdtest/image360.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ImageView360 Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DemoPage(title: 'ImageView360 Demo'),
    );
  }
}

class DemoPage extends StatefulWidget {
  DemoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  List<AssetImage> imageList = List<AssetImage>();
  List<AssetImage> countryList = List<AssetImage>();
  int index = 0;
  bool autoRotate = false;
  int rotationCount = 2;
  int swipeSensitivity = 2;
  bool allowSwipeToRotate = true;
  RotationDirection rotationDirection = RotationDirection.anticlockwise;
  Duration frameChangeDuration = Duration(milliseconds: 50);
  bool imagePrecached = false;
  bool countryPrecached = false;
  List<String> mylist = ['Brasil', 'Japão', 'China', 'USA', 'México', 'Test1', 'Test2', 'Test3', 'Test4'];
 
  @override
  void initState() {
    //* To load images from assets after first frame build up.
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateImageList(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20,),
            (imagePrecached == true)
                ? ImageView360(
                    key: UniqueKey(),
                    textList: mylist,
                    imageList: imageList,
                    countryList: countryList,
                    autoRotate: autoRotate,
                    rotationCount: rotationCount,
                    rotationDirection: RotationDirection.anticlockwise,
                    frameChangeDuration: Duration(milliseconds: 30),
                    swipeSensitivity: swipeSensitivity,
                    allowSwipeToRotate: allowSwipeToRotate,
                  )
                : Text("Pre-Caching images..."),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "SELECIONAR",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 24),
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  void updateImageList(BuildContext context) async {
    for (int i = 1; i <= 9; i++) {
      countryList.add(AssetImage('assets/images/${i}country.png'));
      imageList.add(AssetImage('assets/images/$i.png'));
      //* To precache images so that when required they are loaded faster.
      await precacheImage(AssetImage('assets/images/$i.png'), context);
      await precacheImage(AssetImage('assets/images/${i}country.png'), context);
    }
    setState(() {
      imagePrecached = true;
      countryPrecached = true;
    });
  }
}
