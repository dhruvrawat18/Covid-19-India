import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ZoneCard extends StatelessWidget {
  final Color color;
  final String state;
  final String district;
  final String activeCases;
  final Color textColor;

  const ZoneCard({
    Key key,
    this.color,
    this.state,
    this.district,
    this.activeCases,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 1080, height: 2340, allowFontScaling: false);
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil().setWidth(20),
        left: ScreenUtil().setWidth(20),
        right: ScreenUtil().setWidth(20),
      ),
      child: Container(
        // width: 1000.w,
        height: 150.w,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
//              Container(
//                width: 10.w,
//                color: Colors.black,
//              ),
              Icon(
                FontAwesomeIcons.solidFlag,
                color: textColor,
              ),
              SizedBox(
                width: 40.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    state,
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        district,
                        style: GoogleFonts.montserrat(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Text(
                'Total : ' + activeCases.toString(),
                style: GoogleFonts.montserrat(
                  color: textColor,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
