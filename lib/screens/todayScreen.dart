import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../model/user.dart';
import 'package:mx_month_picker/mx_month_picker.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  bool isFinished = false;
  String checkIn = "--/--";
  String checkOut = "--/--";

  @override
  void initState() {
    super.initState();
    _getRecord();
  }

  void _getRecord() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("Employee")
          .where('id', isEqualTo: User1.employeeId)
          .get();

      DocumentSnapshot snap2 = await FirebaseFirestore.instance
          .collection("Employee")
          .doc(snap.docs[0].id)
          .collection("Record")
          .doc(
            DateFormat('dd MMMM yyyy').format(DateTime.now()),
          )
          .get();
      setState(() {
        checkIn = snap2['checkIn'];
        checkIn = snap2['checkOut'];
      });

      print(checkIn);
      print(checkOut);
    } catch (e) {
      setState(() {
        checkIn = "--/--";
        checkOut = "--/--";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 40),
              child: Text(
                "Welcome,",
                style: GoogleFonts.lato(
                  color: Colors.black54,
                  fontSize: screenWidth / 22,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Employee " + User1.employeeId,
                style: GoogleFonts.lato(
                  fontSize: screenWidth / 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 40),
              child: Text(
                "Today's Status",
                style: GoogleFonts.lato(
                  fontSize: screenWidth / 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12, bottom: 32),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(2, 2),
                  )
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Check In",
                          style: GoogleFonts.lato(
                            fontSize: screenWidth / 20,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          checkIn,
                          style: GoogleFonts.lato(
                              fontSize: screenWidth / 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Check Out",
                          style: GoogleFonts.lato(
                            fontSize: screenWidth / 20,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          checkOut,
                          style: GoogleFonts.lato(
                              fontSize: screenWidth / 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                    text: DateTime.now().day.toString(),
                    style: GoogleFonts.lato(
                      color: Colors.red,
                      fontSize: screenWidth / 18,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: DateFormat(' MMMM yyyy').format(DateTime.now()),
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: screenWidth / 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ]),
              ),
            ),
            StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat('hh:mm:ss a').format(DateTime.now()),
                      style: GoogleFonts.lato(
                        fontSize: screenWidth / 20,
                        color: Colors.black54,
                      ),
                    ),
                  );
                }),
            checkOut == "--/--"
                ? Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Builder(
                      builder: (context) {
                        final GlobalKey<SlideActionState> key = GlobalKey();
                        return SlideAction(
                          text: checkIn == "--/--"
                              ? "Slide to Check In"
                              : "Slide to Check Out",
                          textStyle: GoogleFonts.lato(
                            color: Colors.black54,
                            fontSize: screenWidth / 20,
                          ),
                          outerColor: Colors.white,
                          innerColor: Colors.red,
                          key: key,
                          onSubmit: () async {
                            Timer(Duration(seconds: 1), () {
                              key.currentState!.reset();
                            });

                            QuerySnapshot snap = await FirebaseFirestore
                                .instance
                                .collection("Employee")
                                .where('id', isEqualTo: User1.employeeId)
                                .get();

                            DocumentSnapshot snap2 =
                                await FirebaseFirestore.instance
                                    .collection("Employee")
                                    .doc(snap.docs[0].id)
                                    .collection("Record")
                                    .doc(
                                      DateFormat('dd MMMM yyyy')
                                          .format(DateTime.now()),
                                    )
                                    .get();
                            try {
                              String checkIn = snap2['checkIn'];
                              setState(() {
                                checkOut =
                                    DateFormat('hh:mm').format(DateTime.now());
                              });

                              await FirebaseFirestore.instance
                                  .collection("Employee")
                                  .doc(snap.docs[0].id)
                                  .collection("Record")
                                  .doc(
                                    DateFormat('dd MMMM yyyy')
                                        .format(DateTime.now()),
                                  )
                                  .update({
                                'checkIn': checkIn,
                                'checkOut': checkOut,
                                // DateFormat('hh:mm').format(DateTime.now()),
                              });
                            } catch (e) {
                              setState(() {
                                checkIn =
                                    DateFormat('hh:mm').format(DateTime.now());
                              });
                              await FirebaseFirestore.instance
                                  .collection("Employee")
                                  .doc(snap.docs[0].id)
                                  .collection("Record")
                                  .doc(
                                    DateFormat('dd MMMM yyyy')
                                        .format(DateTime.now()),
                                  )
                                  .set({
                                'checkIn':
                                    DateFormat('hh:mm').format(DateTime.now()),
                              });
                            }
                          },
                        );
                      },
                    ))
                : Container(
                    margin: EdgeInsets.only(top: 32),
                    child: Text(
                      "you have completed this day!",
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: screenWidth / 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
