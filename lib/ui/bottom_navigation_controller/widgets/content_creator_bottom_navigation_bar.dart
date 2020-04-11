import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/ui/bloc/bottom_navigation/bottom_navigation_bloc.dart';

class ContentCreatorBottomNavigationBar extends StatelessWidget {
  const ContentCreatorBottomNavigationBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, int>(
      builder: (context, currentIndex) {
        return CurvedNavigationBar(
          height: kBottomNavigationBarHeight,
          buttonBackgroundColor: reclipIndigoDark,
          color: reclipBlack,
          backgroundColor: Colors.white,
          items: <Widget>[
            Icon(Icons.home, color: Colors.white),
            Icon(Icons.add, color: Colors.white),
            Icon(Icons.person, color: Colors.white),
          ],
          onTap: (index) {
            context.bloc<BottomNavigationBloc>()
              ..add(NavigationItemPressed(index: index));
          },
          index: currentIndex,
        );
      },
    );
  }
}
