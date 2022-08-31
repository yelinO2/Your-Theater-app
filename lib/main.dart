import 'package:flutter/material.dart';
import 'package:your_theater/movies/now_playing.dart';
import 'movies/upcoming.dart';
import 'movies/top_rated.dart';
import 'text.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie API Demo App',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic home = const UpcomingMovies();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 5.0,
        title: const ModifiedText(
          text: 'Your Theater',
          size: 24,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: [
            SizedBox(
              height: 150,
              child: DrawerHeader(
                padding: const EdgeInsets.only(left: 12, top: 50.0),
                // margin: const EdgeInsets.all(0.0),
                decoration: const BoxDecoration(color: Color(0xff3C3261)),
                child: Text(
                  'Your Theater',
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  // textAlign: TextAlign.justify,
                ),
              ),
            ),
            ListTile(
              title: const ModifiedText(text: 'Now Playing', size: 18),
              onTap: () {
                setState(() {
                  home = const NowPlayingMovies();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const ModifiedText(text: 'Upcoming', size: 18),
              onTap: () {
                setState(() {
                  home = const UpcomingMovies();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const ModifiedText(text: 'Top Rated', size: 18),
              onTap: () {
                setState(() {
                  home = const TopRatedMovies();
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: home,
    );
  }
}
