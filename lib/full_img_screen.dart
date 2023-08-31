import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullImgScreen extends StatefulWidget {
  String imgsource;
  FullImgScreen({Key? key, required this.imgsource}) : super(key: key);

  @override
  State<FullImgScreen> createState() => _FullImgScreenState();
}

class _FullImgScreenState extends State<FullImgScreen> {

  Future <void> setWallpaper() async{

    try {
      String url = widget.imgsource;
      int location = WallpaperManager.BOTH_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(url);
      final result = await WallpaperManager.setWallpaperFromFile(file.path, location);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Row(
        children: [
          Text('Wallpaper set successfully ',),
          Icon(Icons.done, color: Colors.white,),
        ],
      ),));
    }catch(e){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(widget.imgsource), fit: BoxFit.cover)
          ),
        ),
          SafeArea(child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back,size: 35,))),
          Align(
              alignment: const Alignment(0, 0.9),
              child: ElevatedButton(
                onPressed: () async {
                  setWallpaper();
                },
                child: const Text('Set Wallpaper'),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)),
              )),
    ]
      ),
    );
  }
}
