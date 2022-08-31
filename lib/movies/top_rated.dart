import 'package:flutter/material.dart';
import '../detail.dart';
import '../text.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TopRatedMovies extends StatefulWidget {
  const TopRatedMovies({Key? key}) : super(key: key);

  @override
  State<TopRatedMovies> createState() => _TopRatedMoviesState();
}

class _TopRatedMoviesState extends State<TopRatedMovies> {
  Future<Map> getJson() async {
    var url =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=12db7022e82fd84755282e23d2ea8480&language=en-US&page=1';
    http.Response response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }

  List topRated = [];
  Color mainColor = const Color(0xff3C3261);

  void getData() async {
    var data = await getJson();
    setState(() {
      topRated = data['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: ModifiedText(
                text: 'Top Rated Movies',
                size: 22,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: topRated.length,
                itemBuilder: (context, index) {
                  return TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Description(
                              name: topRated[index]['title'],
                              description: topRated[index]['overview'],
                              bannerUrl:
                                  'https://image.tmdb.org/t/p/w500${topRated[index]['backdrop_path']}',
                              posterUrl:
                                  'https://image.tmdb.org/t/p/w500${topRated[index]['poster_path']}',
                              rating:
                                  topRated[index]['vote_average'].toString(),
                              launchDate: topRated[index]['release_date'],
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              margin: const EdgeInsets.all(16.0),
                              child: Container(
                                width: 80.0,
                                height: 120.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500${topRated[index]['poster_path']}'),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: mainColor,
                                      blurRadius: 5.0,
                                      offset: const Offset(2.0, 5.0),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ModifiedText(
                                    text: topRated[index]['title'],
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const Padding(padding: EdgeInsets.all(2.0)),
                                  ModifiedText(
                                    text: topRated[index]['overview'],
                                    maxLine: 3,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
