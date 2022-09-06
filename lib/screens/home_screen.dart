import 'package:flutter/material.dart';

import '../components/text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'movie_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List ctgList = [
    {'category': 'upcoming', 'catTitle': 'Upcoming Movies'},
    {'category': 'now_playing', 'catTitle': 'Now Playing Movies'},
    {'category': 'top_rated', 'catTitle': 'Top Rated Movies'},
  ];

  String ctg = 'upcoming';
  String ctgTitle = 'Upcoming Movies';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 150,
              decoration: const BoxDecoration(color: Color(0xff3C3261)),
              child: DrawerHeader(
                padding: const EdgeInsets.only(left: 12, top: 50.0),
                // margin: const EdgeInsets.all(0.0),

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
            Expanded(
              child: ListView.builder(
                itemCount: ctgList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: ModifiedText(
                      text: ctgList[index]['catTitle'],
                      size: 16,
                    ),
                    onTap: () {
                      setState(() {
                        ctg = ctgList[index]['category'];
                        ctgTitle = ctgList[index]['catTitle'];
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      ModifiedText(text: 'Logout', size: 16),
                      SizedBox(width: 8),
                      Icon(Icons.logout_outlined),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: MovieScreen(
        category: ctg,
        catTitle: ctgTitle,
      ),
    );
  }
}
