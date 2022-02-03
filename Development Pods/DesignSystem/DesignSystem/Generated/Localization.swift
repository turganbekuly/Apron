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
        public static let disclaimer = L10n.tr("Localizable", "Authorization.Button.SignIn.Disclaimer")
        /// Войти
        public static let title = L10n.tr("Localizable", "Authorization.Button.SignIn.Title")
      }
      public enum SignUp {
        /// Регистрация
        public static let title = L10n.tr("Localizable", "Authorization.Button.SignUp.Title")
      }
    }
    public enum SignIn {
      /// С возвращением!
      public static let title = L10n.tr("Localizable", "Authorization.SignIn.Title")
    }
    public enum SignUp {
      /// Регистрация в Apron
      public static let title = L10n.tr("Localizable", "Authorization.SignUp.Title")
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
    guard let url = bundleToken.url(forResource: "DesignSystem", withExtension: "bundle"),
      let bundle = Bundle(url: url) else {
      fatalError("Can't find 'DesignSystem' resources bundle")
    }
    return bundle
  }()
}
// swiftlint:enable convenience_type
