import 'package:flutter/material.dart';

import 'colors.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final body =
        ''' Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tempus pulvinar erat vel tristique. Nunc consequat eros sed interdum fringilla. Vestibulum iaculis metus mi, vitae egestas libero consequat ac. Quisque ac elit at felis commodo convallis. Morbi ac maximus elit. Duis eget augue vitae nunc fermentum dictum. Donec id mi sit amet ante maximus sodales auctor vel sem. Nulla maximus magna a ligula commodo sagittis. Nulla varius leo quis pretium dignissim. Vivamus maximus nunc nisl, nec tristique enim egestas non. Quisque finibus, ante id finibus eleifend, felis justo viverra sapien, quis dignissim leo ligula non urna. Mauris nec lectus purus. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nam et magna cursus, euismod leo ut, vulputate eros. In elit ipsum, aliquam ac dui non, blandit pulvinar lectus.

Nulla lacinia ut ligula vitae pulvinar. Donec id tellus tortor. Pellentesque nunc leo, rutrum sit amet faucibus vel, tempor sit amet lectus. Curabitur aliquet orci non iaculis ornare. Morbi a accumsan massa, id mattis ante. Duis ullamcorper dui sed leo gravida, non molestie purus pulvinar. Curabitur mattis eget velit non efficitur. Proin nec ornare neque.

Donec mollis diam ac lorem gravida, a auctor libero scelerisque. Aenean vel mauris elit. Mauris tincidunt et odio at elementum. Mauris lacinia pretium magna, in porta ligula rhoncus ut.    ''';
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30,
                color: kEducaBlack,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Text(
            'Terms & Conditions',
            style: textTheme.headline2.copyWith(color: kEducaBlue),
          ),
          SizedBox(height: 30),
          Text(
            body,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    ));
  }
}
