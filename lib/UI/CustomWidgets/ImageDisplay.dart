import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/UI/DestinationDisplay/Widgets/BG.dart';

class ImageDisplay extends StatelessWidget {
  ImageDisplay(this.imageUrl);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        BG(),
        Center(
          child: InteractiveViewer(
            panEnabled: true, // Set it to false
            boundaryMargin: EdgeInsets.all(0),
            minScale: 0.5,
            maxScale: 3,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: CachedNetworkImage(
                fit: BoxFit.fitWidth,
                imageUrl: imageUrl,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                    strokeWidth: 2.5,
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/images/noImage.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
