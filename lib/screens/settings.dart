// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_thing/screens/login.dart';
import 'package:movie_thing/theme/theme_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int? option;
  final List<Color> colors = [const Color.fromARGB(255, 0, 80, 145)];
  final List<Color> borders = [Colors.white];
  final List<String> themes = ['Dark'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ThemeState>(context);
    return Theme(
        data: state.themeData,
        child: Container(
          color: state.themeData.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircleAvatar(
                              backgroundColor: state.themeData.colorScheme.secondary,
                              radius: 40,
                              child: Icon(
                                Icons.person_outline,
                                size: 40,
                                color: state.themeData.primaryColor,
                              )),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen(
                                          themeData: state.themeData,
                                        )));
                          },
                          child: Text(
                            'Log In / Sign Up',
                            style: state.themeData.textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                ),
                subtitle: SizedBox(
                  height: 100,
                  child: Center(
                   child: ListView.builder(
  scrollDirection: Axis.horizontal,
  shrinkWrap: true,
  itemCount: 1,
  itemBuilder: (BuildContext context, int index) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,

          
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    switch (index) {
                      case 0:
                        state.setDarkTheme();
                        break;
                    }
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  child: state.themeData.primaryColor == colors[index]
                      ? Icon(
                          Icons.done,
                          color: state.themeData.colorScheme.secondary,
                        )
                      : Container(),
                ),
              ),
            ),
            Text(
              themes[index],
              style: state.themeData.textTheme.bodyLarge,
            )
          ],
        ),
      ],
    );
  },
),

                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

