import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:member_apps/ui/shared_colors.dart';

class SharedCarousel extends StatefulWidget {
  @override
  _SharedCarouselState createState() => _SharedCarouselState();
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
];

final List<Widget> imageSliders = imgList.map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(item, fit: BoxFit.cover, width: 354.0),
    ),
  ),
)).toList();

class _SharedCarouselState extends State<SharedCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
                autoPlay: true,
                disableCenter: true,
                autoPlayInterval: const Duration(seconds: 8),
                enlargeCenterPage: false,
                viewportFraction: 0.8,
                aspectRatio: 354/164,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 0.1*MediaQuery.of(context).size.width),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: imgList.map((url) {
                int index = imgList.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? SharedColors.primaryOrangeColor
                        : SharedColors.gray2Color,
                  ),
                );
              }).toList(),
            ),
          ),
        ]
    );
  }
}
