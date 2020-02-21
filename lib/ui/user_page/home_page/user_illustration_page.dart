import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/illustration/illustrations_bloc.dart';
import '../../../bloc/info/info_bloc.dart';
import '../../../bloc/other_user/other_user_bloc.dart';
import 'illustration_bottom_sheet/illustration_bottom_sheet.dart';
import 'illustration_widgets/illustration_widget.dart';
import 'illustration_widgets/popular_illustration_widget.dart';
import 'user_home_page_appbar.dart';

class UserIllustrationPage extends StatelessWidget {
  const UserIllustrationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<InfoBloc, InfoState>(
        listener: (context, state) {
          if (state is ShowIllustrationInfo) {
            BlocProvider.of<OtherUserBloc>(context)
              ..add(GetOtherUser(email: state.illustration.authorEmail));
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return DraggableScrollableSheet(
                  initialChildSize: 1,
                  expand: true,
                  builder: (context, scrollController) {
                    return IllustrationBottomSheet(
                      illustration: state.illustration,
                      scrollController: scrollController,
                    );
                  },
                );
              },
            );
          }
        },
        child: BlocBuilder<IllustrationsBloc, IllustrationsState>(
          builder: (context, state) {
            if (state is IllustrationsSuccess) {
              return CustomScrollView(
                slivers: <Widget>[
                  HomePageAppBar(),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Column(
                        children: <Widget>[
                          PopularIllustrationWidget(
                              illustration: state.illustrations[0]),
                          IllustrationWidget(),
                        ],
                      )
                    ]),
                  )
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
