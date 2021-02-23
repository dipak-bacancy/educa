import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educa/model/firestore.dart';
import 'package:educa/model/storage.dart';
import 'package:educa/src/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class BookTab extends StatelessWidget {
  BookTab({
    Key key,
  }) : super(key: key);

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StorageProvider>();
    print(state.isUploaded);

    // print('sucess');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.isUploaded) _showSuccessDailog(context);
    });

    final textTheme = Theme.of(context).textTheme;
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(left: 44.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 71),
            // header section
            Text(
              'Hello, Alex',
              style: textTheme.headline2,
            ),

            SizedBox(height: 14),
            // Progress(),
            Padding(
              padding: const EdgeInsets.only(right: 48.0),
              child: Text(
                'What would you like to learn today?',
                style: textTheme.headline1.copyWith(color: kEducaGrey),
              ),
            ),
            SizedBox(height: 40),

            // searchbar section
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                    color: kEducaBlue,
                  ),
                  child: Icon(
                    Icons.search,
                    color: kEducaWhite,
                  ),
                ),
                hintText: 'Content Creation|',
                // filled: true,
                contentPadding: EdgeInsets.only(left: 20, top: 10),

                border: OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: kEducaBlue.withOpacity(.10)),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
              ),
            ),
            //
            // TODO remove temp
            SizedBox(height: 10),

            FutureBuilder(
                future: Firestore().getVideos(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;

                    if (data.length == 0)
                      return Center(
                        child: Text('no data exist'),
                      );
                    return Expanded(
                      child: CustomScrollView(
                        scrollDirection: Axis.horizontal,
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) =>
                                  Item(data: data[index]),
                              childCount: data.length,
                            ),
                          )
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('error');
                  }

                  return CircularProgressIndicator();
                }),

            SizedBox(height: 10),
          ],
        ),
      ),
      Positioned(
        top: 40,
        child: Progress(),
      ),
    ]);
  }

  Future<void> _showSuccessDailog(BuildContext context) async {
    final textTheme = Theme.of(context).textTheme;
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Container(
                height: 206,
                decoration: BoxDecoration(
                  color: kEducaGreen,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Success!',
                      style: textTheme.headline2.copyWith(color: kEducaWhite),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Your video ',
                      style: textTheme.headline3.copyWith(color: kEducaWhite),
                    ),
                    Text(
                      'uploaded successfully!',
                      style: textTheme.headline3.copyWith(color: kEducaWhite),
                    ),
                  ],
                ),
              ),
            ));
  }
}

class Item extends StatelessWidget {
  Item({
    Key key,
    this.data,
  }) : super(key: key);

  final QueryDocumentSnapshot data;

  Future<dynamic> getThumbnail(String url) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: data['url'],
      imageFormat: ImageFormat.WEBP,
      maxHeight:
          64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    return uint8list;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        margin: EdgeInsets.only(right: 10),
        width: 250,
        height: 332,
        decoration: BoxDecoration(
          // color: kEducaBlack,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            FutureBuilder(
              future: getThumbnail(data['url']),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Image.memory(
                    snapshot.data,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  );
                } else if (snapshot.hasError) {
                  return Image.asset(
                    'assets/humberto.png',
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  );
                }
                return Column(
                  children: [
                    SizedBox(height: 30),
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                  ],
                );
              },
            ),
            Container(
              height: 136,
              width: 250,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 36),
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0),
                    child: Text(
                      data['title'],
                      style: textTheme.bodyText1.copyWith(color: kEducaBlue),
                    ),
                  ),
                  SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0),
                    child: Text(data['topic'], style: textTheme.headline3),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double width = MediaQuery.of(context).size.width;
    return Consumer<StorageProvider>(
      builder: (context, state, child) {
        return Visibility(
          visible: state.isUploading,
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(10),
              height: 100,
              width: width - width * .1,
              decoration: BoxDecoration(
                  color: kEducaGreen,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Icon(Icons.cloud_upload_outlined),
                  Text.rich(
                    TextSpan(
                        text: 'Your video is being uploaded! \n',
                        children: [
                          TextSpan(
                            text: '${state.downloadProgress}% Uploaded',
                            style: textTheme.headline3
                                .copyWith(fontSize: 13, color: Colors.white),
                          ),
                        ]),
                    style: textTheme.headline3.copyWith(color: Colors.white),
                  ),
                ],
              )),
        );
      },
    );
  }
}
