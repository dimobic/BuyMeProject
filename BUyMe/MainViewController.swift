import UIKit

class MainViewController: UIViewController {
    
    func but (button : UIButton) -> UIButton{
        button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray2
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 3
        button.setTitleColor(.black, for: .normal)
        return button
    }
    lazy var StorageButton: UIButton = {
        let Button = UIButton(type: .system)
        var image = UIImage(named: "icon/storage.png")!
        Button.setTitle("Запасы", for: .normal)
        image = image.withTintColor(.black, renderingMode: .alwaysOriginal)
        Button.setImage( image , for: .normal)
        Button.addTarget(self, action: #selector(StorageButtonTouchUpInside), for: .touchUpInside)
        return but(button: Button)
    }()
    lazy var ScaleButton: UIButton = {
        let Button = UIButton(type: .system)
        var image = UIImage(named: "icon/scales.png")!
        Button.setTitle("Сравнение", for: .normal)
        image = image.withTintColor(.black, renderingMode: .alwaysOriginal)
        Button.setImage( image , for: .normal)
        Button.addTarget(self, action: #selector(ScaleButtonTouchUpInside), for: .touchUpInside)

        return but(button: Button)
    }()
    lazy var ListButton: UIButton = {
        let Button = UIButton(type: .system)
        var image = UIImage(named: "icon/List.png")!
        Button.setTitle("Списки", for: .normal)
        image = image.withTintColor(.black, renderingMode: .alwaysOriginal)
        Button.setImage( image , for: .normal)
        Button.addTarget(self, action: #selector(ListButtonTouchUpInside), for: .touchUpInside)

        return but(button: Button)
    }()
    lazy var StatisticsButton: UIButton = {
        let Button = UIButton(type: .system)
        var image = UIImage(named: "icon/statistics.png")!
        Button.setTitle("Статистика", for: .normal)
        image = image.withTintColor(.black, renderingMode: .alwaysOriginal)
        Button.setImage( image , for: .normal)
        Button.addTarget(self, action: #selector(StatisticsButtonTouchUpInside), for: .touchUpInside)
        return but(button: Button)
    }()

    @objc func StorageButtonTouchUpInside(){
        let viewController = StorageTableViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.modalPresentationStyle = .fullScreen
        navigation.modalTransitionStyle = .flipHorizontal
        self.present(navigation, animated: true, completion: nil)
        
    }
    @objc func ScaleButtonTouchUpInside(){
        let viewController = ScalesTableViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.modalPresentationStyle = .fullScreen
        navigation.modalTransitionStyle = .flipHorizontal
        self.present(navigation, animated: true, completion: nil)
    }
    @objc func ListButtonTouchUpInside(){
        let viewController = ListTableViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.modalPresentationStyle = .fullScreen
        navigation.modalTransitionStyle = .flipHorizontal
        self.present(navigation, animated: true, completion: nil)
    }
    @objc func StatisticsButtonTouchUpInside(){
        let viewController = StatisticsTableViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.modalPresentationStyle = .fullScreen
        navigation.modalTransitionStyle = .flipHorizontal
        self.present(navigation, animated: true, completion: nil)
    }

    func viewDidRotate (_ size : CGSize, _ button : UIButton){
        let screenWidth = size.width
        let screenHeight = size.height
        //print("SCREEN RESOLUTION: "+screenWidth.description+" x "+screenHeight.description)
        if screenWidth < screenHeight {
            button.titleEdgeInsets = UIEdgeInsets(top: screenHeight/4, left: -screenWidth/8 - 30, bottom: 0, right: screenWidth/8 - 10)
            button.imageEdgeInsets = UIEdgeInsets(top: screenHeight/30, left: screenHeight/30, bottom: screenHeight/30, right: screenHeight/30)

        }else{
            button.titleEdgeInsets = UIEdgeInsets(top: screenHeight/3, left: -screenWidth/5 - 20, bottom: 0, right: screenWidth/5 - 30)
            button.imageEdgeInsets = UIEdgeInsets(top: screenWidth/30 - 10, left: screenWidth/30, bottom: screenWidth/30 + 10, right: screenWidth/30)
        }
    
        viewDidLoad()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        viewDidRotate(size, StorageButton)
        viewDidRotate(size, ScaleButton)
        viewDidRotate(size, ListButton)
        viewDidRotate(size, StatisticsButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        view.backgroundColor = .white
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        let size  = UIScreen.main.bounds.size
        viewDidRotate(size, StorageButton)
        viewDidRotate(size, ScaleButton)
        viewDidRotate(size, ListButton)
        viewDidRotate(size, StatisticsButton)
    }
    func addSubviews() {
        self.view.addSubview(StorageButton)
        self.view.addSubview(ScaleButton)
        self.view.addSubview(ListButton)
        self.view.addSubview(StatisticsButton)
    }
    func setupConstraints() {
        StorageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        StorageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        StorageButton.rightAnchor.constraint(equalTo: ScaleButton.leftAnchor, constant: -20).isActive = true
        StorageButton.widthAnchor.constraint(equalTo: ScaleButton.widthAnchor).isActive = true
        StorageButton.heightAnchor.constraint(equalTo: ScaleButton.heightAnchor).isActive = true
        
        ScaleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        ScaleButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        ScaleButton.leftAnchor.constraint(equalTo: StorageButton.rightAnchor, constant: 20).isActive = true
        ScaleButton.widthAnchor.constraint(equalTo: StorageButton.widthAnchor).isActive = true
        ScaleButton.heightAnchor.constraint(equalTo: StorageButton.heightAnchor).isActive = true
       
        ListButton.topAnchor.constraint(equalTo: ScaleButton.bottomAnchor, constant: 20).isActive = true
        ListButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        ListButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        ListButton.leftAnchor.constraint(equalTo: StatisticsButton.rightAnchor, constant: 20).isActive = true
        ListButton.widthAnchor.constraint(equalTo: ScaleButton.widthAnchor).isActive = true
        ListButton.heightAnchor.constraint(equalTo: ScaleButton.heightAnchor).isActive = true
        
        StatisticsButton.topAnchor.constraint(equalTo: StorageButton.bottomAnchor, constant: 20).isActive = true
        StatisticsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        StatisticsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        StatisticsButton.rightAnchor.constraint(equalTo: ListButton.leftAnchor, constant: -20).isActive = true
        StatisticsButton.widthAnchor.constraint(equalTo: ScaleButton.widthAnchor).isActive = true
        StatisticsButton.heightAnchor.constraint(equalTo: ScaleButton.heightAnchor).isActive = true
    }
}
