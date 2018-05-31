import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily/bean/tcitem.dart';
import 'package:flutter/material.dart';

class PhotoPPT extends StatefulWidget {
  final photos = <TCItem>[];
  var index = 0;
  var pageIndex = 0;

  PhotoPPT(photos, pageIndex, index) {
    this.photos.addAll(photos);
    this.index = index;
    this.pageIndex = pageIndex;
  }

  @override
  State<StatefulWidget> createState() {
    return PhotoPPTState();
  }
}

class PhotoPPTState extends State<PhotoPPT> {
  @override
  Widget build(BuildContext context) {
    return new PageView.builder(
        controller: PageController(initialPage: widget.index),
        itemCount: widget.photos.length,
        itemBuilder: (context, i) {
          return GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Hero(
                tag: "tag-" + widget.pageIndex.toString() + "-" + i.toString(),
                child: new CachedNetworkImage(
                  imageUrl: widget.photos[i].url,
                  placeholder: Container(
                    child: Image.asset("assets/ic-pic-loading.png"),
                  ),
                  fit: BoxFit.fitWidth,
                  errorWidget: new Icon(Icons.error),
                ),
              ));
        });
  }
}
