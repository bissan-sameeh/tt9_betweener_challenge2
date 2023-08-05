import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/models/link.dart';
import 'package:tt9_betweener_challenge/views/add_link_view.dart';

class ProfileView extends StatefulWidget {
  static String id = '/profileView';

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<List<Link>> links;

  @override
  void initState() {
    links = getLinks(context);

    super.initState();
  }

  updateUi() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Profile",
            style: TextStyle(fontSize: 24.sp),
          ),
          SizedBox(
            height: 12.h,
          ),

          ///personal info Card
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 20, right: 12, top: 12, bottom: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xff2D2B4E)),
            child: Row(
              children: [
                CircleAvatar(
                  child: Icon(Icons.person, size: 45, color: Color(0xff2D2B4E)),
                  radius: 45.r,
                ),
                SizedBox(
                  width: 16.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Johan Doe",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      "example",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "example",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        buildContainer(text: "follower 203"),
                        SizedBox(
                          width: 8.w,
                        ),
                        buildContainer(text: 'following 100')
                      ],
                    ),
                  ],
                ),
                const Icon(
                  Icons.edit,
                  color: Colors.white,
                )
              ],
            ),
          ),
          SizedBox(
            height: 24.h,
          ),

          ///Links

          FutureBuilder(
            future: links,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xffFEE2E7)),
                        child: Text(snapshot.data![index].title!),
                      );
                    }),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 26.r,
                backgroundColor: const Color(0xff2D2B4E),
                child: InkWell(
                  onTap: () async {
                    await Navigator.pushNamed(context, AddLinkView.id)
                        .then((value) {
                      setState(() {
                        links = getLinks(context);
                      });
                    });
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100.h,
          )
        ],
      ),
    );
  }

  Container buildContainer({required String text}) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: const Color(0xffFFD465),
          borderRadius: BorderRadius.circular(8.r)),
      child: Text(text),
    );
  }
}
