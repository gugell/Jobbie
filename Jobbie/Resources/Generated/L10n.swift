// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum Action {
    /// Retry
    public static let retry = L10n.tr("Localizable", "action.retry")
  }

  public enum Alert {
    /// Cancel
    public static let cancel = L10n.tr("Localizable", "alert.cancel")
    /// OK
    public static let ok = L10n.tr("Localizable", "alert.ok")
  }

  public enum Error {
    public enum Fetch {
      /// Fetch error
      public static let title = L10n.tr("Localizable", "error.fetch.title")
    }
    public enum Signin {
      /// Failed to sign-in
      public static let title = L10n.tr("Localizable", "error.signin.title")
    }
  }

  public enum Home {
    /// No offers available at the moment.
    public static let emptyFeed = L10n.tr("Localizable", "home.emptyFeed")
    /// Home
    public static let title = L10n.tr("Localizable", "home.title")
  }

  public enum Offer {
    /// Description
    public static let description = L10n.tr("Localizable", "offer.description")
    /// %@ per hour
    public static func earnType(_ p1: Any) -> String {
      return L10n.tr("Localizable", "offer.earnType", String(describing: p1))
    }
    /// Location
    public static let location = L10n.tr("Localizable", "offer.location")
    public enum Location {
      /// View on maps
      public static let `open` = L10n.tr("Localizable", "offer.location.open")
    }
  }

  public enum Offers {
    /// Fetching Offers
    public static let fetching = L10n.tr("Localizable", "offers.fetching")
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
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
