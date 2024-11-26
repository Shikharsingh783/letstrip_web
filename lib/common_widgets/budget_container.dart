import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:letstrip/common_widgets/budget_slider.dart';
import 'package:letstrip/repositories/preference_controller.dart';
import 'package:letstrip/theme/text_style.dart';
import 'package:letstrip/utils/padding_helper.dart';
import 'package:letstrip/utils/size_config.dart';

class BudgetContainer extends StatefulWidget {
  final Function(String) onValueUpdate;
  final bool showBorder;
  final String initialValue;

  const BudgetContainer({
    Key? key,
    required this.onValueUpdate,
    this.showBorder = true,
    this.initialValue = "50000",
  }) : super(key: key);

  @override
  _BudgetContainerState createState() => _BudgetContainerState();
}

class _BudgetContainerState extends State<BudgetContainer> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late String budget;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    final BudgetController controller = Get.put(BudgetController());

    // Set initial budget value in controller and text controller
    if (widget.initialValue.isNotEmpty) {
      controller.updateBudget(widget.initialValue);
      _controller.text = widget.initialValue;
    }

    budget = widget.initialValue.isNotEmpty ? widget.initialValue : "50000";
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BudgetController controller =
        Get.find(); // Get the existing controller

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil().radius(6.0)),
        border: widget.showBorder
            ? Border.all(
                color: const Color.fromRGBO(228, 228, 228, 1),
                width: 0.7,
              )
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: padOnly(right: 1, left: 1, top: 8),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Image.asset(
                  'assets/Vector (6).png',
                  height: 13,
                ),
                boxW8(),
                Text(
                  'Budget per person',
                  style: GoogleFonts.raleway(
                      color: const Color.fromRGBO(102, 102, 102, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                const Spacer(),
              ],
            ),
          ),
          Padding(
            padding: padSym(horizontal: 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Obx(() {
                    return BudgetSlider(
                      key: ValueKey(controller.budget.value),
                      maxBudget: 1000000,
                      initialValue:
                          double.tryParse(controller.budget.value) ?? 50000.0,
                      onChanged: (value) {
                        controller.updateBudget(value.toStringAsFixed(0));
                        widget.onValueUpdate(controller.budget.value);
                      },
                    );
                  }),
                ),
                boxW8(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isEditing = true;
                    });
                    _focusNode.requestFocus(); // Focus the TextField
                  },
                  child: Obx(() {
                    return _isEditing
                        ? SizedBox(
                            width: 100,
                            child: TextField(
                              focusNode: _focusNode,
                              controller: _controller,
                              style: GoogleFonts.questrial(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                                color: const Color.fromRGBO(57, 185, 111, 1),
                              ),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(57, 185, 111, 1))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(57, 185, 111, 1))),
                                isDense: true,
                                // contentPadding:
                                //     padSym(horizontal: 15, vertical: 5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil().radius(4)),
                                ),
                                filled: true,
                                fillColor: Color.fromRGBO(223, 246, 234, 1),
                              ),
                              onSubmitted: (value) {
                                controller.updateBudget(value);
                                setState(() {
                                  _isEditing = false;
                                });
                                widget.onValueUpdate(controller.budget.value);
                              },
                            ),
                          )
                        : Container(
                            padding: padSym(horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(235, 248, 241, 1),
                              borderRadius:
                                  BorderRadius.circular(ScreenUtil().radius(4)),
                            ),
                            child: Text(
                              controller.budget.value,
                              style: GoogleFonts.questrial(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                                color: const Color.fromRGBO(57, 185, 111, 1),
                              ),
                            ),
                          );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
