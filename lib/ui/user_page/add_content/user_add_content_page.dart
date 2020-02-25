import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:sailor/sailor.dart';

import '../../../core/reclip_colors.dart';
import '../../../core/route_generator.dart';
import 'add_content_image/add_content_image_page.dart';

class UserAddContentPageArgs extends BaseArguments {
  final ReclipContentCreator user;

  UserAddContentPageArgs({@required this.user});
}

class UserAddContentPage extends StatefulWidget {
  final UserAddContentPageArgs args;
  const UserAddContentPage({Key key, this.args}) : super(key: key);

  @override
  _UserAddContentPageState createState() => _UserAddContentPageState();
}

class _UserAddContentPageState extends State<UserAddContentPage> {
  final TextStyle _textStyle = TextStyle(
    fontSize: ScreenUtil().setSp(20),
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AddContentButton(
                textStyle: _textStyle,
                icon: FontAwesomeIcons.solidFileImage,
                text: 'Add Illustration',
                pageName: 'add_content_image_page',
                user: widget.args.user,
              ),
              Divider(
                color: reclipIndigo,
                height: ScreenUtil().setHeight(50),
                endIndent: ScreenUtil().setWidth(80),
                indent: ScreenUtil().setWidth(80),
                thickness: ScreenUtil().setHeight(2),
              ),
              AddContentButton(
                textStyle: _textStyle,
                icon: FontAwesomeIcons.solidFileVideo,
                text: 'Add Video',
                pageName: '',
                user: widget.args.user,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddContentButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final String pageName;
  final ReclipContentCreator user;
  const AddContentButton({
    Key key,
    @required this.textStyle,
    @required this.text,
    @required this.icon,
    @required this.pageName,
    @required this.user,
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
              print("EMPTY");
            } else {
              try {
                final image =
                    await ImagePicker.pickImage(source: ImageSource.gallery);
                Routes.sailor.navigate(
                  'add_content_image_page',
                  args: AddContentImagePageArgs(
                    image: image,
                    user: user,
                  ),
                );
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
            height: ScreenUtil().setHeight(200),
            width: ScreenUtil().setWidth(200),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Icon(
                    icon,
                    size: ScreenUtil().setSp(100),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AutoSizeText(
                      text,
                      style: textStyle,
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
