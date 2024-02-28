import UIKit
import Alamofire

class ViewController: UIViewController {
    
    enum Constants {
        static let url = "https://jsonplaceholder.typicode.com/users"
    }
    
    var spinner = SpinnerViewController()
    
    let tableView = UITableView()
    
    var users: Users = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSpinner()
        setupTable()
        fetchUsers()
    }
    
    private func fetchUsers() {
        view.addSubview(spinner.view)
        AF.request(Constants.url, method: .get ).responseDecodable(of: Users.self) { response in
            switch response.result {
            case .success(let data):
                self.users = data
            case .failure(let error):
                print(error)
            }
            self.spinner.willMove(toParent: nil)
            self.spinner.view.removeFromSuperview()
            self.spinner.removeFromParent()
        }
    }
    
    private func setupSpinner() {
        spinner.view.frame = view.frame
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
