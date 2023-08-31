import 'dart:convert';
import 'package:awesome_wallpapers/category_container.dart';
import 'package:awesome_wallpapers/category_screen.dart';
import 'package:awesome_wallpapers/full_img_screen.dart';
import 'package:awesome_wallpapers/search_photos.dart';
import 'package:awesome_wallpapers/trending_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_wallpapers/Models/TrendingPhotosModel.dart';
import 'package:transition/transition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<TrendingPhotosModel> getTrendingPhotosApi() async{
    final response = await http.get(
      Uri.parse('https://api.pexels.com/v1/curated?per_page=50'),
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
  Future<TrendingPhotosModel> getNaturePhotosApi() async{
    final response = await http.get(
      Uri.parse('https://api.pexels.com/v1/search?query=nature&per_page=100'),
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
  Future<TrendingPhotosModel> getOceanPhotosApi() async{
    final response = await http.get(
      Uri.parse('https://api.pexels.com/v1/search?query=ocean&per_page=100'),
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
  Future<TrendingPhotosModel> getCarsPhotosApi() async{
    final response = await http.get(
      Uri.parse('https://api.pexels.com/v1/search?query=cars&per_page=100'),
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
  Future<TrendingPhotosModel> getBuildingPhotosApi() async{
    final response = await http.get(
      Uri.parse('https://api.pexels.com/v1/search?query=building&per_page=100'),
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
    return WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,

        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: ()async {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 5,),
                      const Icon(Icons.wallpaper_rounded, color: Colors.white,),
                      const SizedBox(width: 15,),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Center(child: Text('Awesome', style: TextStyle(color: Colors.white, fontSize: 26),)),
                          Text(' W A L L P A P E R S', style: TextStyle(color: Colors.orange.shade500, fontWeight: FontWeight.w900)),
                        ],
                      ),
                      const SizedBox(width: 90,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, Transition(child: const SearchPhotosScreen(), transitionEffect: TransitionEffect.RIGHT_TO_LEFT));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                            child: Row(children: [
                              Icon(Icons.search_outlined, color: Colors.white,),
                              Text('Search', style: TextStyle(color: Colors.white),),
                            ],),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                    future: getTrendingPhotosApi(),
                      builder: (context, snapshot){
                        if(!snapshot.hasData){
                          return const CircularProgressIndicator(color: Colors.white,);
                        }
                        else{
                          return Column(
                            children: [
                              Row(children: [
                                const SizedBox(width: 13,),
                                Text(
                                  'Trending', style: TextStyle(color: Colors.grey.shade300),),
                              ],),
                              const SizedBox(height: 10,),
                              SizedBox(
                                  height: 320,
                                  child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.photos!.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(context,
                                                Transition(child: FullImgScreen(
                                                    imgsource: snapshot.data!
                                                        .photos![index].src!.large2x
                                                        .toString()
                                                ),
                                                    transitionEffect: TransitionEffect
                                                        .FADE));
                                          },
                                          child: TrendingContainer(
                                              imgsrc: snapshot.data!
                                                  .photos![index].src!.portrait
                                                  .toString()),
                                        );
                                      }),
                              ),
                              const SizedBox(height: 16,),
                              Row(children: [
                                const SizedBox(width: 13,),
                                Text(
                                  'Category', style: TextStyle(color: Colors.grey.shade300),),
                              ],),
                              Row(
                                children: [
                                  FutureBuilder(
                                      future: getNaturePhotosApi(),
                                      builder: (context, snapshot){
                                        String Nature = 'Nature';
                                        if(!snapshot.hasData){
                                          return Container();
                                        }else {
                                          return CategoryContainer(
                                            bg_img: snapshot.data!.photos![0].src!
                                                .portrait.toString(), title: Nature, onpress: () {
                                            Navigator.push(context, Transition(child: CategoryScreen(title: Nature,), transitionEffect: TransitionEffect.BOTTOM_TO_TOP));

                                          },);
                                        }
                                      }),
                                  FutureBuilder(
                                      future: getOceanPhotosApi(),
                                      builder: (context, snapshot){
                                        String Ocean = 'Ocean';
                                        if(!snapshot.hasData){
                                          return Container();
                                        }else {
                                          return CategoryContainer(
                                            bg_img: snapshot.data!.photos![0].src!
                                                .portrait.toString(), title: Ocean, onpress: () {
                                            Navigator.push(context, Transition(child: CategoryScreen(title: Ocean,), transitionEffect: TransitionEffect.BOTTOM_TO_TOP));

                                          },);
                                        }
                                      }),
                                ],
                              ),
                              Row(
                                children: [
                                  FutureBuilder(
                                      future: getCarsPhotosApi(),
                                      builder: (context, snapshot){
                                        String Cars = 'Cars';
                                        if(!snapshot.hasData){
                                          return Container();
                                        }else {
                                          return CategoryContainer(
                                            bg_img: snapshot.data!.photos![0].src!
                                                .portrait.toString(), title: Cars, onpress: () {
                                            Navigator.push(context, Transition(child: CategoryScreen(title: Cars,), transitionEffect: TransitionEffect.BOTTOM_TO_TOP));

                                          },);
                                        }
                                      }),
                                  FutureBuilder(
                                      future: getBuildingPhotosApi(),
                                      builder: (context, snapshot){
                                        String Title = 'Cities';
                                        if(!snapshot.hasData){
                                          return Container();
                                        }else {
                                          return CategoryContainer(
                                            onpress: (){
                                              Navigator.push(context, Transition(child: CategoryScreen(title: Title,), transitionEffect: TransitionEffect.BOTTOM_TO_TOP));
                                            },
                                            bg_img: snapshot.data!.photos![0].src!
                                                .portrait.toString(), title: Title,);
                                        }
                                      })
                                ],
                              )


                            ],
                          );
                        }
                      }),



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//
// import 'dart:convert';
// import 'package:awesome_wallpapers/category_container.dart';
// import 'package:awesome_wallpapers/full_img_screen.dart';
// import 'package:awesome_wallpapers/trending_container.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:awesome_wallpapers/Models/TrendingPhotosModel.dart';
// import 'package:transition/transition.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   Future<TrendingPhotosModel> getTrendingPhotosApi() async{
//     final response = await http.get(
//         Uri.parse('https://api.pexels.com/v1/curated?per_page=50'),
//         headers: {
//           'Authorization' : 'YUcTCLeShAZp7RVzyxsOq245zRmCliVLwMzRXCxcXM0ixCSCG0aMVAlL'
//         }
//     );
//     if(response.statusCode == 200){
//       var data = jsonDecode(response.body);
//       return TrendingPhotosModel.fromJson(data);
//     }
//     else{
//       throw Exception('error while fetching api');
//     }
//
//   }
//   Future<TrendingPhotosModel> getSearchedPhotosApi(String queryName) async{
//     String query = queryName;
//
//     final response = await http.get(
//         Uri.parse('https://api.pexels.com/v1/search?query=$query&per_page=100'),
//         headers: {
//           'Authorization' : 'YUcTCLeShAZp7RVzyxsOq245zRmCliVLwMzRXCxcXM0ixCSCG0aMVAlL'
//         }
//     );
//     if(response.statusCode == 200){
//       var data = jsonDecode(response.body);
//       return TrendingPhotosModel.fromJson(data);
//     }
//     else{
//       throw Exception('error while fetching api');
//     }
//   }
//
//   final _searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 10,
//               ),
//               Column(
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 // crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Center(child: Text('Awesome', style: TextStyle(color: Colors.white, fontSize: 26),)),
//                   Text(' W A L L P A P E R S', style: TextStyle(color: Colors.white)),
//                 ],
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               FutureBuilder(
//                   future: getTrendingPhotosApi(),
//                   builder: (context, snapshot){
//                     if(!snapshot.hasData){
//                       return CircularProgressIndicator();
//                     }
//                     else{
//                       return Column(
//                         children: [
//                           Row(children: [
//                             SizedBox(width: 13,),
//                             Text(
//                               'Trending', style: TextStyle(color: Colors.grey.shade300),),
//                           ],),
//                           SizedBox(height: 10,),
//                           SizedBox(
//                             height: 320,
//                             child: ListView.builder(
//                                 physics: BouncingScrollPhysics(),
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: snapshot.data!.photos!.length,
//                                 itemBuilder: (context, index) {
//                                   return InkWell(
//                                     onTap: () {
//                                       Navigator.push(context,
//                                           Transition(child: FullImgScreen(
//                                               imgsource: snapshot.data!
//                                                   .photos![index].src!.portrait
//                                                   .toString()
//                                           ),
//                                               transitionEffect: TransitionEffect
//                                                   .FADE));
//                                     },
//                                     child: TrendingContainer(
//                                         imgsrc: snapshot.data!
//                                             .photos![index].src!.portrait
//                                             .toString()),
//                                   );
//                                 }),
//                           ),
//                           SizedBox(height: 16,),
//                           Row(children: [
//                             SizedBox(width: 13,),
//                             Text(
//                               'Category', style: TextStyle(color: Colors.grey.shade300),),
//                           ],),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               FutureBuilder(
//                                   future: getSearchedPhotosApi('nature'),
//                                   builder: (context, snapshot){
//                                     if(!snapshot.hasData){
//                                       return Container();
//                                     }else {
//                                       return CategoryContainer(
//                                         bg_img: snapshot.data!.photos![0].src!
//                                             .portrait.toString(), title: 'Nature',);
//                                     }
//                                   }),
//                               FutureBuilder(
//                                   future: getSearchedPhotosApi('oceans'),
//                                   builder: (context, snapshot){
//                                     if(!snapshot.hasData){
//                                       return Container();
//                                     }else {
//                                       return CategoryContainer(
//                                         bg_img: snapshot.data!.photos![0].src!
//                                             .portrait.toString(), title: 'Oceans',);
//                                     }
//                                   }),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               FutureBuilder(
//                                   future: getSearchedPhotosApi('Cars'),
//                                   builder: (context, snapshot){
//                                     if(!snapshot.hasData){
//                                       return Container();
//                                     }else {
//                                       return CategoryContainer(
//                                         bg_img: snapshot.data!.photos![0].src!
//                                             .portrait.toString(), title: 'Cars',);
//                                     }
//                                   }),
//                               FutureBuilder(
//                                   future: getSearchedPhotosApi('Building'),
//                                   builder: (context, snapshot){
//                                     if(!snapshot.hasData){
//                                       return Container();
//                                     }else {
//                                       return CategoryContainer(
//                                         bg_img: snapshot.data!.photos![0].src!
//                                             .portrait.toString(), title: 'Cities',);
//                                     }
//                                   }),
//                             ],
//                           ),
//                         ],
//                       );
//                     }
//                   }),
//
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
