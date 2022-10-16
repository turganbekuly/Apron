// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum Authorization {
    public enum Button {
      public enum SignIn {
        /// У вас уже есть аккаунт?  
        public static let disclaimer = L10n.tr("APRLocalizable", "Authorization.Button.SignIn.Disclaimer")
        /// Войти
        public static let title = L10n.tr("APRLocalizable", "Authorization.Button.SignIn.Title")
      }
      public enum SignUp {
        /// Регистрация
        public static let title = L10n.tr("APRLocalizable", "Authorization.Button.SignUp.Title")
      }
    }
    public enum SignIn {
      /// С возвращением!
      public static let title = L10n.tr("APRLocalizable", "Authorization.SignIn.Title")
    }
    public enum SignUp {
      /// Регистрация в Apron
      public static let title = L10n.tr("APRLocalizable", "Authorization.SignUp.Title")
    }
    public enum Skip {
      /// Вы пропустите персонализированный контент и сохранение наших вкусных рецептов.
      public static let message = L10n.tr("APRLocalizable", "Authorization.Skip.Message")
      /// Вы действительно хотите пропустить?
      public static let title = L10n.tr("APRLocalizable", "Authorization.Skip.Title")
    }
  }

  public enum Common {
    /// Произошла ошибка! Пожалуйста, попробуйте позднее
    public static let errorMessage = L10n.tr("APRLocalizable", "Common.ErrorMessage")
    /// Нет
    public static let no = L10n.tr("APRLocalizable", "Common.No")
    /// Да
    public static let yes = L10n.tr("APRLocalizable", "Common.Yes")
    public enum Join {
      /// Вступить
      public static let title = L10n.tr("APRLocalizable", "Common.Join.Title")
    }
    public enum Joined {
      /// Уже вступили
      public static let title = L10n.tr("APRLocalizable", "Common.Joined.Title")
    }
    public enum Save {
      /// Сохранить
      public static let title = L10n.tr("APRLocalizable", "Common.Save.Title")
    }
    public enum Share {
      /// Поделиться
      public static let title = L10n.tr("APRLocalizable", "Common.Share.Title")
    }
    public enum Skip {
      /// Пропустить
      public static let title = L10n.tr("APRLocalizable", "Common.Skip.Title")
    }
  }

  public enum Communities {
    public enum MyCommunity {
      /// Мои сообщества
      public static let title = L10n.tr("APRLocalizable", "Communities.MyCommunity.Title")
    }
  }

  public enum TabBar {
    public enum Home {
      /// Главная
      public static let title = L10n.tr("APRLocalizable", "TabBar.Home.Title")
    }
    public enum Profile {
      /// Профиль
      public static let title = L10n.tr("APRLocalizable", "TabBar.Profile.Title")
    }
    public enum Saved {
      /// Избранное
      public static let title = L10n.tr("APRLocalizable", "TabBar.Saved.Title")
    }
    public enum Search {
      /// Поиск
      public static let title = L10n.tr("APRLocalizable", "TabBar.Search.Title")
    }
    public enum ShoppingList {
      /// Список
      public static let title = L10n.tr("APRLocalizable", "TabBar.ShoppingList.Title")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
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
