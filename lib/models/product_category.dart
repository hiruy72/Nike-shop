enum ProductCategory {
  running,
  walking,
  basketball,
  training,
  lifestyle,
  skateboarding,
  soccer,
  tennis,
  golf,
  sandals,
  boots,
  jordan,
  airMax,
  retro,
  trail,
  gym,
  casual,
  highTops,
  lowTops,
  limitedEdition,
  cleats,
}

extension ProductCategoryX on ProductCategory {
  String get label {
    switch (this) {
      case ProductCategory.running:
        return 'Running';
      case ProductCategory.walking:
        return 'Walking';
      case ProductCategory.basketball:
        return 'Basketball';
      case ProductCategory.training:
        return 'Training';
      case ProductCategory.lifestyle:
        return 'Lifestyle';
      case ProductCategory.skateboarding:
        return 'Skateboarding';
      case ProductCategory.soccer:
        return 'Soccer';
      case ProductCategory.tennis:
        return 'Tennis';
      case ProductCategory.golf:
        return 'Golf';
      case ProductCategory.sandals:
        return 'Sandals & Slides';
      case ProductCategory.boots:
        return 'Boots';
      case ProductCategory.jordan:
        return 'Jordan';
      case ProductCategory.airMax:
        return 'Air Max';
      case ProductCategory.retro:
        return 'Retro';
      case ProductCategory.trail:
        return 'Trail & Hiking';
      case ProductCategory.gym:
        return 'Gym & Workout';
      case ProductCategory.casual:
        return 'Casual';
      case ProductCategory.highTops:
        return 'High Tops';
      case ProductCategory.lowTops:
        return 'Low Tops';
      case ProductCategory.limitedEdition:
        return 'Limited Edition';
      case ProductCategory.cleats:
        return 'Cleats';
    }
  }

  static List<ProductCategory> get all => ProductCategory.values;
}
