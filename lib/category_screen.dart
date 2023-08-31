import 'dart:convert';
import 'package:awesome_wallpapers/Models/TrendingPhotosModel.dart';
import 'package:awesome_wallpapers/full_img_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transition/transition.dart';
class CategoryScreen extends StatefulWidget {
  String title;
  CategoryScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  Future<TrendingPhotosModel> getCategoryPhotosApi() async{

    final response = await http.get(
        Uri.parse('https://api.pexels.com/v1/search?query=' + widget.title+'&per_page=100'),
        headers: {
          'Authorization' : 'YUcTCLeShAZp7RVzyxsOq245zRmCliVLwMzRXCxcXM0ixCSCG0aMVAlL'
        }
    );
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return TrendingPhotosModel.fromJson(data);
    }
    else{
      throw Exception('error while fetching api');
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategoryScreen(title: widget.title)));
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20,),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: FutureBuilder(
                    future: getCategoryPhotosApi(),
                    builder: (context, snapshot){
                      if (!snapshot.hasData){
                        return const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircularProgressIndicator(color: Colors.white,),
                          ],
                        );
                      }
                      else {
                        return GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 320
                            ),
                            itemCount: snapshot.data!.photos!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, Transition(
                                          transitionEffect: TransitionEffect.FADE,
                                          child: FullImgScreen(imgsource: snapshot.data!.photos![index].src!.large2x.toString())));
                                    },
                                    child: Image.network(
                                      snapshot.data!.photos![index].src!.large2x.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            }
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
