import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'constants_for_search_screen_top.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreenTop extends StatelessWidget {

  double size;
  var searchText= TextEditingController();
  static String searchstring = TextEditingController().text;
  SearchScreenTop( double sizeValue )
  {
    size= sizeValue;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight= MediaQuery.of(context).size.height;
    double screenwidth= MediaQuery.of(context).size.width;
    return new Scaffold(
      body: new Container(
        margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5, top: kDefaultPadding * 3),
        height: size*0.2+27,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Party",
                    style: GoogleFonts.overpass(color: Colors.black, fontSize: 32, fontWeight: FontWeight.w200 ),
                  ),
                  Text(
                    "Plus",
                    style: GoogleFonts.overpass(color: Color(0xFF008A8C), fontSize: 32, fontWeight: FontWeight.bold ),
                  )
                ],
              ),
            ),
            Spacer(),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(10, 10),
                    blurRadius: 50,
                    color: Colors.black26.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: screenwidth*0.7,
                    child: TextField(
                      controller: searchText,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "Destination, property or address",
                        hintStyle: TextStyle(
                          color: Color(0xFF003333),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        // surffix isn't working properly  with SVG
                        // thats why we use row
                        // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                      ),
                    ),
                  ),
                  SvgPicture.asset("assets/icons/search.svg"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}