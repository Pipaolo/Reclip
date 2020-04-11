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
            Image.asset(
              'assets/images/reclip_logo_no_text.png',
              height: 80,
              width: 80,
            ),
            SizedBox(
              width: ScreenUtil().setWidth(8),
            ),
            InkWell(
              child: Text('Videos'),
              onTap: () => BlocProvider.of<NavigationBloc>(context)
                ..add(ShowVideoPage()),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(30),
            ),
            InkWell(
              child: Text('Illustrations'),
              onTap: () => BlocProvider.of<NavigationBloc>(context)
                ..add(ShowIllustrationPage()),
            ),
          ],
        ),
      ),
    );
  }
}
