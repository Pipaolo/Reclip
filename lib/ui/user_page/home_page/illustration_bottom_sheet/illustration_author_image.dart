import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/ui/user_page/profile_page/other_profile_page/other_profile_page.dart';

class IllustrationAuthorImage extends StatelessWidget {
  final ReclipUser user;
  const IllustrationAuthorImage({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(200),
      child: Container(
        height: ScreenUtil().setHeight(80),
        width: ScreenUtil().setWidth(80),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: user.channel.thumbnails['high']['url'],
                filterQuality: FilterQuality.low,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(200),
                  onTap: () {
                    Routes.sailor.navigate(
                      'other_user_profile_page',
                      args: OtherProfilePageArgs(
                        user: user,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
