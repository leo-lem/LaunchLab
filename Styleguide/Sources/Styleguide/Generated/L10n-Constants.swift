// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// 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
  public static let apiKey = L10n.tr("Localizable", "api_key", fallback: "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")
  /// Ideate with Your Co-Founder 🤖
  public static let cofounderLabel = L10n.tr("Localizable", "cofounder_label", fallback: "Ideate with Your Co-Founder 🤖")
  /// Complete
  public static let commonComplete = L10n.tr("Localizable", "common_complete", fallback: "Complete")
  /// Continue
  public static let commonContinue = L10n.tr("Localizable", "common_continue", fallback: "Continue")
  /// Dismiss
  public static let commonDismiss = L10n.tr("Localizable", "common_dismiss", fallback: "Dismiss")
  /// Enter text here…
  public static let commonPlaceholder = L10n.tr("Localizable", "common_placeholder", fallback: "Enter text here…")
  /// Begin
  public static let commonStart = L10n.tr("Localizable", "common_start", fallback: "Begin")
  /// Please configure the Mail app on your phone.
  public static let configureMailApp = L10n.tr("Localizable", "configure_mail_app", fallback: "Please configure the Mail app on your phone.")
  /// Something went wrong…
  public static let errorOccured = L10n.tr("Localizable", "error_occured", fallback: "Something went wrong…")
  /// Export PDF
  public static let exportPdf = L10n.tr("Localizable", "export_pdf", fallback: "Export PDF")
  /// Feedback
  public static let feedback = L10n.tr("Localizable", "Feedback", fallback: "Feedback")
  /// General
  public static let general = L10n.tr("Localizable", "general", fallback: "General")
  /// Generate
  public static let generate = L10n.tr("Localizable", "generate", fallback: "Generate")
  /// Locked 🔒
  public static let locked = L10n.tr("Localizable", "locked", fallback: "Locked 🔒")
  /// It's cool, you're testing the app thoroughly. Unfortunately this feature doesn't work on a simulator, since it doesn't have access to the mail system.
  public static let mailAlertSubtitle = L10n.tr("Localizable", "mail_alert_subtitle", fallback: "It's cool, you're testing the app thoroughly. Unfortunately this feature doesn't work on a simulator, since it doesn't have access to the mail system.")
  /// Mark as completed
  public static let markCompleted = L10n.tr("Localizable", "mark_completed", fallback: "Mark as completed")
  /// Modules
  public static let modules = L10n.tr("Localizable", "modules", fallback: "Modules")
  /// Chart
  public static let modulesChart = L10n.tr("Localizable", "modules_chart", fallback: "Chart")
  /// %@/%@ completed
  public static func modulesCompleted(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("Localizable", "modules_completed %@ %@", String(describing: p1), String(describing: p2), fallback: "%@/%@ completed")
  }
  /// Progress
  public static let modulesStatus = L10n.tr("Localizable", "modules_status", fallback: "Progress")
  /// Privacy policy
  public static let privacyPolicy = L10n.tr("Localizable", "privacy_policy", fallback: "Privacy policy")
  /// Review
  public static let review = L10n.tr("Localizable", "review", fallback: "Review")
  /// Start Consultation
  public static let startConsulting = L10n.tr("Localizable", "start_consulting", fallback: "Start Consultation")
  /// Support
  public static let support = L10n.tr("Localizable", "support", fallback: "Support")
  /// Support & Feedback
  public static let supportAndFeedback = L10n.tr("Localizable", "support_and_feedback", fallback: "Support & Feedback")
  /// Your Progress
  public static let yourState = L10n.tr("Localizable", "your_state", fallback: "Your Progress")
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
