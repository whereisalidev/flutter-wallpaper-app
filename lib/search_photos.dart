import 'dart:convert';

import 'package:awesome_wallpapers/Models/TrendingPhotosModel.dart';
import 'package:awesome_wallpapers/full_img_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transition/transition.dart';

class SearchPhotosScreen extends StatefulWidget {
  const SearchPhotosScreen({Key? key}) : super(key: key);

  @override
  State<SearchPhotosScreen> createState() => _SearchPhotosScreenState();
}

class _SearchPhotosScreenState extends State<SearchPhotosScreen> {

  Future<TrendingPhotosModel> getSearchedPhotosApi(String query) async{

    final response = await http.get(
        Uri.parse('https://api.pexels.com/v1/search?query=' +query+'&per_page=100'),
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

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: AppBar(
          backgroundColor: Colors.black,
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                          onSubmitted : (value){
                          setState(() {
                          });
                        },

                        controller: _searchController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 18,vertical: 15),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Search',

                          suffixIcon: InkWell(
                                onTap: (){
                                  _searchController.clear();
                                },
                                child: const Icon(Icons.clear)),
                            prefixIcon: const Icon(
                              Icons.search_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                            // hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                        ),
                      ),
                    ),
                  ),
                  // InkWell(
                  //     onTap: (){
                  //       setState(() {
                  //       });
                  //     },
                  //     child: Text('Search', style: TextStyle(color: Colors.blue.shade400, fontSize: 16),)),
                  // SizedBox(width: 20,)
                ],
              ),
               const SizedBox(
                height: 20,
              ),
              _searchController.text.isNotEmpty ?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: FutureBuilder(
                        future: getSearchedPhotosApi(_searchController.text.toString()),
                        builder: (context, snapshot){
                          if(!snapshot.hasData){
                            return Container();
                          }
                          else if (snapshot.connectionState == ConnectionState.waiting){
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
              )
                  :
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.13,
                  ),
                  Image(
                    image: const AssetImage('assets/search.png'),
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                ],
              ) ,


            ],
          ),
        ),
      ),
    );
  }
}
