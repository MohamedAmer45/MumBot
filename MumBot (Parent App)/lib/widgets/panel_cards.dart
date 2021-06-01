import 'package:flutter/material.dart';

class PanelCards extends StatelessWidget {
  final String cardTitle;
  final AssetImage image;
  final String cardDescription;
  final String buttonTitle;
  final Function buttonPress;

  PanelCards(this.cardTitle, this.image, this.cardDescription, this.buttonTitle,
      this.buttonPress);
  @override
  Widget build(BuildContext context) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    final contHeight = MediaQuery.of(context).size.height * 0.29;
    return Container(
      height: contHeight,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5),
      child: Card(
        elevation: 20,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                height: MediaQuery.of(context).size.height * 0.025,
                child: Text(
                  cardTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18 * curScaleFactor,
                      color: Colors.blue[900]),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: CircleAvatar(
                        backgroundImage: image,
                        radius: 50,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.055,
                          child: Text(
                            cardDescription,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15 * curScaleFactor),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.height * 0.075,
                          padding: EdgeInsets.all(6),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue[900],
                                onPrimary: Colors.white),
                            onPressed: buttonPress,
                            child: Text(
                              buttonTitle,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18 * curScaleFactor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
