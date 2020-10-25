import 'package:flutter/material.dart';
import '../res/res.dart';
import '../screens/photo_screen.dart';
import '../widgets/widgets.dart';

const String kFlutterDash =
    "https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png";

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedState();
  }
}

class _FeedState extends State<Feed> {
  // String tag;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              _buildItem(index.toString()),
              Divider(
                thickness: 1,
                color: AppColors.mercury,
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildItem(String heroTag) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullScreenImage(
                  photo: kFlutterDash,
                  heroTag: heroTag,
                  userName: "kaparray",
                  name: "Kirill Adeshchenko",
                  userPhoto:
                      'https://skill-branch.ru/img/speakers/Adechenko.jpg',
                  altDescription: 'This is Flutter Dash. I love him :)',
                ),
              ),
            );
          },
          child: Hero(
            tag: heroTag,
            child: Photo(
              photoLink: kFlutterDash,
            ),
          ),
        ),
        _buildPhotoMeta(),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 15),
          child: Text(
            'This is Flutter Dash. I love him :)',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.h3.copyWith(color: AppColors.manatee),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoMeta() {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 2.7, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              UserAvatar('https://skill-branch.ru/img/speakers/Adechenko.jpg'),
              SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Kirill Adeshchenko', style: AppStyles.h1Black),
                  Text(
                    '@kaparray',
                    style: AppStyles.h3.copyWith(color: AppColors.grayChateau),
                  ),
                ],
              ),
            ],
          ),
          LikeButton(2157, true),
        ],
      ),
    );
  }
}
