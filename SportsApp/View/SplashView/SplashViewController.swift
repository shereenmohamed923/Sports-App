import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    private var animationView: LottieAnimationView?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLottieAnimation()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.navigateToHomeTabBar()
        }
    }

    private func setupLottieAnimation() {
        animationView = LottieAnimationView(name: "splash")
        guard let animationView = animationView else { return }

        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1.0
        view.addSubview(animationView)

        animationView.play()
    }

    private func navigateToHomeTabBar() {
        let tabBarController = HomeTabBarViewController()

        if let navigationController = self.navigationController {
            navigationController.setViewControllers([tabBarController], animated: true)
        }
    }
}
