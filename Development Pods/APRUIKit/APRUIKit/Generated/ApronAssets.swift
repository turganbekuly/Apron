// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum ApronAssets {
  public static let blue = ColorAsset(name: "blue")
  public static let colorsYello = ColorAsset(name: "colorsYello")
  public static let darkYello = ColorAsset(name: "darkYello")
  public static let gray = ColorAsset(name: "gray")
  public static let green = ColorAsset(name: "green")
  public static let lightBlue = ColorAsset(name: "lightBlue")
  public static let lightGray = ColorAsset(name: "lightGray")
  public static let lightGray2 = ColorAsset(name: "lightGray2")
  public static let red = ColorAsset(name: "red")
  public static let secondary = ColorAsset(name: "secondary")
  public static let buttonFilterIcon = ImageAsset(name: "button_filter_icon")
  public static let calAlmstFullIcon = ImageAsset(name: "cal_almstFull_icon")
  public static let calFullIcon = ImageAsset(name: "cal_full_icon")
  public static let calHalfIcon = ImageAsset(name: "cal_half_icon")
  public static let calLowIcon = ImageAsset(name: "cal_low_icon")
  public static let calQuaterIcon = ImageAsset(name: "cal_quater_icon")
  public static let arrowForward = ImageAsset(name: "arrowForward")
  public static let attention = ImageAsset(name: "attention")
  public static let checkOvalOutline = ImageAsset(name: "checkOvalOutline")
  public static let editIcon = ImageAsset(name: "edit_icon")
  public static let iconRightArrow = ImageAsset(name: "icon_right_arrow")
  public static let loginBackgroundImage = ImageAsset(name: "login_background_image")
  public static let logoBlack = ImageAsset(name: "logo_black")
  public static let logoBlackOld = ImageAsset(name: "logo_black_old")
  public static let logoWhite = ImageAsset(name: "logo_white")
  public static let logoWhiteOld = ImageAsset(name: "logo_white_old")
  public static let trashIcon = ImageAsset(name: "trash_icon")
  public static let cmntImageview = ImageAsset(name: "cmnt_imageview")
  public static let cmntMemberIcon = ImageAsset(name: "cmnt_member_icon")
  public static let cmntRecipeIcon = ImageAsset(name: "cmnt_recipe_icon")
  public static let communityMockImage = ImageAsset(name: "community_mock_image")
  public static let emptyRecipesIcon = ImageAsset(name: "empty_recipes_icon")
  public static let recipeCookingTimeIcon = ImageAsset(name: "recipe_cooking_time_icon")
  public static let recipeFavoriteIcon = ImageAsset(name: "recipe_favorite_icon")
  public static let searchClearButton = ImageAsset(name: "search_clear_button")
  public static let tableRoundedCorners = ImageAsset(name: "table_rounded_corners")
  public static let communityAboutIcon = ImageAsset(name: "community_about_icon")
  public static let communityPrivateIcon = ImageAsset(name: "community_private_icon")
  public static let communityPublicIcon = ImageAsset(name: "community_public_icon")
  public static let recipeAddIcon = ImageAsset(name: "recipe_add_icon")
  public static let recipeNewIcon = ImageAsset(name: "recipe_new_icon")
  public static let recipeSaveLinkIcon = ImageAsset(name: "recipe_saveLink_icon")
  public static let forceUpdateImage = ImageAsset(name: "force_update_image")
  public static let iconPlaceholderCard = ImageAsset(name: "icon_placeholder_card")
  public static let iconPlaceholderItem = ImageAsset(name: "icon_placeholder_item")
  public static let navAvatarIcon = ImageAsset(name: "nav_avatar_icon")
  public static let navBackButton = ImageAsset(name: "nav_back_button")
  public static let navCartIcon = ImageAsset(name: "nav_cart_icon")
  public static let navCartIconFilled = ImageAsset(name: "nav_cart_icon_filled")
  public static let navMoreButton = ImageAsset(name: "nav_more_button")
  public static let navNotificationIcon = ImageAsset(name: "nav_notification_icon")
  public static let navSearchIcon = ImageAsset(name: "nav_search_icon")
  public static let creationPlusButton = ImageAsset(name: "creation_plus_button")
  public static let minusButtonIcon = ImageAsset(name: "minus_button_icon")
  public static let plusButtonIcon = ImageAsset(name: "plus_button_icon")
  public static let recipeDislikeSelected = ImageAsset(name: "recipe_dislike_selected")
  public static let recipeDislikeUnselected = ImageAsset(name: "recipe_dislike_unselected")
  public static let recipeEditIcon = ImageAsset(name: "recipe_edit_icon")
  public static let recipeLikeSelected = ImageAsset(name: "recipe_like_selected")
  public static let recipeLikeUnselected = ImageAsset(name: "recipe_like_unselected")
  public static let recipeSampleImage = ImageAsset(name: "recipe_sample_image")
  public static let recipeShareIcon = ImageAsset(name: "recipe_share_icon")
  public static let testPlaceholderIcon = ImageAsset(name: "test_placeholder_icon")
  public static let addImagePlaceholder = ImageAsset(name: "add_image_placeholder")
  public static let addedImagePlaceholder = ImageAsset(name: "added_image_placeholder")
  public static let cameraIcon = ImageAsset(name: "camera_icon")
  public static let searchRoundedView = ImageAsset(name: "search_rounded_view")
  public static let emptyCart = ImageAsset(name: "empty_cart")
  public static let tabFaveIcon = ImageAsset(name: "tab_fave_icon")
  public static let tabFaveSelectedIcon = ImageAsset(name: "tab_fave_selected_icon")
  public static let tabHomeIcon = ImageAsset(name: "tab_home_icon")
  public static let tabHomeSelectedIcon = ImageAsset(name: "tab_home_selected_icon")
  public static let tabListIcon = ImageAsset(name: "tab_list_icon")
  public static let tabListSelectedIcon = ImageAsset(name: "tab_list_selected_icon")
  public static let tabPlannerIcon = ImageAsset(name: "tab_planner_icon")
  public static let tabPlannerSelectedIcon = ImageAsset(name: "tab_planner_selected_icon")
  public static let tabbarAddIcon = ImageAsset(name: "tabbar_add_icon")
  public static let tabbarAddIcon20px = ImageAsset(name: "tabbar_add_icon_20px")
  public static let tabbarAddIconThin = ImageAsset(name: "tabbar_add_icon_thin")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

public extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    let bundleToken = Bundle(for: BundleToken.self)
    guard let url = bundleToken.url(forResource: "APRUIKit", withExtension: "bundle"),
      let bundle = Bundle(url: url) else {
      fatalError("Can't find 'APRUIKit' resources bundle")
    }
    return bundle
  }()
}
// swiftlint:enable convenience_type
