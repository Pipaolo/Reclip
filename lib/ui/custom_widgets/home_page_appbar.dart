import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/ui/bloc/navigation_bloc.dart';

class HomePageAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: reclipBlack,
      elevation: 0,
      centerTitle: true,
      floating: true,
      title: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.10,
              child: Image.asset(
                'assets/images/reclip_logo_no_text.png',
                fit: BoxFit.fill,
              ),
            ),
            Flexible(
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: InkWell(
                      child: AutoSizeText(
                        'Videos',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: ScreenUtil()
                              .setSp(16, allowFontScalingSelf: true),
                        ),
                      ),
                      onTap: () => BlocProvider.of<NavigationBloc>(context)
                        ..add(ShowVideoPage()),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    flex: 3,
                    child: InkWell(
                      child: AutoSizeText(
                        'Illustrations',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: ScreenUtil()
                              .setSp(16, allowFontScalingSelf: true),
                        ),
                      ),
                      onTap: () => BlocProvider.of<NavigationBloc>(context)
                        ..add(ShowIllustrationPage()),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
