import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/bloc/illustration/illustrations_bloc.dart';
import 'package:reclip/bloc/info/info_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/illustration.dart';

class IllustrationWidget extends StatelessWidget {
  const IllustrationWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            color: reclipIndigo,
            child: Text(
              'Illustrations'.toUpperCase(),
              style: TextStyle(
                color: reclipBlack,
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(15),
                wordSpacing: 2,
              ),
            ),
          ),
          BlocBuilder<IllustrationsBloc, IllustrationsState>(
            builder: (context, state) {
              if (state is IllustrationsLoading) {
                return _buildLoadingState();
              } else if (state is IllustrationsSuccess) {
                return _buildSuccessState(state.illustrations);
              } else if (state is IllustrationsError) {
                return _buildErrorState(state.errorText);
              } else if (state is IllustrationsInitial) {
                return _buildInitialState();
              }
              //Supress Warning
              return Container();
            },
          ),
        ],
      ),
    );
  }

  _buildSuccessState(List<Illustration> illustrations) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(200),
      color: reclipIndigoDark,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: illustrations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: ScreenUtil().setWidth(125),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Hero(
                        tag: illustrations[index].title,
                        child: CachedNetworkImage(
                          imageUrl: illustrations[index].imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.black.withAlpha(100),
                          highlightColor: Colors.black.withAlpha(180),
                          onTap: () {
                            BlocProvider.of<InfoBloc>(context)
                              ..add(
                                ShowIllustration(
                                  illustration: illustrations[index],
                                ),
                              );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildErrorState(String errorText) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(200),
      color: reclipIndigoDark,
      child: Center(
        child: Text(
          'Error',
          style: TextStyle(
            color: reclipBlack,
            fontSize: ScreenUtil().setSp(20),
          ),
        ),
      ),
    );
  }

  _buildLoadingState() {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(200),
      color: reclipIndigoDark,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  _buildInitialState() {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(200),
      color: reclipIndigoDark,
      child: Center(
        child: Text(
          'Empty',
          style: TextStyle(
            color: reclipBlack,
            fontSize: ScreenUtil().setSp(20),
          ),
        ),
      ),
    );
  }
}
