import 'package:educa/src/colors.dart';
import 'package:flutter/material.dart';

class Video extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
            builder: (context) => Stack(
                  children: [
                    Image.asset(
                      'assets/humberto-large.png',
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: double.infinity,
                    ),

                    Positioned(
                      top: 60,
                      left: 30,
                      child: Container(
                        width: 300,
                        height: 5,
                        child: Slider(
                          min: 0,
                          max: 100,
                          value: 20,
                          activeColor: kEducaBlue,
                          inactiveColor: kEducaWhite,
                          onChanged: (double value) {},
                        ),
                      ),
                    ),

                    // bottom button row
                    Positioned(
                      left: 85,
                      bottom: 81,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                                color: kEducaBlack.withOpacity(.25),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                )),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.mic_none,
                                size: 34,
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: kEducaBlue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                showBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        EducaBottomSheet());
                              },
                              icon: Icon(
                                Icons.video_call_outlined,
                              ),
                            ),
                          ),
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: kEducaBlack.withOpacity(.25),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.refresh,
                                size: 34,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )));
  }
}

class EducaBottomSheet extends StatelessWidget {
  const EducaBottomSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 38),
      height: 455,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 28),
          Align(
            alignment: Alignment.topRight,
            child: Text('Retake', style: textTheme.headline3),
          ),
          SizedBox(height: 19),
          Text('Topic', style: textTheme.bodyText1.copyWith(color: kEducaBlue)),
          SizedBox(height: 6),
          TextFormField(
            initialValue: 'Biology Basics',
            style: textTheme.headline3,
          ),
          SizedBox(height: 23),
          Text('Title', style: textTheme.bodyText1.copyWith(color: kEducaBlue)),
          SizedBox(height: 6),
          TextFormField(
            style: textTheme.headline3,
            initialValue: 'Biology & Scientific Methodologies',
          ),
          Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            width: double.infinity,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, 'uploading video');
                },
                child: Text(
                  'Upload',
                  style: textTheme.headline3.copyWith(color: kEducaWhite),
                ),
              ),
            ),
          ),
          SizedBox(height: 87),
        ],
      ),
    );
  }
}
