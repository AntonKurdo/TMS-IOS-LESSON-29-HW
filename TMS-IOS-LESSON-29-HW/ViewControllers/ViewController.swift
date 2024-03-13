import UIKit
import Alamofire

class ViewController: UIViewController {
    
    enum Constants {
        static let url = "https://jsonplaceholder.typicode.com/users"
    }
    
    var spinner = SpinnerViewController()
    
    let tableView = UITableView()
    
    var users: [User] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSpinner()
        setupTable()
        
        fetchUsers() { data in
            self.users = data
        }
    }
    
    private func fetchUsers(completion: @escaping (_ data: [User]) -> ()) {
        self.showSpinner()
        DispatchQueue.global().async {
            AF.request(Constants.url, method: .get ).responseDecodable(of: [User].self) { response in
                switch response.result {
                    case .success(let data):
                        completion(data)
                    case .failure(let error):
                        print(error)
                    }
                self.hideSpinner()
            }
        }
   
    }
    
    private func showSpinner() {
        view.addSubview(spinner.view)
    }
    
    private func setupSpinner() {
        spinner.view.frame = view.frame
    }
    
    private func hideSpinner() {
        self.spinner.willMove(toParent: nil)
        self.spinner.view.removeFromSuperview()
        self.spinner.removeFromParent()
    }
    
    private func setupTable() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
}
