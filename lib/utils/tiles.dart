import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:redbull/services/search_api_services.dart';
import 'package:redbull/utils/html_tag_remover.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/post_model.dart';

FutureBuilder<List<Profiles>?> profileMethod(String query) {
  return FutureBuilder<List<Profiles>?>(
      future: SearchApi().fetchProfiles(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.data!.isEmpty) {
          return Expanded(
            child:
                Center(child: Image.asset("assets/undraw_Empty_re_opql.png")),
          );
        } else {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data![index].displayName.toString()),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          snapshot.data![index].photoUrl.toString()),
                    ),
                    subtitle: Text(snapshot.data![index].email.toString()),
                    trailing: ElevatedButton(
                      onPressed: () {
                        launchURL(snapshot.data![index].qrCode.toString());
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          fixedSize: const Size(80, 30)),
                      child: const Text("Follow"),
                    ),
                  ),
                );
              },
            ),
          );
        }
      });
}

FutureBuilder<List<Posts>?> postMethod(String query) {
  return FutureBuilder<List<Posts>?>(
      future: SearchApi().fetchPost(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.data!.isEmpty) {
          return Expanded(
            child: Center(
              child:
                  Center(child: Image.asset("assets/undraw_Empty_re_opql.png")),
            ),
          );
        } else {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    launchURL(snapshot.data![index].viewUrl.toString());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Card(
                      elevation: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(snapshot.data![index].userInfo!.nickname
                                .toString()),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(snapshot
                                  .data![index].userInfo!.photoUrl
                                  .toString()),
                            ),
                            subtitle: Text(timeAgo(
                                snapshot.data![index].createdAt.toString())),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset("assets/icons/Share.png"),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                      "assets/icons/DotsThreeOutline.png"),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: Text(
                              parseHtmlString(
                                  snapshot.data![index].text.toString()),
                              maxLines: 3,
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data![index].assets!.length,
                              itemBuilder: (context, index2) {
                                try {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Image.network(
                                      snapshot.data![index].assets![index2].url
                                          .toString(),
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                        "assets/image-not-found.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  return SizedBox(
                                    height: 200,
                                    child: Image.asset(
                                      "assets/image-not-found.png",
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                }
                              }),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset("assets/icons/Like.png"),
                                ),
                                const SizedBox(width: 5),
                                Text('${snapshot.data![index].likes!.length}'),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                      "assets/icons/DotsThreeOutline (1).png"),
                                ),
                                const Spacer(),
                                Text(
                                    '${snapshot.data![index].postComments!.length}'),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                      "assets/icons/ChatCircleDots.png"),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      });
}

FutureBuilder<List<SearchComments>?> searchComments(String query) {
  return FutureBuilder<List<SearchComments>?>(
      future: SearchApi().fetchComments(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.data!.isEmpty) {
          print("No data");
          return Expanded(
            child: Center(
              child:
                  Center(child: Image.asset("assets/undraw_Empty_re_opql.png")),
            ),
          );
        } else {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    launchURL(snapshot.data![index].post!.viewUrl.toString());
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(snapshot
                              .data![index].postComment!.userInfo!.nickname
                              .toString()),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot
                                .data![index].postComment!.userInfo!.photoUrl
                                .toString()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            parseHtmlString(
                                snapshot.data![index].post!.text.toString()),
                            maxLines: 3,
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                snapshot.data![index].post!.assets!.length,
                            itemBuilder: (context, index2) {
                              try {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Image.network(
                                    snapshot
                                        .data![index].post!.assets![index2].url
                                        .toString(),
                                    fit: BoxFit.fill,
                                    height: 200,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      "assets/image-not-found.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              } catch (e) {
                                return SizedBox(
                                  height: 200,
                                  child: Image.asset(
                                    "assets/image-not-found.png",
                                    fit: BoxFit.fill,
                                  ),
                                );
                              }
                            }),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.recommend,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                  '${snapshot.data![index].post!.likes!.length}'),
                              const Spacer(),
                              Text(
                                  '${snapshot.data![index].post!.postComments!.length}'),
                              const SizedBox(width: 5),
                              const Icon(Icons.comment),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      });
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
