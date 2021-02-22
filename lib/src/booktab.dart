import 'package:educa/model/storage.dart';
import 'package:educa/src/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookTab extends StatelessWidget {
  BookTab({
    Key key,
  }) : super(key: key);

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
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
          Progress(),
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
                borderSide: new BorderSide(color: kEducaBlue.withOpacity(.10)),
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

          Expanded(
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) => Item(),
                  ),
                )
              ],
            ),
          ),

          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        margin: EdgeInsets.only(right: 10),
        width: 250,
        height: 332,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
              'assets/humberto.png',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              alignment: Alignment.center,
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
                      'Biology Basics',
                      style: textTheme.bodyText1.copyWith(color: kEducaBlue),
                    ),
                  ),
                  SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0),
                    child: Text('Biology & Scientific Methodologies',
                        style: textTheme.headline3),
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

    return Consumer<StorageProvider>(
      builder: (context, state, child) {
        if (state.isUploaded) {
          print('sucess');
          showDialog<void>(
              context: context,
              builder: (BuildContext context) => Dialog(
                    child: Container(
                      height: 206,
                      decoration: BoxDecoration(
                        color: kEducaGreen,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text('Success'),
                    ),
                  ));
        }
        return Visibility(
          visible: state.isUploading,
          child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              height: 100,
              decoration: BoxDecoration(
                  color: kEducaGreen,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
