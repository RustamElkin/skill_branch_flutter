import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/feed_screen.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage(
      {this.altDescription, this.photo, this.name, this.userName, Key key})
      : super(key: key);

  final String altDescription;
  final String photo;
  final String name;
  final String userName;

  @override
  State<StatefulWidget> createState() {
    return _FullScreenImageState();
  }
}

class _FullScreenImageState extends State<FullScreenImage> {
  String altDescription;
  String photo;
  String userName;
  String name;

  @override
  void initState() {
    super.initState();
    altDescription =
        (widget.altDescription != null) ? widget.altDescription : "";
    photo = (widget.photo != null) ? widget.photo : kFlutterDash;
    // "https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png";
    userName = (widget.userName == null) ? 'kaparray' : widget.userName;
    name = (widget.name != null) ? widget.name : "Kirill Adeshchenko";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        backgroundColor: AppColors.white,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(CupertinoIcons.back, color: AppColors.grayChateau),
            onPressed: () => Navigator.pop(context)),
        title: Text("Photo", style: AppStyles.h1Black),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Photo(photoLink: kFlutterDash),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                altDescription,
                maxLines: 3,
                style: AppStyles.h3.copyWith(color: AppColors.grayChateau),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _buildPhotoMeta(name, userName),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                LikeButton(1537, true),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      width: 120,
                      height: 40,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.dodgerBlue,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text('Save',
                          style:
                              AppStyles.h4.copyWith(color: AppColors.white))),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 120,
                    height: 40,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColors.dodgerBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Visit',
                        style: AppStyles.h4.copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoMeta(name, userName) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                    '@$userName',
                    style: AppStyles.h5Black.copyWith(color: AppColors.manatee),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
