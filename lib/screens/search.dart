
import 'package:ecommerceapplication/models/product_model.dart';
import 'package:ecommerceapplication/screens/feeds.dart';
import 'package:ecommerceapplication/screens/search_header_widget.dart';
import 'package:ecommerceapplication/shared/cubit/home_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:provider/provider.dart';

import '../shared/themes/colors.dart';
import 'home.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late TextEditingController _searchTextController;
  final FocusNode _node = FocusNode();
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _searchTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _node.dispose();
    _searchTextController.dispose();
  }

  List<ProductModel> _searchList = [];
  @override
  Widget build(BuildContext context) {
     return WillPopScope(
       onWillPop: (){return showExitPopup(context);},

       child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              floating: true,
              pinned: true,
              delegate: SearchByHeader(
                stackPaddingTop: 175,
                titlePaddingTop: 50,
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Search",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorsConsts.title,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                stackChild: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 1,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _searchTextController,
                    minLines: 1,
                    focusNode: _node,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      hintText: 'Search',
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      suffixIcon: IconButton(
                        onPressed: _searchTextController.text.isEmpty
                            ? null
                            : () {
                          _searchTextController.clear();
                          _node.unfocus();
                        },
                        icon: Icon(Icons.close,
                            color: _searchTextController.text.isNotEmpty
                                ? Colors.red
                                : Colors.grey),
                      ),
                    ),
                    onChanged: (value) {
                      _searchTextController.text.toLowerCase();
                      setState(() {
                        _searchList = HomeCubit.get(context).searchQuery(value);
                      });
                    },
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _searchTextController.text.isNotEmpty && _searchList.isEmpty
                  ? Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Icon(
                    Icons.search,
                    size: 60,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'No results found',
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                ],
              )
                  : GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 240 / 420,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: List.generate(
                    _searchTextController.text.isEmpty
                        ? HomeCubit.get(context).products.length
                        : _searchList.length, (index) {
                  return BlocConsumer<HomeCubit,HomeStates>(
                    listener: (context,state){},
                    builder: (context,state){
                      var list;
                      _searchTextController.text.isEmpty
                          ?   list= HomeCubit.get(context).products[index]
                          : list =_searchList[index];
                      return productItem(context, list, index);
                    },

                  );
                }),
              ),
            ),
          ],
        ),
    ),
     );
  }
}
