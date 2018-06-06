import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily/bean/tc_item.dart';
import 'package:flutter/material.dart';

class PhotoPPT extends StatefulWidget {
  final List<TCItem> _photos;
  final int _index;
  final int _pageIndex;

  PhotoPPT(this._photos, this._pageIndex, this._index);

  @override
  State<StatefulWidget> createState() {
    return PhotoPPTState();
  }
}

class PhotoPPTState extends State<PhotoPPT> {
  @override
  Widget build(BuildContext context) {
    return new PageView.builder(
        controller: PageController(initialPage: widget._index),
        itemCount: widget._photos.length,
        itemBuilder: (context, i) {
          return GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Hero(
                tag: "tag-" + widget._pageIndex.toString() + "-" + i.toString(),
                child: new CachedNetworkImage(
                  imageUrl: widget._photos[i].url,
                  placeholder: Container(
                    child: Image.asset("images/ic-pic-loading.png"),
                  ),
                  fit: BoxFit.fitWidth,
                  errorWidget: new Icon(Icons.error),
                ),
              ));
        });
  }
}
