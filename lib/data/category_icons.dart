import 'package:flutter/material.dart';
import 'package:shop/models/product_category.dart';

IconData iconForCategory(ProductCategory category) {
  switch (category) {
    case ProductCategory.running:
      return Icons.directions_run;
    case ProductCategory.walking:
      return Icons.directions_walk;
    case ProductCategory.basketball:
      return Icons.sports_basketball;
    case ProductCategory.training:
      return Icons.fitness_center;
    case ProductCategory.lifestyle:
      return Icons.style;
    case ProductCategory.skateboarding:
      return Icons.skateboarding;
    case ProductCategory.soccer:
      return Icons.sports_soccer;
    case ProductCategory.tennis:
      return Icons.sports_tennis;
    case ProductCategory.golf:
      return Icons.sports_golf;
    case ProductCategory.sandals:
      return Icons.beach_access;
    case ProductCategory.boots:
      return Icons.hiking;
    case ProductCategory.jordan:
      return Icons.sports_basketball_outlined;
    case ProductCategory.airMax:
      return Icons.air;
    case ProductCategory.retro:
      return Icons.history;
    case ProductCategory.trail:
      return Icons.terrain;
    case ProductCategory.gym:
      return Icons.self_improvement;
    case ProductCategory.casual:
      return Icons.checkroom;
    case ProductCategory.highTops:
      return Icons.height;
    case ProductCategory.lowTops:
      return Icons.arrow_downward;
    case ProductCategory.limitedEdition:
      return Icons.star_outline;
    case ProductCategory.cleats:
      return Icons.sports;
  }
}
