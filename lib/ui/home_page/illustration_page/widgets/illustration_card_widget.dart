import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../bloc/info/info_bloc.dart';
import '../../../../core/reclip_colors.dart';
import '../../../../model/illustration.dart';

class IllustrationCardWidget extends StatelessWidget {
  final Illustration illustration;
  const IllustrationCardWidget({
    Key key,
    @required this.illustration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(5, 1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: TransitionToImage(
                fit: BoxFit.cover,
                image: AdvancedNetworkImage(illustration.imageUrl),
                loadingWidget: Shimmer.fromColors(
                    child: Container(color: Colors.black),
                    direction: ShimmerDirection.ltr,
                    baseColor: Colors.grey,
                    highlightColor: Colors.white54),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              splashColor: Colors.black.withAlpha(100),
              highlightColor: Colors.black.withAlpha(180),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: reclipIndigo,
                    width: 2,
                  ),
                ),
              ),
              onTap: () {
                BlocProvider.of<InfoBloc>(context)
                  ..add(
                    ShowIllustration(
                      illustration: illustration,
                    ),
                  );
              },
            ),
          ),
        ),
        //Build Image Border
      ],
    );
  }
}
