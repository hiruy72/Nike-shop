# Creates 25 local commits with spread timestamps (10 on 2026-05-17, 15 on 2026-05-18)
$ErrorActionPreference = "Stop"
Set-Location "c:\Users\lenovo\Desktop\shop"

function Commit-At {
    param([string]$Date, [string]$Message, [string[]]$Paths)
    $env:GIT_AUTHOR_DATE = $Date
    $env:GIT_COMMITTER_DATE = $Date
    if ($Paths -and $Paths.Count -gt 0) {
        git add -- $Paths
    }
    git commit -m $Message
    Remove-Item Env:GIT_AUTHOR_DATE -ErrorAction SilentlyContinue
    Remove-Item Env:GIT_COMMITTER_DATE -ErrorAction SilentlyContinue
}

$platforms = @("android", "ios", "linux", "macos", "web", "windows")
$root = @(".gitignore", "README.md", "analysis_options.yaml", ".metadata", "pubspec.yaml", "pubspec.lock") + $platforms

# --- Yesterday (2026-05-17) ---
Commit-At "2026-05-17T09:14:00" "chore: initialize Flutter Nike shop project" $root

Commit-At "2026-05-17T10:32:00" "feat(theme): add brand colors and Inter typography theme" @(
    "lib/core/theme/app_colors.dart",
    "lib/core/theme/app_theme.dart"
)

Commit-At "2026-05-17T11:48:00" "feat(models): add product, review, and cart line models" @(
    "lib/models/product.dart",
    "lib/models/review.dart",
    "lib/models/cart_line.dart"
)

Commit-At "2026-05-17T13:05:00" "feat(data): add mock Nike product catalog and reviews" @(
    "lib/data/mock_data.dart"
)

Commit-At "2026-05-17T14:22:00" "feat(state): add cart and bookmark ChangeNotifier providers" @(
    "lib/providers/cart_provider.dart",
    "lib/providers/bookmark_provider.dart"
)

Commit-At "2026-05-17T15:40:00" "feat(app): configure routes and MultiProvider entrypoint" @(
    "lib/app.dart",
    "lib/main.dart"
)

Commit-At "2026-05-17T16:55:00" "feat(ui): add Nike swoosh logo and reusable product widgets" @(
    "lib/widgets/nike_logo.dart",
    "lib/widgets/product_image.dart",
    "lib/widgets/product_card.dart",
    "lib/widgets/primary_button.dart"
)

Commit-At "2026-05-17T18:10:00" "feat(home): build New Arrivals catalog with search and grid" @(
    "lib/screens/home_screen.dart"
)

Commit-At "2026-05-17T19:28:00" "feat(detail): add product detail carousel and size selector" @(
    "lib/screens/product_detail_screen.dart",
    "lib/widgets/size_selector.dart"
)

Commit-At "2026-05-17T21:45:00" "feat(reviews): add review cards inside expansion panels" @(
    "lib/widgets/review_card.dart"
)

# --- Today (2026-05-18) ---
Commit-At "2026-05-18T08:20:00" "feat(cart): implement My Bag screen with line items" @(
    "lib/screens/cart_screen.dart",
    "lib/widgets/cart_item_tile.dart",
    "lib/widgets/quantity_stepper.dart"
)

Commit-At "2026-05-18T09:35:00" "feat(cart): enable swipe-to-delete on bag items" @(
    "pubspec.yaml",
    "pubspec.lock"
)

Commit-At "2026-05-18T10:50:00" "feat(bookmarks): add bookmark list screen" @(
    "lib/screens/bookmark_list_screen.dart"
)

Commit-At "2026-05-18T11:15:00" "feat(catalog): add ProductCategory enum and filter model" @(
    "lib/models/product_category.dart",
    "lib/models/category_filter.dart"
)

Commit-At "2026-05-18T12:40:00" "feat(home): expand catalog and category chip sections" @(
    "lib/widgets/category_sections.dart",
    "lib/data/mock_data.dart",
    "lib/models/product.dart",
    "lib/screens/home_screen.dart"
)

Commit-At "2026-05-18T14:05:00" "refactor(home): use gender row and category dropdown filters" @(
    "lib/widgets/category_sections.dart",
    "lib/screens/home_screen.dart"
)

Commit-At "2026-05-18T15:20:00" "feat(checkout): add fake checkout and order summary" @(
    "lib/screens/checkout_screen.dart",
    "lib/providers/cart_provider.dart",
    "lib/app.dart"
)

Commit-At "2026-05-18T16:35:00" "feat(checkout): show order success and clear cart on place order" @(
    "lib/screens/checkout_screen.dart",
    "lib/core/theme/app_colors.dart"
)

Commit-At "2026-05-18T17:50:00" "fix(checkout): use green check icon on order confirmation" @(
    "lib/screens/checkout_screen.dart"
)

Commit-At "2026-05-18T18:25:00" "feat(detail): fill carousel with cover fit and three Air Max photos" @(
    "lib/screens/product_detail_screen.dart",
    "lib/widgets/product_image.dart"
)

Commit-At "2026-05-18T19:40:00" "feat(appbar): add black pill shopping bag button with badge" @(
    "lib/widgets/cart_bag_button.dart",
    "lib/widgets/shop_app_bar.dart"
)

Commit-At "2026-05-18T20:15:00" "feat(appbar): align cart header with My Bag title layout" @(
    "lib/screens/cart_screen.dart",
    "lib/screens/checkout_screen.dart",
    "lib/screens/bookmark_list_screen.dart",
    "lib/screens/home_screen.dart",
    "lib/screens/product_detail_screen.dart"
)

Commit-At "2026-05-18T21:00:00" "chore(android): allow network images in release builds" @(
    "android/app/src/main/AndroidManifest.xml"
)

Commit-At "2026-05-18T21:30:00" "chore: set Nike swoosh as app launcher icon" @(
    "assets/images/app_icon.png",
    "assets/images/.gitkeep",
    "pubspec.yaml"
)

Commit-At "2026-05-18T22:10:00" "test: add widget smoke test for home catalog" @(
    "test/widget_test.dart"
)

Write-Host "Done. $(git rev-list --count HEAD) commits on $(git branch --show-current)."
