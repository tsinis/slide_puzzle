import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Area extends StatelessWidget {
  Area({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: 10.0, end: 10.0),
            Pin(start: 0.0, end: 20.0),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(size: 24.0, middle: 0.5),
                  Pin(size: 24.0, start: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      border: Border.all(
                          width: 5.0, color: const Color(0xff951616)),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 1.0, middle: 0.5022),
                  Pin(size: 60.0, start: 20.0),
                  child: SvgPicture.string(
                    _svg_ckosko,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 24.0, middle: 0.5),
                  Pin(size: 24.0, end: 0.0),
                  child: Transform.rotate(
                    angle: 3.1416,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        border: Border.all(
                            width: 5.0, color: const Color(0xff951616)),
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 1.0, middle: 0.5022),
                  Pin(size: 60.0, end: 20.0),
                  child: SvgPicture.string(
                    _svg_wmgog,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 24.0, end: 0.0),
                  Pin(size: 24.0, middle: 0.5),
                  child: Transform.rotate(
                    angle: 1.5708,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        border: Border.all(
                            width: 5.0, color: const Color(0xff951616)),
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 60.0, end: 20.0),
                  Pin(size: 1.0, middle: 0.5022),
                  child: SvgPicture.string(
                    _svg_gdig7v,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 24.0, start: 0.0),
                  Pin(size: 24.0, middle: 0.5),
                  child: Transform.rotate(
                    angle: -1.5708,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        border: Border.all(
                            width: 5.0, color: const Color(0xff951616)),
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 60.0, start: 20.0),
                  Pin(size: 1.0, middle: 0.5022),
                  child: SvgPicture.string(
                    _svg_u3a,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 24.0, middle: 0.75),
                  Pin(size: 24.0, start: 13.8),
                  child: Transform.rotate(
                    angle: 0.5236,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        border: Border.all(
                            width: 5.0, color: const Color(0xff951616)),
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 30.0, middle: 0.6625),
                  Pin(size: 52.0, start: 32.7),
                  child: SvgPicture.string(
                    _svg_y86gd,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 24.0, middle: 0.25),
                  Pin(size: 24.0, end: 13.8),
                  child: Transform.rotate(
                    angle: 3.6652,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        border: Border.all(
                            width: 5.0, color: const Color(0xff951616)),
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 30.0, middle: 0.3375),
                  Pin(size: 52.0, end: 32.7),
                  child: SvgPicture.string(
                    _svg_ivdeu0,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 24.0, end: 13.8),
                  Pin(size: 24.0, middle: 0.75),
                  child: Transform.rotate(
                    angle: 2.0944,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        border: Border.all(
                            width: 5.0, color: const Color(0xff951616)),
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 52.0, end: 32.7),
                  Pin(size: 30.0, middle: 0.6625),
                  child: SvgPicture.string(
                    _svg_ylynai,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 24.0, start: 13.8),
                  Pin(size: 24.0, middle: 0.25),
                  child: Transform.rotate(
                    angle: -1.0472,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        border: Border.all(
                            width: 5.0, color: const Color(0xff951616)),
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 52.0, start: 32.7),
                  Pin(size: 30.0, middle: 0.3375),
                  child: SvgPicture.string(
                    _svg_a8wxgq,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 24.0, end: 13.8),
                  Pin(size: 24.0, middle: 0.25),
                  child: Transform.rotate(
                    angle: 1.0472,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        border: Border.all(
                            width: 5.0, color: const Color(0xff951616)),
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 52.0, end: 32.7),
                  Pin(size: 30.0, middle: 0.3375),
                  child: SvgPicture.string(
                    _svg_f3qw57,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 24.0, start: 13.8),
                  Pin(size: 24.0, middle: 0.75),
                  child: Transform.rotate(
                    angle: 4.1888,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        border: Border.all(
                            width: 5.0, color: const Color(0xff951616)),
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 52.0, start: 32.7),
                  Pin(size: 30.0, middle: 0.6625),
                  child: SvgPicture.string(
                    _svg_ryr,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 24.0, middle: 0.75),
                  Pin(size: 24.0, end: 13.8),
                  child: Transform.rotate(
                    angle: 2.618,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        border: Border.all(
                            width: 5.0, color: const Color(0xff951616)),
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 30.0, middle: 0.6625),
                  Pin(size: 52.0, end: 32.7),
                  child: SvgPicture.string(
                    _svg_pt,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 24.0, middle: 0.25),
                  Pin(size: 24.0, start: 13.8),
                  child: Transform.rotate(
                    angle: -0.5236,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        border: Border.all(
                            width: 5.0, color: const Color(0xff951616)),
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 30.0, middle: 0.3375),
                  Pin(size: 52.0, start: 32.7),
                  child: SvgPicture.string(
                    _svg_js9tz4,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: 10.0, end: 10.0),
            Pin(start: 24.0, end: 0.0),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 25.0, end: 25.0),
                  Pin(size: 180.0, start: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      border: Border.all(
                          width: 5.0, color: const Color(0xff707070)),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 41.0, end: 40.0),
                  Pin(size: 149.0, start: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      border: Border.all(
                          width: 5.0, color: const Color(0xff707070)),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 75.0, middle: 0.5032),
                  Pin(size: 75.0, middle: 0.351),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      border: Border.all(
                          width: 5.0, color: const Color(0xff707070)),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 50.0, middle: 0.5),
                  Pin(size: 50.0, middle: 0.3693),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      border: Border.all(
                          width: 5.0, color: const Color(0xff707070)),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(size: 15.0, end: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                          width: 6.0, color: const Color(0xff707070)),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 25.0, middle: 0.3902),
                  Pin(size: 90.0, end: 10.0),
                  child: SvgPicture.string(
                    _svg_csig38,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 25.0, middle: 0.6098),
                  Pin(size: 90.0, end: 10.0),
                  child: SvgPicture.string(
                    _svg_lk4k5a,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_ckosko =
    '<svg viewBox="125.0 20.0 1.0 60.0" ><path transform="translate(125.0, 20.0)" d="M 0 60 L 0 0" fill="none" stroke="#951616" stroke-width="4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_wmgog =
    '<svg viewBox="125.0 150.0 1.0 60.0" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 125.0, 210.0)" d="M 0 60 L 0 0" fill="none" stroke="#951616" stroke-width="4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_gdig7v =
    '<svg viewBox="160.0 115.0 60.0 1.0" ><path transform="matrix(0.0, 1.0, -1.0, 0.0, 220.0, 115.0)" d="M 0 60 L 0 0" fill="none" stroke="#951616" stroke-width="4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_u3a =
    '<svg viewBox="30.0 115.0 60.0 1.0" ><path transform="matrix(0.0, -1.0, 1.0, 0.0, 30.0, 115.0)" d="M 0 60 L 0 0" fill="none" stroke="#951616" stroke-width="4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_y86gd =
    '<svg viewBox="142.5 32.7 30.0 52.0" ><path transform="matrix(0.866025, 0.5, -0.5, 0.866025, 172.5, 32.73)" d="M 0 60 L 0 0" fill="none" stroke="#951616" stroke-width="4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ivdeu0 =
    '<svg viewBox="77.5 145.3 30.0 52.0" ><path transform="matrix(-0.866025, -0.5, 0.5, -0.866025, 77.5, 197.27)" d="M 0 60 L 0 0" fill="none" stroke="#951616" stroke-width="4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ylynai =
    '<svg viewBox="155.3 132.5 52.0 30.0" ><path transform="matrix(-0.5, 0.866025, -0.866025, -0.5, 207.27, 162.5)" d="M 0 60 L 0 0" fill="none" stroke="#951616" stroke-width="4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_a8wxgq =
    '<svg viewBox="42.7 67.5 52.0 30.0" ><path transform="matrix(0.5, -0.866025, 0.866025, 0.5, 42.73, 67.5)" d="M 0 60 L 0 0" fill="none" stroke="#951616" stroke-width="4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_f3qw57 =
    '<svg viewBox="155.3 67.5 52.0 30.0" ><path transform="matrix(0.5, 0.866025, -0.866025, 0.5, 207.27, 67.5)" d="M 0 60 L 0 0" fill="none" stroke="#951616" stroke-width="4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ryr =
    '<svg viewBox="42.7 132.5 52.0 30.0" ><path transform="matrix(-0.5, -0.866025, 0.866025, -0.5, 42.73, 162.5)" d="M 0 60 L 0 0" fill="none" stroke="#951616" stroke-width="4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_pt =
    '<svg viewBox="142.5 145.3 30.0 52.0" ><path transform="matrix(-0.866025, 0.5, -0.5, -0.866025, 172.5, 197.27)" d="M 0 60 L 0 0" fill="none" stroke="#951616" stroke-width="4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_js9tz4 =
    '<svg viewBox="77.5 32.7 30.0 52.0" ><path transform="matrix(0.866025, -0.5, 0.5, 0.866025, 77.5, 32.73)" d="M 0 60 L 0 0" fill="none" stroke="#951616" stroke-width="4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_csig38 =
    '<svg viewBox="90.0 150.0 25.0 90.0" ><path transform="translate(90.0, 150.0)" d="M 25 0 L 0 90" fill="none" stroke="#707070" stroke-width="6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_lk4k5a =
    '<svg viewBox="135.0 150.0 25.0 90.0" ><path transform="translate(135.0, 150.0)" d="M 0 0 L 25 90" fill="none" stroke="#707070" stroke-width="6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
