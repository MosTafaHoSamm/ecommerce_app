import 'package:flutter/material.dart';

class RailWidget extends StatelessWidget {
  const RailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      margin: EdgeInsets.only(right: 20, bottom: 5, top: 18),
      constraints: BoxConstraints(
          minHeight: 150, maxHeight: 180, minWidth: double.infinity),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://m.media-amazon.com/images/I/61N+-WYoOfL._AC_SX342_SY445_.jpg"),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 3, offset: Offset(2, 2))
                  ]),
            ),
          ),
          FittedBox(
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade700,
                        blurRadius: 10,
                        offset: Offset(5, 5))
                  ],
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              width: 160,
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textSelectionColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      child: Text(
                        "US 16 \$",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w600,
                            fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "CategoryName",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textSelectionColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

