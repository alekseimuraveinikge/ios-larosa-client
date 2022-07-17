protocol AuthService {
	var isAuthorized: Bool { get }
}

final class AuthServiceImpl: AuthService {
	var isAuthorized: Bool {
		false
	}
}
