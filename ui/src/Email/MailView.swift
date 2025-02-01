import MessageUI

/// An Email composition view.
public struct MailView: UIViewControllerRepresentable {
  public class Coordinator: NSObject, @preconcurrency MFMailComposeViewControllerDelegate {
    public let parent: MailView

    public init(_ parent: MailView) { self.parent = parent }

    @MainActor public func mailComposeController(
      _ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?
    ) {
      self.parent.onSend(error)
      controller.dismiss(animated: true)
    }
  }

  public let email: Email, onSend: (Error?) -> Void

  public init(_ email: Email, onSend: @escaping (Error?) -> Void) {
    self.email = email
    self.onSend = onSend
  }

  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  public func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
    let mvc = MFMailComposeViewController()
    mvc.mailComposeDelegate = context.coordinator
    mvc.setSubject(email.subject)
    mvc.setToRecipients([email.address])
    mvc.setMessageBody(email.body, isHTML: false)
    if let attachment = email.attachment {
      mvc.addAttachmentData(attachment.data, mimeType: "application/pdf", fileName: attachment.filename)
    }
    mvc.accessibilityElementDidLoseFocus()
    return mvc
  }

  public func updateUIViewController(
    _ uiViewController: MFMailComposeViewController,
    context: UIViewControllerRepresentableContext<MailView>
  ) {}

  public static var canSend: Bool {
    MFMailComposeViewController.canSendMail()
  }
}
