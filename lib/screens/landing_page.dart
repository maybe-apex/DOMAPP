import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/sign_in_page.dart';
import '../cache/constants.dart';

class LandingPage extends StatelessWidget {
  static const String route = 'LandingPage';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kOuterPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/vectors/login_page_header.svg',
                width: size.width * 0.9,
              ),
              Padding(
                padding: kInnerPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        "DOMAPP",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kWhite,
                            fontSize: 45),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "insert cool shit here",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: kAccentFontFamily,
                          fontSize: 20),
                    ),
                    SizedBox(height: size.height * 0.04),
                    IntrinsicHeight(
                      child: Stack(
                        children: [
                          Container(
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Color(0XFF343434),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Row(
                            children: [
                              SignInRegisterButton(heading: 'Sign In'),
                              SignInRegisterButton(heading: 'Register'),
                            ],
                          )
                        ],
                      ),
                    )
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

class SignInRegisterButton extends StatelessWidget {
  String heading;
  SignInRegisterButton({required this.heading});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Expanded(
      child: InkWell(
        onTap: () => Navigator.pushNamed(
            context, heading == 'Sign In' ? SignInPage.route : '/'),
        child: Container(
          height: size.height * 0.08,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: heading == 'Sign In' ? kWhite : Color(0XFF343434),
              borderRadius: BorderRadius.circular(8),
              boxShadow: heading == 'Sign In'
                  ? [
                      BoxShadow(
                        color: kWhite.withOpacity(0.55),
                        blurRadius: 1,
                        offset: Offset(0, 4),
                      )
                    ]
                  : null),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              heading,
              style: TextStyle(
                color: heading == 'Sign In' ? kDarkBackgroundColour : kWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
