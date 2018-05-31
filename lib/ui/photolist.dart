import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily/bean/tcitem.dart';
import 'package:daily/ui/photoppt.dart';
import 'package:flutter/material.dart';

class PhotoList extends StatefulWidget {
  final photos = <TCItem>[];
  var pageIndex = 0;

  PhotoList(photos, pageIndex) {
    this.photos.addAll(photos);
    this.pageIndex = pageIndex;
  }

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
          title: new Text("图片"),
          centerTitle: true,
        ),
        body: new GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this would produce 2 rows.
            crossAxisCount: 2,
            // Generate 100 Widgets that display their index in the List
            children: new List.generate(widget.photos.length, (index) {
              return new GestureDetector(
                  onTap: () {
                    _next(index);
                  },
                  child: Hero(
                    tag: "tag-" + widget.pageIndex.toString() + "-" + index.toString(),
                    child: CachedNetworkImage(
                      imageUrl: widget.photos[index].url,
                      placeholder: Container(
                        child: Image.asset("assets/ic-pic-loading.png"),
                      ),
                      fit: BoxFit.cover,
                      errorWidget: new Icon(Icons.error),
                    ),
                  ));
            })));
  }

  void _next(index) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new PhotoPPT(widget.photos, widget.pageIndex, index);
    }));
  }
}
