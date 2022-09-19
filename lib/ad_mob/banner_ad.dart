import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBanner extends StatefulWidget {
  final String bannerId;

  AdBanner(this.bannerId);
  @override
  _AdBannerState createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  BannerAd bannerAd;
  bool isAdReady = false;

  final AdSize _adSize = AdSize.banner;

  void _creatBannerAd() {
    bannerAd = BannerAd(
      size: _adSize,
      adUnitId: '${widget.bannerId}',
      // adUnitId: 'ca-app-pub-1206837523110524/1697130714',
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          isAdReady = true;
        });
      }),
      request: const AdRequest(),
    );

    bannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    _creatBannerAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isAdReady) {
      return Container(
        alignment: Alignment.center,
        width: _adSize.width.toDouble(),
        height: _adSize.height.toDouble(),
        child: AdWidget(
          ad: bannerAd,
        ),
      );
    }
    return Container();
  }
}
