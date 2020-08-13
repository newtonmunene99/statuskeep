import 'package:statuskeep/config/flavors.dart';
import 'package:statuskeep/utils/device_info_dialog.dart';
import 'package:flutter/material.dart';

/// A banner to show over the app's content. Differentiates between different flavors and does not show during production
class FlavorBanner extends StatelessWidget {
  /// The widget to display under the banner
  final Widget child;

  /// COnfiguration for [FlavorBanner]
  final BannerConfig bannerConfig;

  /// A banner to show over the app's content. Differentiates between different flavors and does not show during production
  const FlavorBanner({
    @required this.bannerConfig,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (FlavorConfig.isProduction()) return child;

    return Stack(
      textDirection: TextDirection.ltr,
      children: <Widget>[
        child,
        _buildBanner(context),
      ],
    );
  }

  Widget _buildBanner(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const DeviceInfoDialog();
          },
        );
      },
      child: Container(
        width: 50,
        height: 50,
        child: CustomPaint(
          painter: BannerPainter(
            message: bannerConfig.bannerName,
            textDirection: TextDirection.ltr,
            layoutDirection: TextDirection.ltr,
            location: BannerLocation.topStart,
            color: bannerConfig.bannerColor,
          ),
        ),
      ),
    );
  }
}

/// Configuration for our [FlavorBanner]
class BannerConfig {
  /// Banner's name. Will be written inside the banner
  final String bannerName;

  /// Banner's background color
  final Color bannerColor;

  /// Configuration for our [FlavorBanner]
  const BannerConfig({
    @required this.bannerName,
    @required this.bannerColor,
  });
}
