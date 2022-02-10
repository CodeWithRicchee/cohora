import 'package:flutter/material.dart';
import 'package:redbull/services/search_api_services.dart';
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
        } else {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    launchURL(snapshot.data![index].qrCode.toString());
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(snapshot.data![index].displayName.toString()),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            snapshot.data![index].photoUrl.toString()),
                      ),
                      subtitle: Text(snapshot.data![index].email.toString()),
                      trailing: IconButton(
                          onPressed: () {
                            launchURL(snapshot.data![index].qrCode.toString());
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.blue,
                          )),
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
                  child: Card(
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(snapshot.data![index].text.toString()),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data![index].assets!.length,
                            itemBuilder: (context, index2) {
                              try {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Image.network(
                                    snapshot.data![index].assets![index2].url
                                        .toString(),
                                    fit: BoxFit.fill,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      "assets/3828537.jpg",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              } catch (e) {
                                return SizedBox(
                                  height: 200,
                                  child: Image.asset(
                                    "assets/3828537.jpg",
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
                              Text('${snapshot.data![index].likes!.length}'),
                              const Spacer(),
                              Text(
                                  '${snapshot.data![index].postComments!.length}'),
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
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      "assets/3828537.jpg",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              } catch (e) {
                                return SizedBox(
                                  height: 200,
                                  child: Image.asset(
                                    "assets/3828537.jpg",
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
