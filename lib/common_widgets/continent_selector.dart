import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letstrip/generated/assets.dart';
import 'package:letstrip/theme/text_style.dart';
import 'package:letstrip/utils/padding_helper.dart';
import 'package:letstrip/utils/size_config.dart';
import 'package:letstrip/utils/utilities.dart';

class ContinentSelector extends StatefulWidget {
  final Function(List<String>) onSelectedContinentsChanged;
  final double? width;
  final double? height;
  final List<String>? selectedContinents;
  final bool showTitle;

  ContinentSelector(
    this.onSelectedContinentsChanged, {
    super.key,
    this.width,
    this.height,
    this.selectedContinents,
    this.showTitle = true,
  }); // Callback function

  @override
  State<ContinentSelector> createState() => _ContinentSelectorState();
}

class _ContinentSelectorState extends State<ContinentSelector> {
  List<String> updatedContinents = [];

  bool isNAmericaSelected = false;
  bool isSAmericaSelected = false;
  bool isEuropeSelected = false;
  bool isAfricaSelected = false;
  bool isAsiaSelected = false;
  bool isAustraliaSelected = false;
  late double width;
  late double height;

  @override
  void initState() {
    width = widget.width ?? screenWidth();
    print(width);
    height = widget.height ?? 217.h;
    updatedContinents = widget.selectedContinents ?? [];
    isNAmericaSelected = updatedContinents.contains('North America');
    isSAmericaSelected = updatedContinents.contains('South America');
    isEuropeSelected = updatedContinents.contains('Europe');
    isAfricaSelected = updatedContinents.contains('Africa');
    isAsiaSelected = updatedContinents.contains('Asia');
    isAustraliaSelected = updatedContinents.contains('Australia');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.showTitle
            ? Text("Do you have any continent preferences?",
                style: GoogleFonts.raleway(
                    fontSize: 13,
                    color: const Color.fromRGBO(102, 102, 102, 1),
                    fontWeight: FontWeight.w700))
            : SizedBox.shrink(),
        boxH8(),
        Container(
          width: width,
          height: height,
          padding: padAll(value: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(4)),
              border: Border.all(color: const Color(0xFFE4E4E4))),
          child: Stack(
            children: [
              Transform.translate(
                  offset: const Offset(-12, 0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isNAmericaSelected = !isNAmericaSelected;
                        if (isNAmericaSelected) {
                          updatedContinents.add("North America");
                        } else {
                          updatedContinents.remove("North America");
                        }
                        widget.onSelectedContinentsChanged(updatedContinents);
                      });
                    },
                    child: SizedBox(
                      width: calculateWidth(percentage: 30),
                      child: Image.asset(isNAmericaSelected
                          ? Assets.assetsNorthAmericaColored
                          : Assets.assetsNorthAmerica),
                    ),
                  )),
              Transform.translate(
                  offset: Offset(
                    calculateWidth(percentage: 11),
                    calculateHeight(percentage: 50),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isSAmericaSelected = !isSAmericaSelected;
                        if (isSAmericaSelected) {
                          updatedContinents.add("South America");
                        } else {
                          updatedContinents.remove("South America");
                        }
                        widget.onSelectedContinentsChanged(updatedContinents);
                      });
                    },
                    child: SizedBox(
                      width: calculateWidth(percentage: 15),
                      height: calculateHeight(percentage: 40),
                      child: Image.asset(isSAmericaSelected
                          ? Assets.assetsSouthAmericaColored
                          : Assets.assetsSouthAmerica),
                    ),
                  )),
              Transform.translate(
                  offset: Offset(
                    calculateWidth(percentage: 24),
                    calculateHeight(percentage: 10),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isEuropeSelected = !isEuropeSelected;
                        if (isEuropeSelected) {
                          updatedContinents.add("Europe");
                        } else {
                          updatedContinents.remove("Europe");
                        }
                        widget.onSelectedContinentsChanged(updatedContinents);
                      });
                    },
                    child: SizedBox(
                      width: calculateWidth(percentage: 20),
                      child: Image.asset(isEuropeSelected
                          ? Assets.assetsEuropeColored
                          : Assets.assetsEurope),
                    ),
                  )),
              Transform.translate(
                  offset: Offset(
                    calculateWidth(percentage: 34),
                    calculateHeight(percentage: 50),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isAfricaSelected = !isAfricaSelected;
                        if (isAfricaSelected) {
                          updatedContinents.add("Africa");
                        } else {
                          updatedContinents.remove("Africa");
                        }
                        widget.onSelectedContinentsChanged(updatedContinents);
                      });
                    },
                    child: SizedBox(
                      width: calculateWidth(percentage: 20),
                      child: Image.asset(isAfricaSelected
                          ? Assets.assetsAfricaColored
                          : Assets.assetsAfrica),
                    ),
                  )),
              Transform.translate(
                offset: Offset(
                  calculateWidth(percentage: 40),
                  -calculateHeight(percentage: 4),
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isAsiaSelected = !isAsiaSelected;
                      if (isAsiaSelected) {
                        updatedContinents.add("Asia");
                      } else {
                        updatedContinents.remove("Asia");
                      }
                      widget.onSelectedContinentsChanged(updatedContinents);
                    });
                  },
                  child: SizedBox(
                    width: calculateWidth(percentage: 47),
                    height: calculateHeight(percentage: 69),
                    child: Image.asset(
                        isAsiaSelected
                            ? Assets.assetsAsiaColored
                            : Assets.assetsAsia,
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(
                  calculateWidth(percentage: 61),
                  calculateHeight(percentage: 46),
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isAustraliaSelected = !isAustraliaSelected;
                      if (isAustraliaSelected) {
                        updatedContinents.add("Australia");
                      } else {
                        updatedContinents.remove("Australia");
                      }
                      widget.onSelectedContinentsChanged(updatedContinents);
                    });
                  },
                  child: SizedBox(
                    width: calculateWidth(percentage: 20),
                    child: Image.asset(
                        isAustraliaSelected
                            ? Assets.assetsAustraliaColored
                            : Assets.assetsAustralia,
                        fit: BoxFit.fill),
                  ),
                ),
              ),
            ],
          ),
        ),
        boxH8(),
        Wrap(
          runSpacing: 12,
          children: [
            if (isNAmericaSelected) _buildSelectedContinent('North America'),
            if (isSAmericaSelected) _buildSelectedContinent('South America'),
            if (isEuropeSelected) _buildSelectedContinent('Europe'),
            if (isAfricaSelected) _buildSelectedContinent('Africa'),
            if (isAsiaSelected) _buildSelectedContinent('Asia'),
            if (isAustraliaSelected) _buildSelectedContinent('Australia'),
          ].separateHorizontally(10),
        )
      ],
    );
  }

  Widget _buildSelectedContinent(String continentName) {
    return Container(
        padding: padSym(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenUtil().radius(4)),
            color: Theme.of(context).colorScheme.primaryContainer),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
                radius: ScreenUtil().radius(8),
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                  Icons.done_rounded,
                  size: 10,
                  color: Theme.of(context).colorScheme.background,
                )),
            boxW8(),
            Text(continentName,
                style: AppTextTheme.labelStyle
                    .copyWith(color: Theme.of(context).colorScheme.primary))
          ],
        ));
  }

  double calculateWidth({double percentage = 100}) {
    return width * (percentage / 100);
  }

  double calculateHeight({double percentage = 100}) {
    return height * (percentage / 100);
  }
}
