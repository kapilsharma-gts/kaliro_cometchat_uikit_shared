import 'package:flutter/material.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';
import 'package:flutter_image/network.dart';
import 'dart:math';

///Gives Full Screen image view for passed image url
class ImageViewer extends StatefulWidget {
  const ImageViewer({
    super.key,
    required this.imageUrl,
    this.backIconColor,
    this.backgroundColor,
    this.theme,
    this.placeholderImage,
    this.placeHolderImagePackageName,
  });

  ///[imageUrl] image url should be passed
  final String imageUrl;

  final Color? backIconColor;

  final Color? backgroundColor;

  ///[theme] set custom theme
  final CometChatTheme? theme;

  ///[placeholderImage] is shown temporarily for the duration when image is loading from url
  final String? placeholderImage;

  ///[placeHolderImagePackageName] is package path for the custom placeholder image
  final String? placeHolderImagePackageName;

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  Key imageKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: widget.backgroundColor ?? const Color(0xffFFFFFF),
        iconTheme: IconThemeData(
            color: widget.backIconColor ?? const Color(0xff3399FF)),
      ),
      backgroundColor: widget.backgroundColor ?? const Color(0xffFFFFFF),
      body: Center(
        child: FadeInImage(
          key: imageKey,
          placeholder: AssetImage(
            widget.placeholderImage ?? AssetConstants.imagePlaceholder,
            package:
                widget.placeHolderImagePackageName ?? UIConstants.packageName,
          ),
          fit: BoxFit.cover,
          placeholderFit: BoxFit.contain,
          imageErrorBuilder: (context, object, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        imageCache.evict(
                          NetworkImageWithRetry(widget.imageUrl),
                        );
                        imageKey = ValueKey(
                            widget.imageUrl + DateTime.now().toString());
                      });
                    },
                    icon: Image.asset(
                      AssetConstants.refreshIcon,
                      height: 24,
                      width: 24,
                      package: UIConstants.packageName,
                      color: widget.theme?.palette.getAccent700(),
                    ),
                  ),
                ],
              ),
            );
          },
          image: NetworkImageWithRetry(
            widget.imageUrl,
            fetchStrategy: (Uri uri, FetchFailure? failure) async {
              const int maxAttempts = 7;
              const int baseDelaySeconds = 1;
              if (failure == null) {
                return FetchInstructions.attempt(
                  uri: uri,
                  timeout: const Duration(seconds: 10),
                );
              } else if (failure.attemptCount < maxAttempts) {
                final int delaySeconds =
                    (baseDelaySeconds * pow(2, failure.attemptCount - 1))
                        .toInt();
                await Future.delayed(Duration(seconds: delaySeconds));
                return FetchInstructions.attempt(
                  uri: uri,
                  timeout: Duration(seconds: 10 + delaySeconds),
                );
              } else {
                return FetchInstructions.giveUp(uri: uri);
              }
            },
          ),
        ),
      ),
    );
  }
}
