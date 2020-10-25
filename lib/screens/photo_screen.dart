import '../res/res.dart';
import '../screens/feed_screen.dart';
import '../widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage(
      {Key key,
      this.altDescription,
      this.photo,
      this.name,
      this.userName,
      this.userPhoto,
      this.heroTag})
      : super(key: key);
  final String altDescription;
  final String photo;
  final String name;
  final String userName;
  final String userPhoto;
  final String heroTag;

  @override
  State<StatefulWidget> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage>
    with TickerProviderStateMixin {
  String altDescription;
  String photo;
  String userName;
  String name;
  String userPhoto;
  String heroTag;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    altDescription = widget.altDescription != null
        ? ''
        : 'This is Flutter Dash. I love him :)';
    photo = widget.photo != null ? widget.photo : kFlutterDash;
    userName = (widget.userName == null) ? 'kaparray' : widget.userName;
    name = widget.name != null ? widget.name : 'Kirill Adeshchenko';
    heroTag = widget.heroTag != null ? widget.heroTag : 'tag';
    userPhoto = widget.userPhoto != null
        ? widget.userPhoto
        : 'https://skill-branch.ru/img/speakers/Adechenko.jpg';
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _controller.forward();
    // _playAnimation();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  // Future<void> _playAnimation() async {
  //   try {
  //     await _controller.forward().orCancel;
  //   } on TickerCanceled {}
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Text("Photo", style: AppStyles.h2Black),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(CupertinoIcons.back, color: AppColors.grayChateau),
            onPressed: () => Navigator.pop(context, false)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: heroTag,
            child: Photo(photoLink: photo ?? kFlutterDash),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 16, bottom: 14, left: 10, right: 10),
            child: Text(
              widget.altDescription,
              maxLines: 3,
              style: AppStyles.h3.copyWith(color: AppColors.manatee),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _buildPhotoMeta(),
          AnimationPhotoMeta(
            controller: _controller.view,
            userName: userName,
            name: name,
            userPhoto: userPhoto,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                LikeButton(2157, true),
                SizedBox(width: 32.7),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                        width: 105,
                        height: 36,
                        decoration: BoxDecoration(
                            color: AppColors.dodgerBlue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text("Save",
                                style: AppStyles.h4
                                    .copyWith(color: AppColors.white)))),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 105,
                      height: 36,
                      decoration: BoxDecoration(
                          color: AppColors.dodgerBlue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Visit",
                          style: AppStyles.h4.copyWith(color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPhotoMeta() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              UserAvatar('https://skill-branch.ru/img/speakers/Adechenko.jpg'),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(name, style: AppStyles.h1Black),
                  Text(
                    "@" + userName,
                    style: AppStyles.h5Black.copyWith(color: AppColors.manatee),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class AnimationPhotoMeta extends StatelessWidget {
  AnimationPhotoMeta(
      {Key key, this.controller, this.userName, this.name, this.userPhoto})
      : opacityUserAvatar = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                curve: Interval(0.0, 0.5, curve: Curves.ease),
                parent: controller)),
        opacityColumn = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.5, 1, curve: Curves.ease))),
        super(key: key);

  final Animation<double> controller;
  final Animation<double> opacityUserAvatar;
  final Animation<double> opacityColumn;
  final String userName;
  final String name;
  final String userPhoto;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
