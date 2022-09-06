import 'package:flutter/material.dart';
import '../components/text.dart';
import 'dart:ui' as ui;

class Description extends StatefulWidget {
  final String name;
  final String description;
  final String posterUrl;
  final String rating;
  final String launchDate;
  final String bannerUrl;
  const Description({
    Key? key,
    required this.name,
    required this.description,
    required this.bannerUrl,
    required this.posterUrl,
    required this.rating,
    required this.launchDate,
  }) : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  bool rated = false;
  bool shared = false;
  bool saved = false;

  rate() {
    setState(() {
      rated = !rated;
    });
  }

  share() {
    setState(() {
      shared = !shared;
    });
  }

  save() {
    setState(() {
      saved = !saved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            widget.posterUrl,
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      width: 400.0,
                      height: 400.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: NetworkImage(widget.posterUrl),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 20.0,
                              offset: Offset(0.0, 10.0))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 0.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ModifiedText(
                            text: widget.name,
                            size: 28,
                          ),
                        ),
                        ModifiedText(
                          text: '${widget.rating}/10',
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                  ModifiedText(text: widget.description, size: 20),
                  const Padding(padding: EdgeInsets.all(10.0)),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15.0),
                            splashFactory: NoSplash.splashFactory,
                            primary: const Color(0xaa3C3261),
                            // onPrimary: rated ? Colors.blue : Colors.white,
                          ),
                          onPressed: () {
                            rate();
                          },
                          child: rated
                              ? const ModifiedText(
                                  text: 'Rate Movie ⭐',
                                  size: 18,
                                )
                              : const ModifiedText(
                                  text: 'Rate Movie ',
                                  size: 18,
                                ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15.0),
                          splashFactory: NoSplash.splashFactory,
                          primary: const Color(0xaa3C3261),
                          onPrimary: shared ? Colors.blue : Colors.white,
                        ),
                        onPressed: () {
                          share();
                        },
                        child: const Icon(Icons.share),
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15.0),
                          splashFactory: NoSplash.splashFactory,
                          primary: const Color(0xaa3C3261),
                          onPrimary: saved ? Colors.blue : Colors.white,
                        ),
                        onPressed: () {
                          save();
                        },
                        child: const Icon(Icons.bookmark),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
