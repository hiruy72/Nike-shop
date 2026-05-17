import 'package:flutter/material.dart';
import 'package:shop/core/theme/app_colors.dart';
import 'package:shop/models/review.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.cardBackground,
            child: Text(
              review.author.isNotEmpty ? review.author[0] : '?',
              style: theme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.author,
                  style: theme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Row(
                  children: List.generate(5, (i) {
                    return Icon(
                      i < review.rating ? Icons.star : Icons.star_border,
                      size: 16,
                      color: i < review.rating
                          ? AppColors.accent
                          : AppColors.secondaryText,
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Text(
                  review.text,
                  style: theme.bodyMedium?.copyWith(
                    color: AppColors.secondaryText,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  review.date,
                  style: theme.bodySmall?.copyWith(color: AppColors.secondaryText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
