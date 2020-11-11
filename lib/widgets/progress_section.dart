import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:task_management/utils/constants.dart';

class ProgressSection extends StatelessWidget {
  const ProgressSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: darkBlue2,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularPercentIndicator(
                    radius: 25.0,
                    lineWidth: 3.0,
                    backgroundWidth: 4.0,
                    animation: true,
                    percent: 0.8,
                    backgroundColor: Colors.grey.shade600,
                    progressColor: Color.fromRGBO(99, 244, 247, 1),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  CircularPercentIndicator(
                    radius: 45.0,
                    lineWidth: 3.0,
                    backgroundWidth: 4.0,
                    animation: true,
                    percent: 0.8,
                    backgroundColor: Colors.grey.shade600,
                    progressColor: Color.fromRGBO(99, 244, 247, 1),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  CircularPercentIndicator(
                    radius: 65.0,
                    lineWidth: 3.0,
                    backgroundWidth: 4.0,
                    animation: true,
                    percent: 0.8,
                    backgroundColor: Colors.grey.shade600,
                    progressColor: Color.fromRGBO(99, 244, 247, 1),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  CircularPercentIndicator(
                    radius: 85.0,
                    lineWidth: 3.0,
                    backgroundWidth: 4.0,
                    animation: true,
                    percent: 0.8,
                    backgroundColor: Colors.grey.shade600,
                    progressColor: Color.fromRGBO(99, 244, 247, 1),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  CircularPercentIndicator(
                    radius: 105.0,
                    lineWidth: 5.0,
                    backgroundWidth: 4.0,
                    animation: true,
                    percent: 0.4,
                    backgroundColor: Colors.grey.shade600,
                    progressColor: Color.fromRGBO(254, 115, 72, 1),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  CircularPercentIndicator(
                    radius: 125.0,
                    lineWidth: 5.0,
                    backgroundWidth: 4.0,
                    animation: true,
                    percent: 0.7,
                    backgroundColor: Colors.grey.shade600,
                    progressColor: Color.fromRGBO(48, 104, 224, 1),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  CircularPercentIndicator(
                    radius: 145.0,
                    lineWidth: 5.0,
                    backgroundWidth: 4.0,
                    animation: true,
                    percent: 0.7,
                    backgroundColor: Colors.grey.shade600,
                    progressColor: Color.fromRGBO(48, 104, 224, 1),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              height: 200,
              margin: EdgeInsets.only(
                right: 25,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(48, 104, 224, 1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Inbox",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "70%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(254, 115, 72, 1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Meetings",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "40%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(99, 244, 247, 1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Trip",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "80%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
