import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../bloc/other_user/other_user_bloc.dart';
import '../../../../bloc/remove_illustration/remove_illustration_bloc.dart';
import '../../../../core/reclip_colors.dart';
import '../../../../core/router/route_generator.gr.dart';
import '../../../../data/model/illustration.dart';
import '../../../custom_wigets/dialogs/dialog_collection.dart';

class ContentCreatorIllustrations extends StatelessWidget {
  final List<Illustration> illustrations;
  const ContentCreatorIllustrations({Key key, this.illustrations})
      : super(key: key);

  _buildListEmpty() {
    return Container(
      decoration: BoxDecoration(color: reclipIndigoDark),
      width: double.infinity,
      height: ScreenUtil().setHeight(450),
      alignment: Alignment.center,
      child: Text(
        'No Illustrations Found',
        style: TextStyle(
            color: reclipIndigoLight, fontSize: ScreenUtil().setSp(50)),
      ),
    );
  }

  _buildListPopulated() {
    return Container(
      decoration: BoxDecoration(color: reclipIndigoDark),
      width: double.infinity,
      height: ScreenUtil().setHeight(450),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: illustrations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 100,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Hero(
                        tag: illustrations[index].title,
                        child: TransitionToImage(
                          image: AdvancedNetworkImage(
                              illustrations[index].imageUrl,
                              useDiskCache: true),
                          fit: BoxFit.cover,
                          loadingWidget: Center(
                            child: CircularProgressIndicator(),
                          ),
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
                            BlocProvider.of<OtherUserBloc>(context)
                              ..add(GetOtherUser(
                                  email: illustrations[index].authorEmail));
                            Router.navigator
                                .pushNamed(Router.illustrationContentPageRoute,
                                    arguments: IllustrationContentPageArguments(
                                      illustration: illustrations[index],
                                    ));
                          },
                          onLongPress: () {
                            DialogCollection.showConfirmationDialog(
                                    'Delete Illustration?',
                                    'You can\'t undo this action.',
                                    context)
                                .then((value) {
                              if (value) {
                                BlocProvider.of<RemoveIllustrationBloc>(context)
                                  ..add(
                                    IllustrationRemoved(
                                      illustration: illustrations[index],
                                    ),
                                  );
                              }
                            });
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

  @override
  Widget build(BuildContext context) {
    if (illustrations.isNotEmpty) {
      return _buildListPopulated();
    } else {
      return _buildListEmpty();
    }
  }
}
