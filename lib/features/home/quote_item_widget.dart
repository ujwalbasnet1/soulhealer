import 'package:flutter/material.dart';

const double _padding = 24;

class QuoteItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFF055762).withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      height: 300,
      width: 264,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                    top: _padding,
                    left: _padding,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                    ),
                    // color: Colors.orangeAccent,
                  ),
                  child: Icon(
                    Icons.import_contacts,
                    size: 64,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: 120,
                height: 120,
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(
                  right: _padding,
                  top: _padding,
                ),
                decoration: BoxDecoration(
                  color: Color(0XFF055762),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(100),
                  ),
                ),
                child: Text(
                  'Albert\nEinstein',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(_padding),
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(_padding),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF08383d), width: 0.75),
                    ),
                    child: Center(
                      child: Text(
                        'Enjoy every drop of what life is offering Enjoy Enjoy every drop of what',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -12,
                    left: -12,
                    child: Icon(
                      Icons.format_quote,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Positioned(
                    bottom: -12,
                    right: -12,
                    child: Icon(
                      Icons.format_quote,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
