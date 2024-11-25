// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// Weiter
  public static let commonContinue = L10n.tr("Localizable", "common_continue", fallback: "Weiter")
  /// Platzhalter
  public static let commonPlaceholder = L10n.tr("Localizable", "common_placeholder", fallback: "Platzhalter")
  /// Starten
  public static let commonStart = L10n.tr("Localizable", "common_start", fallback: "Starten")
  /// Ich habe eine Idee und möchte sie umsetzen
  public static let currentStateAnswerIdea = L10n.tr("Localizable", "currentState_answer_idea", fallback: "Ich habe eine Idee und möchte sie umsetzen")
  /// Ich habe noch keine Idee
  public static let currentStateAnswerNoIdea = L10n.tr("Localizable", "currentState_answer_noIdea", fallback: "Ich habe noch keine Idee")
  /// Ich habe schon ein laufendes Startup
  public static let currentStateAnswerRunning = L10n.tr("Localizable", "currentState_answer_running", fallback: "Ich habe schon ein laufendes Startup")
  /// Ich arbeite bereits an meinem Startup
  public static let currentStateAnswerWorking = L10n.tr("Localizable", "currentState_answer_working", fallback: "Ich arbeite bereits an meinem Startup")
  /// Wo stehst du gerade bei deinem Startup?
  public static let currentStateQuestion = L10n.tr("Localizable", "currentState_question", fallback: "Wo stehst du gerade bei deinem Startup?")
  /// Markiere den Punkt, an dem du dich gerade befindest.
  public static let currentStateSubtitle = L10n.tr("Localizable", "currentState_subtitle", fallback: "Markiere den Punkt, an dem du dich gerade befindest.")
  /// Was sind deine Ziele mit dem Startup?
  public static let goalsQuestion = L10n.tr("Localizable", "goals_question", fallback: "Was sind deine Ziele mit dem Startup?")
  /// Wähle, was dir am wichtigsten ist.
  public static let goalsSubtitle = L10n.tr("Localizable", "goals_subtitle", fallback: "Wähle, was dir am wichtigsten ist.")
  /// Bevor du deine Idee in die Tat umsetzen kannst, möchten wir dich kurz kennenlernen.
  public static let launchScreenSubtitle = L10n.tr("Localizable", "launch_screen_subtitle", fallback: "Bevor du deine Idee in die Tat umsetzen kannst, möchten wir dich kurz kennenlernen.")
  /// Willkommen bei Launchlab 🚀
  public static let launchScreenTitle = L10n.tr("Localizable", "launch_screen_title", fallback: "Willkommen bei Launchlab 🚀")
  /// Finanziellen Erfolg erzielen
  public static let motivationAnswerFinancial = L10n.tr("Localizable", "motivation_answer_financial", fallback: "Finanziellen Erfolg erzielen")
  /// Die Freiheit, mein eigener Chef zu sein
  public static let motivationAnswerFreedom = L10n.tr("Localizable", "motivation_answer_freedom", fallback: "Die Freiheit, mein eigener Chef zu sein")
  /// Innovative Ideen in die Welt bringen
  public static let motivationAnswerInnovation = L10n.tr("Localizable", "motivation_answer_innovation", fallback: "Innovative Ideen in die Welt bringen")
  /// Ein Problem lösen, das mir wichtig ist
  public static let motivationAnswerProblem = L10n.tr("Localizable", "motivation_answer_problem", fallback: "Ein Problem lösen, das mir wichtig ist")
  /// Was motiviert dich, ein Startup zu gründen?
  public static let motivationQuestion = L10n.tr("Localizable", "motivation_question", fallback: "Was motiviert dich, ein Startup zu gründen?")
  /// Wähle aus, was dich am meisten antreibt.
  public static let motivationSubtitle = L10n.tr("Localizable", "motivation_subtitle", fallback: "Wähle aus, was dich am meisten antreibt.")
  /// Frage %@ von %@
  public static func questionValueOf(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("Localizable", "question_value_of %@ %@", String(describing: p1), String(describing: p2), fallback: "Frage %@ von %@")
  }
  /// Berufstätige oder Unternehmen
  public static let targetGroupAnswerProfessionals = L10n.tr("Localizable", "targetGroup_answer_professionals", fallback: "Berufstätige oder Unternehmen")
  /// Schüler und Studenten
  public static let targetGroupAnswerStudents = L10n.tr("Localizable", "targetGroup_answer_students", fallback: "Schüler und Studenten")
  /// Technikbegeisterte
  public static let targetGroupAnswerTechies = L10n.tr("Localizable", "targetGroup_answer_techies", fallback: "Technikbegeisterte")
  /// Weiß ich noch nicht
  public static let targetGroupAnswerUnknown = L10n.tr("Localizable", "targetGroup_answer_unknown", fallback: "Weiß ich noch nicht")
  /// Für wen ist dein Startup gedacht? Wer ist deine Zielgruppe?
  public static let targetGroupQuestion = L10n.tr("Localizable", "targetGroup_question", fallback: "Für wen ist dein Startup gedacht? Wer ist deine Zielgruppe?")
  /// Überlege dir, wen du erreichen möchtest.
  public static let targetGroupSubtitle = L10n.tr("Localizable", "targetGroup_subtitle", fallback: "Überlege dir, wen du erreichen möchtest.")
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
