import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final ValueChanged<double> onRatingUpdate;
  final double itemSize;
  final int itemCount;
  final Color filledColor;
  final Color unfilledColor;

  const StarRating({
    Key? key,
    required this.rating,
    required this.onRatingUpdate,
    this.itemSize = 32.0,
    this.itemCount = 5,
    this.filledColor = Colors.amber,
    this.unfilledColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rating,
      minRating: 1,
      direction: Axis.horizontal,
      itemCount: itemCount,
      itemSize: itemSize,
      itemPadding: EdgeInsets.symmetric(horizontal: 4),
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: index < rating ? filledColor : unfilledColor,
      ),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
