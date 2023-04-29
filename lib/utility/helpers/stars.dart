import 'package:flutter/material.dart';

class StarsWidget extends StatelessWidget {
  final int? numberOfStars;

  const StarsWidget({Key? key, this.numberOfStars}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (numberOfStars == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          )
        ],
      );
    } else if (numberOfStars == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          )
        ],
      );
    } else if (numberOfStars == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star, color: Colors.amber),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          )
        ],
      );
    } else if (numberOfStars == 3) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star, color: Colors.amber),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(Icons.star, color: Colors.amber),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          ),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          )
        ],
      );
    } else if (numberOfStars == 4) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star, color: Colors.amber),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(Icons.star, color: Colors.amber),
          Icon(Icons.star, color: Colors.amber),
          Icon(
            Icons.star,
            color: Colors.grey.withOpacity(0.4),
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.star, color: Colors.amber),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(Icons.star, color: Colors.amber),
          Icon(Icons.star, color: Colors.amber),
          Icon(Icons.star, color: Colors.amber)
        ],
      );
    }
  }
}

stars({int? votes, double? rating}) {
  if (votes == 0) {
    return const StarsWidget(
      numberOfStars: 0,
    );
  } else {
    double finalRate = rating! / votes!;
    return StarsWidget(
      numberOfStars: finalRate.floor(),
    );
  }
}
