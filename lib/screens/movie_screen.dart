import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'detail.dart';
import '../components/text.dart';

import 'package:your_theater/api/api.dart';

// ignore: must_be_immutable
class MovieScreen extends StatefulWidget {
  String category;
  String catTitle;
  MovieScreen({Key? key, required this.category, required this.catTitle})
      : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  dynamic data;
  List movies = [];
  Color mainColor = const Color(0xff3C3261);

  Future getData() async {
    API().getJson(widget.category).then((value) {
      setState(() {
        data = value;
      });
    });
    setState(() {
      movies = data['results'];
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
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ModifiedText(
                text: widget.catTitle,
                size: 22,
              ),
            ),
            movies.isEmpty
                ? SpinKitFadingCircle()
                : Expanded(
                    child: ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Description(
                                    name: movies[index]['title'],
                                    description: movies[index]['overview'],
                                    bannerUrl:
                                        'https://image.tmdb.org/t/p/w500${movies[index]['backdrop_path']}',
                                    posterUrl:
                                        'https://image.tmdb.org/t/p/w500${movies[index]['poster_path']}',
                                    rating: movies[index]['vote_average']
                                        .toString(),
                                    launchDate: movies[index]['release_date'],
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.grey,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              'https://image.tmdb.org/t/p/w500${movies[index]['poster_path']}'),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ModifiedText(
                                          text: movies[index]['title'],
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.all(2.0)),
                                        ModifiedText(
                                          text: movies[index]['overview'],
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
