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
  State createState() {
    return _FullScreenImageState();
  }
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
    altDescription = (widget.altDescription != null)
        ? altDescription
        : 'This is Flutter Dash. I love him :)';

    name = (widget.name != null) ? widget.name : 'Kirill Adeshchenko';
    userName = (widget.userName == null) ? 'kaparray' : widget.userName;
    heroTag = 'tag';
    photo = (widget.photo != null) ? widget.photo : kFlutterDash;
    userPhoto = 'https://skill-branch.ru/img/speakers/Adechenko.jpg';
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _playAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Text("Photo", style: AppStyles.h1Black),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(CupertinoIcons.back, color: AppColors.grayChateau),
            onPressed: () => Navigator.pop(context)),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: widget.heroTag,
              child: Photo(photoLink: widget.photo ?? kFlutterDash),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 16, bottom: 14, left: 10, right: 10),
              child: Text(
                widget.altDescription,
                maxLines: 3,
                style: AppStyles.h3.copyWith(color: AppColors.manatee),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: <Widget>[
                      Opacity(
                        opacity: buildAnimationUserAvatar(),
                        child: UserAvatar(
                            'https://skill-branch.ru/img/speakers/Adechenko.jpg'),
                      ),
                      SizedBox(width: 6.0),
                      Opacity(
                        opacity: buildAnimationUserMeta(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.name, style: AppStyles.h1Black),
                            Text(
                              '@' + widget.userName,
                              style: AppStyles.h5Black
                                  .copyWith(color: AppColors.manatee),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  LikeButton(10, true),
                  Row(
                    children: <Widget>[
                      _buildButton(txt: 'Save'),
                      SizedBox(width: 10),
                      _buildButton(txt: 'Visit'),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  double buildAnimationUserMeta() {
    return Tween<double>(begin: 0.0, end: 1.0)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(0.5, 1.0, curve: Curves.ease),
          ),
        )
        .value;
  }

  double buildAnimationUserAvatar() {
    return Tween<double>(begin: 0.0, end: 1.0)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(0.0, 0.5, curve: Curves.ease),
          ),
        )
        .value;
  }

  Widget _buildButton({String txt = 'Button'}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.dodgerBlue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Text(txt, style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
      ),
    );
  }
}
