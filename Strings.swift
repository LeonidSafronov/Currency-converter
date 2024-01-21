// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// OK
  internal static let ok = L10n.tr("Localizable", "OK", fallback: "OK")
  internal enum Endpoint {
    /// convert
    internal static let convert = L10n.tr("Localizable", "Endpoint.convert", fallback: "convert")
    /// Localizable.strings
    ///   Currency converter
    /// 
    ///   Created by Leonid Safronov on 21.01.2024.
    internal static let latest = L10n.tr("Localizable", "Endpoint.latest", fallback: "latest")
  }
  internal enum Error {
    /// DataSource Error
    internal static let dataSource = L10n.tr("Localizable", "Error.DataSource", fallback: "DataSource Error")
    /// Server Error
    internal static let server = L10n.tr("Localizable", "Error.Server", fallback: "Server Error")
  }
  internal enum ProgressView {
    /// Loading...
    internal static let title = L10n.tr("Localizable", "ProgressView.title", fallback: "Loading...")
  }
  internal enum View {
    /// Result
    internal static let result = L10n.tr("Localizable", "View.result", fallback: "Result")
    /// Currency converter
    internal static let title = L10n.tr("Localizable", "View.title", fallback: "Currency converter")
    /// No internet. Result based on data from %@
    internal static func warning(_ p1: Any) -> String {
      return L10n.tr("Localizable", "View.warning", String(describing: p1), fallback: "No internet. Result based on data from %@")
    }
    internal enum Button {
      /// Done
      internal static let title = L10n.tr("Localizable", "View.button.title", fallback: "Done")
    }
    internal enum FirstPicker {
      /// First currency
      internal static let name = L10n.tr("Localizable", "View.firstPicker.name", fallback: "First currency")
      /// Convert from
      internal static let title = L10n.tr("Localizable", "View.firstPicker.title", fallback: "Convert from")
    }
    internal enum SecondPicker {
      /// Second currency
      internal static let name = L10n.tr("Localizable", "View.secondPicker.name", fallback: "Second currency")
      /// Convert to
      internal static let title = L10n.tr("Localizable", "View.secondPicker.title", fallback: "Convert to")
    }
    internal enum Textfield {
      /// Amount
      internal static let name = L10n.tr("Localizable", "View.textfield.name", fallback: "Amount")
      /// Enter currency amount
      internal static let placeholder = L10n.tr("Localizable", "View.textfield.placeholder", fallback: "Enter currency amount")
    }
  }
  internal enum InvalidData {
    /// The data received from the server was invalid. Please contact support.
    internal static let message = L10n.tr("Localizable", "invalidData.message", fallback: "The data received from the server was invalid. Please contact support.")
  }
  internal enum InvalidDataLoading {
    /// Unable to load data.
    internal static let message = L10n.tr("Localizable", "invalidDataLoading.message", fallback: "Unable to load data.")
  }
  internal enum InvalidDataSaving {
    /// Unable to save data.
    internal static let message = L10n.tr("Localizable", "invalidDataSaving.message", fallback: "Unable to save data.")
  }
  internal enum InvalidResponse {
    /// Invalid response from the server. Please try again later or contact support.
    internal static let message = L10n.tr("Localizable", "invalidResponse.message", fallback: "Invalid response from the server. Please try again later or contact support.")
  }
  internal enum InvalidURL {
    /// There was an issue connecting to server. If this persists, please contact support.
    internal static let message = L10n.tr("Localizable", "invalidURL.message", fallback: "There was an issue connecting to server. If this persists, please contact support.")
  }
  internal enum SmthGoesWrong {
    /// Something goes wrong.
    internal static let message = L10n.tr("Localizable", "smthGoesWrong.message", fallback: "Something goes wrong.")
  }
  internal enum UnableToComplete {
    /// Unable to complete your request at this time. Please check your internet connection.
    internal static let message = L10n.tr("Localizable", "unableToComplete.message", fallback: "Unable to complete your request at this time. Please check your internet connection.")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
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
