import 'package:flutter/material.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';

///[CometChatAvatar] is a widget that gives a container for avatar images
/// ```dart
///        CometChatAvatar(
///            image: _showImage == true
///                ?'image url'
///                : null,
///            name: "name",
///            style: AvatarStyle(
///              background: Colors.teal,
///              outerBorderRadius: 50,
///              borderRadius: 50,
///              outerViewWidth: 5,
///              height: 50,
///              width: 50,
///            ),
///          );
/// ```
class CometChatAvatar extends StatelessWidget {
  const CometChatAvatar({
    super.key,
    this.image,
    this.name,
    this.style,
  });

  ///[image] sets the image url  for the avatar ,  will be preferred over name
  final String? image;

  ///[name] only visible when [image] tag is not passed
  final String? name;

  ///[style] contains properties that affects the appearance of this widget
  final AvatarStyle? style;

  @override
  Widget build(BuildContext context) {
    String url = "";
    String text = "AB";
    double width = 40;
    double height = 40;

    //Check if Text should be visible or image
    if (image != null && image!.isNotEmpty) {
      url = image!;
    }
    if (name != null) {
      if (name!.length >= 2) {
        text = name!.substring(0, 2).toUpperCase();
      } else {
        text = name!.toUpperCase();
      }
    }

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
            Radius.circular(style?.outerBorderRadius ?? 100.0)),
        border: style?.outerViewBorder ??
            Border.all(
              color: style?.outerViewBackgroundColor ??
                  style?.background ??
                  const Color(0xff141414).withOpacity(0.71),
              width: style?.outerViewWidth ?? 0,
            ),
        gradient: style?.gradient,
        color: style?.gradient == null
            ? style?.background ?? const Color(0xff141414).withOpacity(0.71)
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(style?.outerViewSpacing ?? 0),
        child: Container(
          width: style?.width ?? width,
          height: style?.height ?? height,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius:
                BorderRadius.all(Radius.circular(style?.borderRadius ?? 100.0)),
            border: style?.border,
          ),

          //--------on image url null or image url is not valid then show text--------
          child: url.isNotEmpty
              ? Image.network(url, errorBuilder: (context, object, stackTrace) {
                  return Center(
                    child: Text(text,
                        style: style?.nameTextStyle ??
                            const TextStyle(
                                fontSize: 17.0,
                                color: Color(0xffFFFFFF),
                                fontWeight: FontWeight.w500)),
                  );
                })
              : Center(
                  child: Text(text,
                      style: style?.nameTextStyle ??
                          const TextStyle(
                              fontSize: 17.0,
                              color: Color(0xffFFFFFF),
                              fontWeight: FontWeight.w500)),
                ),
        ),
      ),
    );
  }
}
