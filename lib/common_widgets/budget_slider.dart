import 'package:flutter/material.dart';

class BudgetSlider extends StatefulWidget {
  final double maxBudget;
  final ValueChanged<int>? onChanged;
  final double initialValue;

  const BudgetSlider({
    super.key,
    required this.maxBudget,
    this.onChanged,
    this.initialValue = 50000,
  });

  @override
  BudgetSliderState createState() => BudgetSliderState();
}

class BudgetSliderState extends State<BudgetSlider> {
  late double _currentBudget;

  @override
  void initState() {
    super.initState();
    _currentBudget = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: const Color.fromRGBO(57, 185, 111, 1),
            thumbColor: const Color.fromRGBO(57, 185, 111, 1),
            trackHeight: 1.0, // Set the thickness of the slider track
            thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 8.0), // Size of the thumb
          ),
          child: Slider(
            value: _currentBudget,
            min: 0,
            max: widget.maxBudget,
            divisions: 1000,
            onChanged: (double value) {
              setState(() {
                _currentBudget = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(value.toInt());
              }
            },
          ),
        ),
      ],
    );
  }
}
