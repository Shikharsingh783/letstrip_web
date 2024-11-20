import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letstrip/common_widgets/budget_slider.dart';

class BudgetContainer extends StatefulWidget {
  final Function(String) onValueUpdate;
  final bool showBorder;
  final String initialValue;

  const BudgetContainer({
    super.key,
    required this.onValueUpdate,
    this.showBorder = true,
    this.initialValue = "50000",
  });

  @override
  BudgetContainerState createState() => BudgetContainerState();
}

class BudgetContainerState extends State<BudgetContainer> {
  late String budget;

  @override
  void initState() {
    super.initState();
    // Directly set the budget to the initialValue
    budget = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(228, 228, 228, 1)),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 1, left: 1, top: 8),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  "Budget",
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(102, 102, 102, 1),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: BudgetSlider(
                    maxBudget: 1000000,
                    initialValue: double.tryParse(budget) ?? 50000.0,
                    onChanged: (value) {
                      setState(() {
                        budget = value.toString();
                      });
                      widget.onValueUpdate(value.toString());
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(235, 248, 241, 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    budget,
                    style: GoogleFonts.questrial(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: const Color.fromRGBO(57, 185, 111, 1)),
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
