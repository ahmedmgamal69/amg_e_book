import 'dart:convert';
import 'package:amg_e_book/constants/app_colors.dart' as AppColors;
import 'package:amg_e_book/screens/detail_audio_page.dart';
import 'package:amg_e_book/widgets/Custom_menu_container.dart';
import 'package:amg_e_book/widgets/Custom_material.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List? popularBooks;
  List? books;
  ScrollController? _scrollController;
  TabController? _tabController;
  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("asset/images/popularBooks.json")
        .then((s) => {
              setState(() {
                popularBooks = json.decode(s);
              })
            });
    await DefaultAssetBundle.of(context)
        .loadString("asset/images/books.json")
        .then((s) => {
              setState(() {
                books = json.decode(s);
              })
            });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.background,
        child: SafeArea(
            child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageIcon(AssetImage("asset/images/menu.png"),
                        size: 24, color: Colors.black),
                    Row(children: [
                      Icon(Icons.search),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Icon(Icons.notifications),
                    ])
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Popular Books",
                      style: TextStyle(fontSize: 30.0),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                height: 180.0,
                child: Stack(children: [
                  Positioned(
                    top: 0.0,
                    left: -20.0,
                    right: 0.0,
                    child: Container(
                      height: 180.0,
                      child: PageView.builder(
                          controller: PageController(viewportFraction: 0.8),
                          itemCount:
                              popularBooks == null ? 0 : popularBooks!.length,
                          itemBuilder: (_, i) {
                            return Container(
                              height: 180.0,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    image: AssetImage(popularBooks![i]["img"]),
                                    fit: BoxFit.fill,
                                  )),
                            );
                          }),
                    ),
                  )
                ]),
              ),
              Expanded(
                  child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder:
                          (BuildContext context, bool isScroll) {
                        return [
                          SliverAppBar(
                            pinned: true,
                            backgroundColor: AppColors.sliverBackground,
                            bottom: PreferredSize(
                                preferredSize: Size.fromHeight(50.0),
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 20.0, left: 10.0),
                                  child: TabBar(
                                      indicatorPadding:
                                          const EdgeInsets.all(0.0),
                                      indicatorSize: TabBarIndicatorSize.label,
                                      labelPadding:
                                          const EdgeInsets.only(right: 10.0),
                                      controller: _tabController,
                                      isScrollable: true,
                                      indicator: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              blurRadius: 7.0,
                                              offset: Offset(0, 0),
                                            )
                                          ]),
                                      tabs: [
                                        CustomMenuContainer(
                                          menuTitle: "New",
                                          menuColor: AppColors.menu1Color,
                                        ),
                                        CustomMenuContainer(
                                          menuTitle: "Popular",
                                          menuColor: AppColors.menu2Color,
                                        ),
                                        CustomMenuContainer(
                                          menuTitle: "Trending",
                                          menuColor: AppColors.menu3Color,
                                        ),
                                      ]),
                                )),
                          )
                        ];
                      },
                      body: TabBarView(controller: _tabController, children: [
                        ListView.builder(
                          itemCount: books == null ? 0 : books!.length,
                          itemBuilder: (_, i) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailAudioPage(
                                            booksData: books, index: i)));
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: AppColors.tabVarViewColor,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 2,
                                            offset: Offset(0, 0),
                                            color: Colors.grey.withOpacity(0.2))
                                      ]),
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 98.0,
                                          height: 120.0,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      books![i]["img"]))),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: AppColors.starColor,
                                                  size: 24.0,
                                                ),
                                                const SizedBox(
                                                  width: 5.0,
                                                ),
                                                Text(
                                                  books![i]["rating"],
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.menu2Color),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              books![i]["title"],
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontFamily: "Avenir",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              books![i]["text"],
                                              style: TextStyle(
                                                  color: AppColors.subTitleText,
                                                  fontSize: 16.0,
                                                  fontFamily: "Avenir",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: 60.0,
                                              height: 22.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color: AppColors.loveColor),
                                              child: Text(
                                                "Love",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                    fontFamily: "Avenir",
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        CustomMaterial(),
                        CustomMaterial(),
                      ])))
            ],
          ),
        )));
  }
}
