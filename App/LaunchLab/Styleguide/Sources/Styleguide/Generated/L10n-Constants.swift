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
  /// Weiter
  public static let commonContinue = L10n.tr("Localizable", "common_continue", fallback: "Weiter")
  /// Platzhalter
  public static let commonPlaceholder = L10n.tr("Localizable", "common_placeholder", fallback: "Platzhalter")
  /// Starten
  public static let commonStart = L10n.tr("Localizable", "common_start", fallback: "Starten")
  /// Bitte richte die Mail-App auf deinem Gerät ein.
  public static let configureMailApp = L10n.tr("Localizable", "configure_mail_app", fallback: "Bitte richte die Mail-App auf deinem Gerät ein.")
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
  /// Bearbeite deine Antworten
  public static let editYourAnswers = L10n.tr("Localizable", "edit_your_answers", fallback: "Bearbeite deine Antworten")
  /// Es ist ein Fehler aufgetreten
  public static let errorOccured = L10n.tr("Localizable", "error_occured", fallback: "Es ist ein Fehler aufgetreten")
  /// Feedback
  public static let feedback = L10n.tr("Localizable", "Feedback", fallback: "Feedback")
  /// Allgemein
  public static let general = L10n.tr("Localizable", "general", fallback: "Allgemein")
  /// Generieren
  public static let generate = L10n.tr("Localizable", "generate", fallback: "Generieren")
  /// Generiere dein Pitch Deck, wenn du alle Module abgeschlossen hast.
  public static let generatePitchDeck = L10n.tr("Localizable", "generate_pitch_deck", fallback: "Generiere dein Pitch Deck, wenn du alle Module abgeschlossen hast.")
  /// Was sind deine Ziele mit dem Startup?
  public static let goalsQuestion = L10n.tr("Localizable", "goals_question", fallback: "Was sind deine Ziele mit dem Startup?")
  /// Wähle, was dir am wichtigsten ist.
  public static let goalsSubtitle = L10n.tr("Localizable", "goals_subtitle", fallback: "Wähle, was dir am wichtigsten ist.")
  /// Hello, %@
  public static func hello(_ p1: Any) -> String {
    return L10n.tr("Localizable", "hello %@", String(describing: p1), fallback: "Hello, %@")
  }
  /// Bevor du deine Idee in die Tat umsetzen kannst, möchten wir dich kurz kennenlernen.
  public static let launchScreenSubtitle = L10n.tr("Localizable", "launch_screen_subtitle", fallback: "Bevor du deine Idee in die Tat umsetzen kannst, möchten wir dich kurz kennenlernen.")
  /// Willkommen bei Launchlab 🚀
  public static let launchScreenTitle = L10n.tr("Localizable", "launch_screen_title", fallback: "Willkommen bei Launchlab 🚀")
  /// Du bist auf einem guten Weg, dein Startup zu starten!
  public static let launchingGoodWay = L10n.tr("Localizable", "launching_good_way", fallback: "Du bist auf einem guten Weg, dein Startup zu starten!")
  /// %@/%@ abgeschlossen
  public static func modulesCompleted(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("Localizable", "modules_completed %@ %@", String(describing: p1), String(describing: p2), fallback: "%@/%@ abgeschlossen")
  }
  /// Modul Status
  public static let modulesStatus = L10n.tr("Localizable", "modules_status", fallback: "Modul Status")
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
  /// Pitch Deck
  public static let pitchDeck = L10n.tr("Localizable", "pitch_deck", fallback: "Pitch Deck")
  /// Datenschutzerklärung
  public static let privacyPolicy = L10n.tr("Localizable", "privacy_policy", fallback: "Datenschutzerklärung")
  /// Frage %@ von %@
  public static func questionValueOf(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("Localizable", "question_value_of %@ %@", String(describing: p1), String(describing: p2), fallback: "Frage %@ von %@")
  }
  /// Support
  public static let support = L10n.tr("Localizable", "support", fallback: "Support")
  /// Support & Feedback
  public static let supportAndFeedback = L10n.tr("Localizable", "support_and_feedback", fallback: "Support & Feedback")
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
  /// Deine Antworten
  public static let yourAnswers = L10n.tr("Localizable", "your_answers", fallback: "Deine Antworten")
  /// Dein Status
  public static let yourState = L10n.tr("Localizable", "your_state", fallback: "Dein Status")
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
