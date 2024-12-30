import 'package:flutter/material.dart';

class DeliveryDetailsCard extends StatelessWidget {
  const DeliveryDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          indent: 16,
          endIndent: 16,
          thickness: 1,
        ),
        Container(
          // color: Colors.red,
          margin: EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Delivery details',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 18,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                // margin: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Hostel",
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 16,
                              fontFamily: 'SF Pro',
                              fontWeight: FontWeight.w400,
                            )),
                        Text("BH-3",
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 16,
                              fontFamily: 'SF Pro',
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Contact",
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 16,
                              fontFamily: 'SF Pro',
                              fontWeight: FontWeight.w400,
                            )),
                        Text("9510523100",
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 16,
                              fontFamily: 'SF Pro',
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
