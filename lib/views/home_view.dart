import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/controllers/user_controller.dart';

import '../constants.dart';
import '../models/link.dart';
import '../models/user.dart';

class HomeView extends StatefulWidget {
  static String id = '/homeView';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<User>
      user; //late because we not decompose the data yet ! and the same type of data returned of getLocalUser func.
  late Future<List<Link>> links;

  @override
  void initState() {
    super.initState();
    user =
        getLocalUser(); //her we call the function and assigned it to the same type of data Future <user>
    links = getLinks(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder(
          future:
              user, //her instead use fun getLocalUser and each time we rebuild it will turned on again we keep the data and such as use then her
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text('Welcome ${snapshot.data?.user?.name}');
            }
            return Text('loading');
          },
        ),
        FutureBuilder(
          future: links,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: 80,
                child: ListView.separated(
                    padding: EdgeInsets.all(12),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final link = snapshot.data?[index].title;
                      return Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: kLinksColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          '$link',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 8,
                      );
                    },
                    itemCount: snapshot.data!.length),
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Text('loading');
          },
        ),
      ],
    );
  }
}
