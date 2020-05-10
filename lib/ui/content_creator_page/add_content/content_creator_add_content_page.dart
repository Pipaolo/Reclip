import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/reclip_colors.dart';
import '../../../core/router/route_generator.gr.dart';
import '../../../model/reclip_content_creator.dart';
import '../../custom_widgets/flushbars/flushbar_collection.dart';

class ContentCreatorAddContentPage extends StatefulWidget {
  final ReclipContentCreator user;
  const ContentCreatorAddContentPage({Key key, this.user}) : super(key: key);

  @override
  _ContentCreatorAddContentPageState createState() =>
      _ContentCreatorAddContentPageState();
}

class _ContentCreatorAddContentPageState
    extends State<ContentCreatorAddContentPage> {
  final TextStyle _textStyle = TextStyle(
    fontSize: ScreenUtil().setSp(120),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('ADD CONTENT'),
        backgroundColor: reclipBlack,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: AddContentButton(
                  textStyle: _textStyle,
                  icon: FontAwesomeIcons.solidFileImage,
                  text: 'Add Illustration',
                  pageName: 'add_content_image_page',
                  contentCreator: widget.user,
                ),
              ),
            ),
            Divider(
              color: reclipIndigo,
              height: ScreenUtil().setHeight(40),
              endIndent: ScreenUtil().setWidth(80),
              indent: ScreenUtil().setWidth(80),
              thickness: ScreenUtil().setHeight(2),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: AddContentButton(
                  textStyle: _textStyle,
                  icon: FontAwesomeIcons.solidFileVideo,
                  text: 'Add Video',
                  pageName: '',
                  contentCreator: widget.user,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddContentButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final String pageName;
  final ReclipContentCreator contentCreator;
  const AddContentButton({
    Key key,
    @required this.textStyle,
    @required this.text,
    @required this.icon,
    @required this.pageName,
    @required this.contentCreator,
  }) : super(key: key);

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () async {
            if (pageName.isEmpty) {
              try {
                final fileSizeLimit = 1e9;

                final video = await ImagePicker.pickVideo(
                  source: ImageSource.gallery,
                );

                if (video.lengthSync() > fileSizeLimit) {
                  FlushbarCollection.showFlushbarWarning(
                      'Invalid File Size 🎬❌',
                      'The maximum file size of a video is limited to 1gb only.',
                      context);
                } else {
                  ExtendedNavigator.of(context).pushNamed(
                      Routes.addContentVideoPageRoute,
                      arguments: AddContentVideoPageArguments(
                          video: video, contentCreator: contentCreator));
                }
              } catch (e) {
                print("Image Canceled");
              }
            } else {
              try {
                final image = await ImagePicker.pickImage(
                    source: ImageSource.gallery, imageQuality: 80);
                if (image != null) {
                  ExtendedNavigator.of(context).pushNamed(
                    Routes.addContentImagePageRoute,
                    arguments: AddContentImagePageArguments(
                      image: image,
                      user: contentCreator,
                    ),
                  );
                } else {
                  FlushbarCollection.showFlushbarNotice(
                      'Image Selection Cancelled',
                      'No image selected',
                      context);
                }
              } catch (e) {
                print("Image Canceled");
              }
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: reclipIndigo,
                width: ScreenUtil().setWidth(5),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Icon(
                    icon,
                    size: ScreenUtil().setSp(80),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AutoSizeText(
                      text,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(25),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
