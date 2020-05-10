import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reclip/model/illustration.dart';
import 'package:reclip/ui/custom_widgets/ad_widget.dart';
import 'illustration_card_widget.dart';

class IllustrationListWidget extends StatelessWidget {
  final List<Illustration> illustrations;
  const IllustrationListWidget({
    Key key,
    @required this.illustrations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      itemCount: illustrations.length + (illustrations.length ~/ 4),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      staggeredTileBuilder: (index) {
        final bool showAdvertisement = index % 4 == 0 && index != 0;
        if (showAdvertisement) {
          return StaggeredTile.fit(2);
        } else {
          return StaggeredTile.count(
            1,
            (index.isEven) ? 1.5 : 1,
          );
        }
      },
      itemBuilder: (context, i) {
        if (i % 4 == 0 && i != 0) {
          return Center(
            child: AdWidget(
              adUnitId: 'ca-app-pub-5477568157944659/6678075258',
              admobBannerSize: AdmobBannerSize.LARGE_BANNER,
            ),
          );
        } else if (i > 4) {
          final illustration = illustrations[i - 1];
          return IllustrationCardWidget(
            illustration: illustration,
          );
        } else {
          final illustration = illustrations[i];
          return IllustrationCardWidget(
            illustration: illustration,
          );
        }
      },
    );
  }
}
