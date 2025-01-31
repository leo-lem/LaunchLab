// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Ideate with Your Co-Founder 🤖
  internal static let cofounderLabel = L10n.tr("Localizable", "cofounder_label", fallback: "Ideate with Your Co-Founder 🤖")
  /// Your entered answers will be included in a prompt and sent to ChatGPT for assistance.
  internal static let cofounderTipMessage = L10n.tr("Localizable", "cofounder_tip_message", fallback: "Your entered answers will be included in a prompt and sent to ChatGPT for assistance.")
  /// Get Help from Your Co-Founder
  internal static let cofounderTipTitle = L10n.tr("Localizable", "cofounder_tip_title", fallback: "Get Help from Your Co-Founder")
  /// Complete
  internal static let commonComplete = L10n.tr("Localizable", "common_complete", fallback: "Complete")
  /// Continue
  internal static let commonContinue = L10n.tr("Localizable", "common_continue", fallback: "Continue")
  /// Dismiss
  internal static let commonDismiss = L10n.tr("Localizable", "common_dismiss", fallback: "Dismiss")
  /// Enter text here…
  internal static let commonPlaceholder = L10n.tr("Localizable", "common_placeholder", fallback: "Enter text here…")
  /// Begin
  internal static let commonStart = L10n.tr("Localizable", "common_start", fallback: "Begin")
  /// Please configure the Mail app on your phone.
  internal static let configureMailApp = L10n.tr("Localizable", "configure_mail_app", fallback: "Please configure the Mail app on your phone.")
  /// Something went wrong…
  internal static let errorOccured = L10n.tr("Localizable", "error_occured", fallback: "Something went wrong…")
  /// Export PDF
  internal static let exportPdf = L10n.tr("Localizable", "export_pdf", fallback: "Export PDF")
  /// Feedback
  internal static let feedback = L10n.tr("Localizable", "Feedback", fallback: "Feedback")
  /// General
  internal static let general = L10n.tr("Localizable", "general", fallback: "General")
  /// Generate
  internal static let generate = L10n.tr("Localizable", "generate", fallback: "Generate")
  /// Locked 🔒
  internal static let locked = L10n.tr("Localizable", "locked", fallback: "Locked 🔒")
  /// It's cool, you're testing the app thoroughly. Unfortunately this feature doesn't work on a simulator, since it doesn't have access to the mail system.
  internal static let mailAlertSubtitle = L10n.tr("Localizable", "mail_alert_subtitle", fallback: "It's cool, you're testing the app thoroughly. Unfortunately this feature doesn't work on a simulator, since it doesn't have access to the mail system.")
  /// Mark as completed
  internal static let markCompleted = L10n.tr("Localizable", "mark_completed", fallback: "Mark as completed")
  /// Modules provide valuable insights into key topics and guide you through the process of building a startup.
  internal static let moduleTipMessage = L10n.tr("Localizable", "module_tip_message", fallback: "Modules provide valuable insights into key topics and guide you through the process of building a startup.")
  /// Understanding Modules
  internal static let moduleTipTitle = L10n.tr("Localizable", "module_tip_title", fallback: "Understanding Modules")
  /// Modules
  internal static let modules = L10n.tr("Localizable", "modules", fallback: "Modules")
  /// Chart
  internal static let modulesChart = L10n.tr("Localizable", "modules_chart", fallback: "Chart")
  /// %@/%@ completed
  internal static func modulesCompleted(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("Localizable", "modules_completed %@ %@", String(describing: p1), String(describing: p2), fallback: "%@/%@ completed")
  }
  /// Progress
  internal static let modulesStatus = L10n.tr("Localizable", "modules_status", fallback: "Progress")
  /// Privacy policy
  internal static let privacyPolicy = L10n.tr("Localizable", "privacy_policy", fallback: "Privacy policy")
  /// Review
  internal static let review = L10n.tr("Localizable", "review", fallback: "Review")
  /// Start Consultation
  internal static let startConsulting = L10n.tr("Localizable", "start_consulting", fallback: "Start Consultation")
  /// Support
  internal static let support = L10n.tr("Localizable", "support", fallback: "Support")
  /// Support & Feedback
  internal static let supportAndFeedback = L10n.tr("Localizable", "support_and_feedback", fallback: "Support & Feedback")
  /// Your Progress
  internal static let yourState = L10n.tr("Localizable", "your_state", fallback: "Your Progress")
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
