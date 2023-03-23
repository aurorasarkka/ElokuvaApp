// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:movie_thing/constats/api_constats.dart';
import 'package:movie_thing/models/credits.dart';

class CastAndCrew extends StatelessWidget {
  final ThemeData? themeData;
  final Credits? credits;
  const CastAndCrew({super.key, this.themeData, this.credits});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeData!.primaryColor,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: themeData!.colorScheme.secondary,
            tabs: [
              Tab(
                child: Text(
                  'Cast',
                  style: themeData!.textTheme.bodyLarge,
                ),
              ),
              Tab(
                child: Text(
                  'Crew',
                  style: themeData!.textTheme.bodyLarge,
                ),
              ),
            ],
          ),
          title: Text(
            'Cast And Crew',
            style: themeData!.textTheme.headlineSmall,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: themeData!.colorScheme.secondary,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: TabBarView(
          children: [castList(), creditsList()],
        ),
      ),
    );
  }

  Widget castList() {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
      color: themeData!.primaryColor,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: credits!.cast!.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 70,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: credits!.cast![index].profilePath == null
                        ? Image.asset(
                            'assets/images/na.jpg',
                            fit: BoxFit.cover,
                          )
                        : FadeInImage(
                            image: NetworkImage(TMDB_BASE_IMAGE_URL +
                                'w500/' +
                                credits!.cast![index].profilePath!),
                            fit: BoxFit.cover,
                            placeholder:
                                const AssetImage('assets/images/loading.gif'),
                          ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Name : ' + credits!.cast![index].name!,
                          style: themeData!.textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Character : ' + credits!.cast![index].character!,
                          style: themeData!.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget creditsList() {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
      color: themeData!.primaryColor,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: credits!.crew!.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 70,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: credits!.crew![index].profilePath == null
                        ? Image.asset(
                            'assets/images/na.jpg',
                            fit: BoxFit.cover,
                          )
                        : FadeInImage(
                            image: NetworkImage(TMDB_BASE_IMAGE_URL +
                                'w500/' +
                                credits!.crew![index].profilePath!),
                            fit: BoxFit.cover,
                            placeholder:
                                const AssetImage('assets/images/loading.gif'),
                          ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Name : ' + credits!.crew![index].name!,
                          style: themeData!.textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Job : ' + credits!.crew![index].job!,
                          style: themeData!.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}