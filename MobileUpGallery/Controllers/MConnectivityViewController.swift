
import UIKit

class MConnectivityViewController: UIViewController {

    private var timer: Timer?

    private var isConnectionAvailable: Bool {
        return MInternetConnection.shared.isConnectedToNetwork()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        startCheckingConnectivity()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        stopCheck()
    }

    private func startCheckingConnectivity() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] timer in
            if !(self?.isConnectionAvailable ?? false) {
                let alert = UIAlertController(title: "Отсутствует интернет соединение", message: "Проверьте ваше интернет-соединение и повторите попытку", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self?.present(alert, animated: true)
            }
        }
    }

    private func stopCheck() {
        timer?.invalidate()
        timer = nil
    }
}
