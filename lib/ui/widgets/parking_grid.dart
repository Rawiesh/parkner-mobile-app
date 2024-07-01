import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

enum ExcludedSide { left, right, top, bottom }

class ParkingGrid extends StatelessWidget {
  final String? selectedSpot;
  final dynamic lotData;
  final Function setSelectedSpot;

  const ParkingGrid({
    super.key,
    required this.selectedSpot,
    required this.lotData,
    required this.setSelectedSpot,
  });

  final double spotWidth = 150;
  final double spotHeight = 120;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            ParkingSpot(
              width: spotWidth,
              height: spotHeight,
              spotData: lotData?["spots"]?["C"],
              selectedSpot: selectedSpot,
              setSelectedSpot: setSelectedSpot,
            ),
            ParkingSpot(
              width: spotWidth,
              height: spotHeight,
              spotData: lotData?["spots"]?["B"],
              selectedSpot: selectedSpot,
              setSelectedSpot: setSelectedSpot,
            ),
            ParkingSpot(
              width: spotWidth,
              height: spotHeight,
              spotData: lotData?["spots"]?["A"],
              selectedSpot: selectedSpot,
              setSelectedSpot: setSelectedSpot,
            ),
          ],
        ),
        const Column(
          children: [
            Text("Exit"),
            SizedBox(
              width: 1,
              height: 400,
              child: DottedLine(
                direction: Axis.vertical,
              ),
            ),
            Text("Entrance"),
          ],
        ),
        Column(
          children: [
            ParkingSpot(
              width: spotWidth,
              height: spotHeight,
              spotData: lotData?["spots"]?["D"],
              selectedSpot: selectedSpot,
              setSelectedSpot: setSelectedSpot,
              flipped: true,
            ),
            ParkingSpot(
              width: spotWidth,
              height: spotHeight,
              spotData: lotData?["spots"]?["E"],
              selectedSpot: selectedSpot,
              setSelectedSpot: setSelectedSpot,
              flipped: true,
            ),
            ParkingSpot(
              width: spotWidth,
              height: spotHeight,
              spotData: lotData?["spots"]?["F"],
              selectedSpot: selectedSpot,
              setSelectedSpot: setSelectedSpot,
              flipped: true,
            ),
          ],
        ),
      ],
    );
  }
}

class ParkingSpot extends StatelessWidget {
  final dynamic spotData;
  final String? selectedSpot;
  final Function setSelectedSpot;
  final double width;
  final double height;
  final bool flipped;

  const ParkingSpot({
    super.key,
    required this.spotData,
    required this.selectedSpot,
    required this.width,
    required this.height,
    this.flipped = false,
    required this.setSelectedSpot,
  });

  void mightUpdateSelectedSpot() {
    if (spotData?["occupied"] == false && spotData?["reserved"] == false) {
      if (selectedSpot == spotData?["spot_id"]) {
        setSelectedSpot("");
      } else {
        setSelectedSpot(spotData?["spot_id"]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String statusLabel = "Available";
    List<Color> gradientColors = const [
      Color(0xff50C878),
      Color.fromRGBO(255, 255, 255, 0),
    ];

    if (spotData?["occupied"] == true) {
      statusLabel = "Occupied";
      gradientColors = const [
        Color(0xffEE4B2B),
        Color.fromRGBO(255, 255, 255, 0),
      ];
    } else if (spotData?["reserved"] == true) {
      statusLabel = "Reserved";
      gradientColors = const [
        Color(0xffEE4B2B),
        Color.fromRGBO(255, 255, 255, 0),
      ];
    }

    if (spotData?["spot_id"] == selectedSpot) {
      statusLabel = "Selected";
      gradientColors = const [
        Color(0xff0096FF),
        Color.fromRGBO(255, 255, 255, 0),
      ];
    }

    return GestureDetector(
      onTap: mightUpdateSelectedSpot,
      child: DottedBox(
        containerWidth: width,
        containerHeight: height,
        excludedSide: ExcludedSide.right,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
                  flipped ? gradientColors.reversed.toList() : gradientColors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: spotData?["occupied"] == true
              ? Image(
                  image: AssetImage(flipped
                      ? 'assets/images/occupied-img-flipped.png'
                      : 'assets/images/occupied-img.png'),
                  width: 80,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        border: Border.all(color: const Color(0xff9e9e9e)),
                      ),
                      child: Text(
                        spotData?["spot_id"] ?? "ID",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff06100E),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      statusLabel,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff06100E),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class DottedBox extends StatelessWidget {
  final double containerWidth;
  final double containerHeight;
  final ExcludedSide excludedSide;
  final Widget child;

  const DottedBox({
    super.key,
    required this.containerWidth,
    required this.containerHeight,
    required this.excludedSide,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      padding: const EdgeInsets.all(0),
      color: Colors.black,
      dashPattern: const [4, 4],
      customPath: (size) {
        final path = Path();
        if (excludedSide != ExcludedSide.top) {
          path.moveTo(0, 0);
          path.lineTo(size.width, 0);
        }
        if (excludedSide != ExcludedSide.left) {
          path.moveTo(0, 0);
          path.lineTo(0, size.height);
        }
        if (excludedSide != ExcludedSide.bottom) {
          path.moveTo(0, size.height);
          path.lineTo(size.width, size.height);
        }
        if (excludedSide != ExcludedSide.right) {
          path.moveTo(size.width, 0);
          path.lineTo(size.width, size.height);
        }
        return path;
      },
      child: child,
    );
  }
}
