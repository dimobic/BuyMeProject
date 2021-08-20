import UIKit

class MainViewController: UIViewController {
    
    lazy var StorageButton: UIButton = {
        let Button = UIButton(type: .system)
        var image = UIImage(named: "icon/Копия storage.png")!
        image = image.withTintColor(.black, renderingMode: .alwaysOriginal)
        Button.setImage( image , for: .normal)
        Button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        Button.imageView?.contentMode = .scaleAspectFit
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.backgroundColor = .green
        //Button.addTarget(self, action: #selector(HitMeTouchUpInside), for: .touchUpInside)
        return Button
    }()
    lazy var ScaleButton: UIButton = {
        let Button = UIButton(type: .system)
        var image = UIImage(named: "icon/scales1.png")!
        image = image.withTintColor(.black, renderingMode: .alwaysOriginal)
        Button.setImage( image , for: .normal)
        Button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        Button.imageView?.contentMode = .scaleAspectFit
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.backgroundColor = .yellow
        //Button.addTarget(self, action: #selector(HitMeTouchUpInside), for: .touchUpInside)
        return Button
    }()
    lazy var ListButton: UIButton = {
        let Button = UIButton(type: .system)
        var image = UIImage(named: "icon/Копия List.png")!
        image = image.withTintColor(.black, renderingMode: .alwaysOriginal)
        Button.setImage( image , for: .normal)
        Button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        Button.imageView?.contentMode = .scaleAspectFit
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.backgroundColor = .blue
        //Button.addTarget(self, action: #selector(HitMeTouchUpInside), for: .touchUpInside)
        return Button
    }()
    lazy var StatisticsButton: UIButton = {
        let Button = UIButton(type: .system)
        var image = UIImage(named: "icon/Копия statistics.png")!
        image = image.withTintColor(.black, renderingMode: .alwaysOriginal)
        Button.setImage( image , for: .normal)
        Button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        Button.imageView?.contentMode = .scaleAspectFit
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.backgroundColor = .red
        //Button.addTarget(self, action: #selector(HitMeTouchUpInside), for: .touchUpInside)
        return Button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        view.backgroundColor = .white
        setupConstraints()
    }
    func addSubviews() {
        self.view.addSubview(StorageButton)
        self.view.addSubview(ScaleButton)
        self.view.addSubview(ListButton)
        self.view.addSubview(StatisticsButton)
    }
    func setupConstraints() {
        StorageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        StorageButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        StorageButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        StorageButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
        
        ScaleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        ScaleButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        ScaleButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        ScaleButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
        
        ListButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        ListButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        ListButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        ListButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
        
        StatisticsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        StatisticsButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        StatisticsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        StatisticsButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
    }
}
