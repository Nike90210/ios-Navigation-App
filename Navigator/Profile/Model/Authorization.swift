
import Foundation

final class Authorization {

    static let authorzation: Authorization = .init()

    let defaultLogin: String = "Just@mail.com"
    let defaultPassword: String = "JustPassword"

    func athorizationIsCorrect(login: String?, password: String?) throws{
        guard login != "" else { throw PossibleErrors.loginIsEmpty }
        guard password != "" else { throw PossibleErrors.passwordIsEmpty}
        guard login != "" || password != "" else { throw PossibleErrors.linesIsEmpty}
        guard let login = login else { return }
        guard let password = password else { return }
        guard  isMailCorrect(loging: login) else { throw PossibleErrors.notEmail}
        guard password.count >= 6 else { throw PossibleErrors.incorrectPaswword }
         if login != defaultLogin { throw PossibleErrors.incorrectLogin}
         if password != defaultPassword { throw PossibleErrors.incorrectPaswword}
    }

    private func isMailCorrect(loging: String) -> Bool {
        let MRegEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", MRegEX)
        return predicate.evaluate(with: loging)
    }

}

enum PossibleErrors: Error {
    case linesIsEmpty
    case loginIsEmpty
    case passwordIsEmpty
    case incorrectPaswword
    case incorrectLogin
    case notEmail
}
