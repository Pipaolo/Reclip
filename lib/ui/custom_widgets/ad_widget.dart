import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

class AdWidget extends StatefulWidget {
  final String adUnitId;
  final AdmobBannerSize admobBannerSize;
  AdWidget({
    Key key,
    @required this.adUnitId,
    @required this.admobBannerSize,
  }) : super(key: key);

  @override
  _AdWidgetState createState() => _AdWidgetState();
}

class _AdWidgetState extends State<AdWidget> {
  bool isLoading = true;
  AdmobBannerController adMobBannerController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (isLoading)
          Center(
            child: CircularProgressIndicator(),
          ),
        AdmobBanner(
          adSize: widget.admobBannerSize,
          adUnitId: widget.adUnitId,
          onBannerCreated: (controller) => setState(() {
            isLoading = false;
            adMobBannerController = controller;
          }),
        ),
      ],
    );
  }
}
