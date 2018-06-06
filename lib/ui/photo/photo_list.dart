import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily/bean/tc_item.dart';
import 'package:daily/ui/photo/photo_ppt.dart';
import 'package:flutter/material.dart';

class PhotoList extends StatefulWidget {
  final List<TCItem> _photos;
  final int _pageIndex;

  PhotoList(this._photos, this._pageIndex);

  @override
  State<StatefulWidget> createState() {
    return PhotoListState();
  }
}

class PhotoListState extends State<PhotoList> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget._photos[0].title != null? widget._photos[0].title : "图片列表"),
          centerTitle: true,
          elevation: Theme.of(context).platform == TargetPlatform.iOS? 0.0 : 4.0
        ),
        body: new GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this would produce 2 rows.
            crossAxisCount: 2,
            padding: const EdgeInsets.all(2.0),
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            children: new List.generate(widget._photos.length, (index) {
              return new GestureDetector(
                  onTap: () {
                    _next(index);
                  },
                  child: Hero(
                    tag: "tag-" + widget._pageIndex.toString() + "-" + index.toString(),
                    child: CachedNetworkImage(
                      imageUrl: widget._photos[index].url,
                      placeholder: Container(
                        child: Image.asset("images/ic-pic-loading.png"),
                      ),
                      fit: BoxFit.cover,
                      errorWidget: new Icon(Icons.error),
                    ),
                  ));
            })));
  }

  void _next(index) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new PhotoPPT(widget._photos, widget._pageIndex, index);
    }));
  }
}
