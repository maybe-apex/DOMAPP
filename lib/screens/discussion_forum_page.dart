import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../cache/constants.dart';
import '../cache/local_data.dart';
import '../components/custom_navigation_bar.dart';
import 'discussion_thread_page.dart';

List<Color> colorList = [kRed, kYellow, kGreen];
List<String> sortMethods = [
  'Rating',
  'Alphabetically',
  'Joining Year',
];
String? selectedSort = sortMethods.first;
TextEditingController filterController = TextEditingController();
List<String> timeFrames = ['Today', 'This Week', 'This Month', 'All Time'];
String? selectedTimeFrame = timeFrames.first;

class DiscussionForumPage extends StatefulWidget {
  static String route = 'DiscussionForumPage';

  @override
  _DiscussionForumPageState createState() => _DiscussionForumPageState();
}

class _DiscussionForumPageState extends State<DiscussionForumPage> {
  String query = '';

  List<Post> filteredPosts = postList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kOuterPadding.add(EdgeInsets.symmetric(horizontal: 20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(context),
                      child: SvgPicture.asset(
                        'assets/icons/options_button_titlebar.svg',
                        color: kWhite,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: kBlue,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                              color: kBlue.withOpacity(0.65),
                              offset: Offset(0, 3),
                              blurRadius: 3),
                        ]),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/create_post.svg',
                          height: 20,
                          color: Colors.white,
                        ),
                        SizedBox(width: size.width * 0.015),
                        Text(
                          'Create Post',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                'Discussion Forum',
                style: TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              SortFilterWrapper(onChanged: searchPosts),
              Expanded(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PostListBuilder(
                        filteredPosts: filteredPosts,
                        index: index,
                      );
                    },
                    itemCount: filteredPosts.length),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        activePage: DiscussionForumPage.route,
      ),
    );
  }

  void searchPosts(String query) {
    final result = postList.where((post) {
      final titleLower = post.title.toLowerCase();
      final authorLower = post.authorName.toLowerCase();
      final tagLower = post.tags.join(' ').toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower) ||
          tagLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.filteredPosts = result;
    });
  }
}

class PostListBuilder extends StatelessWidget {
  const PostListBuilder({
    Key? key,
    required this.filteredPosts,
    required this.index,
  }) : super(key: key);

  final List<Post> filteredPosts;
  final int index;

  @override
  Widget build(BuildContext context) {
    final selectedColor = colorList[index % 3];
    final selectedPost = filteredPosts[index];
    return InkWell(
      onTap: () =>
          Navigator.push((context), MaterialPageRoute(builder: (context) {
        return DiscussionThreadPage(
          post: selectedPost,
        );
      })),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 10,
                color: selectedColor,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      selectedPost.title,
                      style: TextStyle(
                          fontFamily: 'Satisfy', fontSize: 18, color: kWhite),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          selectedPost.authorName,
                          style: TextStyle(fontSize: 12, color: kWhite),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '#' + selectedPost.tags.join(' #'),
                          style: TextStyle(
                              fontSize: 11,
                              color: kWhite,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/heart_hollow.svg',
                                  color: selectedColor,
                                  height: 15,
                                ),
                                Text(
                                  '  ${selectedPost.likes}',
                                  style: TextStyle(
                                    color: selectedColor,
                                    fontSize: 13,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/message.svg',
                                  color: selectedColor,
                                  height: 15,
                                ),
                                Text(
                                  '  11',
                                  style: TextStyle(
                                    color: selectedColor,
                                    fontSize: 13,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: 10),
                            SvgPicture.asset(
                              'assets/icons/star_hollow.svg',
                              color: KGold,
                              height: 15,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/share.svg',
                              color: kGreen,
                              height: 15,
                            ),
                            SizedBox(width: 10),
                            Text(
                              DateFormat('MMM dd yyyy')
                                  .format(selectedPost.dateCreated),
                              style: TextStyle(
                                color: kWhite.withOpacity(0.6),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SortFilterWrapper extends StatefulWidget {
  final ValueChanged<String> onChanged;
  SortFilterWrapper({required this.onChanged});
  @override
  _SortFilterWrapperState createState() => _SortFilterWrapperState();
}

class _SortFilterWrapperState extends State<SortFilterWrapper> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.025),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
          color: kBlue,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: kBlue.withOpacity(0.65),
                offset: Offset(0, 3),
                blurRadius: 3),
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kWhite,
                  boxShadow: [
                    BoxShadow(
                        color: kDarkBackgroundColour.withOpacity(0.45),
                        offset: Offset(0, 4),
                        blurRadius: 4),
                  ],
                ),
                child: DropdownButton(
                  icon: SvgPicture.asset(
                    'assets/icons/expand_down.svg',
                  ),
                  iconSize: 20,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kDarkBackgroundColour,
                      fontFamily: 'Montserrat'),
                  isExpanded: true,
                  isDense: true,
                  value: selectedSort,
                  items: sortMethods.map((value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedSort = value;
                    });
                  },
                  underline: Container(height: 0),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: size.width * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kWhite,
                  boxShadow: [
                    BoxShadow(
                        color: kDarkBackgroundColour.withOpacity(0.45),
                        offset: Offset(0, 4),
                        blurRadius: 4),
                  ],
                ),
                child: DropdownButton(
                  icon: SvgPicture.asset(
                    'assets/icons/expand_down.svg',
                  ),
                  iconSize: 20,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kDarkBackgroundColour,
                      fontFamily: 'Montserrat'),
                  isExpanded: true,
                  isDense: true,
                  value: selectedTimeFrame,
                  items: timeFrames.map((value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedTimeFrame = value;
                    });
                  },
                  underline: Container(height: 0),
                ),
              ),
            ],
          ),
          Container(
            width: size.width * 0.9,
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: kDarkBackgroundColour.withOpacity(0.45),
                    blurRadius: 4,
                    offset: Offset(0, 4))
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: filterController,
              decoration: InputDecoration(
                fillColor: kWhite,
                isDense: true,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: kWhite,
                    width: 0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: kWhite,
                    width: 0,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                prefixIcon: Icon(
                  Icons.search,
                  color: kDarkBackgroundColour,
                ),
                suffixIcon: filterController.text != ''
                    ? GestureDetector(
                        child: Icon(
                          Icons.close,
                          color: kDarkBackgroundColour,
                        ),
                        onTap: () {
                          filterController.clear();
                          widget.onChanged('');
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      )
                    : null,
                hintText: 'Search by name or branch',
                hintStyle: TextStyle(
                  color: kDarkBackgroundColour.withOpacity(0.3),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              style: TextStyle(
                color: kDarkBackgroundColour.withOpacity(0.7),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              onChanged: widget.onChanged,
            ),
          )
        ],
      ),
    );
  }
}