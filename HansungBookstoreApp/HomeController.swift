import UIKit
import MapKit

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // UI 요소들 정의
    let searchContainerView = UIView() // 검색창을 담는 뷰
    let searchBar = UISearchBar() // 검색창
    let lowStockLabel = UILabel() // 재고 수가 적은 도서 라벨
    let lowStockTableView = UITableView() // 재고 수가 적은 도서를 나타내는 테이블 뷰
    let newBooksLabel = UILabel() // 새로 입고된 도서 라벨
    let newBooksCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()) // 새로운 도서를 나타내는 컬렉션 뷰
    let mapView = MKMapView() // 지도 뷰
    
    // 도서 데이터 정의
    var books: [(title: String, stock: Int, author: String, publisher: String, image: UIImage)] = [
        ("모바일 프로그래밍", 5, "홍길동", "한성출판사", UIImage(named: "mobile_programming")!),
        ("빅데이터 분석", 2, "이순신", "한성출판사", UIImage(named: "bigdata_analysis")!),
        ("데이터마이닝", 7, "신사임당", "한성출판사", UIImage(named: "datamining")!),
        ("IOS프로그래밍", 10, "유관순", "한성출판사", UIImage(named: "ios_programming")!),
        ("안드로이드", 4, "장영실", "한성출판사", UIImage(named: "android")!)
    ]
    
    // 재고 수가 적은 도서 데이터 정의
    var lowbooks: [(title: String, stock: Int, author: String, publisher: String)] = [
        ("전자기기 설계", 3, "유재석", "한성출판사"),
        ("동양화의 기초", 3, "박명수", "한성출판사"),
        ("디지털 인문학", 2, "박서준", "한성출판사"),
        ("발레 기초", 1, "손흥민", "한성출판사"),
        ("공공 정책론", 1, "이강인", "한성출판사")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 검색창 추가 설정
        setupSearchBar()
        
        // 재고 수가 적은 도서 라벨 설정
        setupLowStockLabel()
        
        // 재고 수가 적은 도서 TableView 설정
        setupLowStockTableView()
        
        // 새로 입고된 도서 라벨 설정
        setupNewBooksLabel()
        
        // 인기 도서 CollectionView 설정
        setupNewBooksCollectionView()
        
        // 지도 설정
        setupMapView()
        
        // 초기 UI 설정
        configureInitialUI()
    }
    
    // 검색창 UI 설정
    func setupSearchBar() {
        searchContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchContainerView)
        
        searchBar.placeholder = "도서 검색"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchContainerView.addSubview(searchBar)
        
        let searchButton = UIButton(type: .system)
        searchButton.setTitle("검색", for: .normal)
        searchButton.addTarget(self, action: #selector(showSearchBar), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchContainerView.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            searchContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchContainerView.heightAnchor.constraint(equalToConstant: 44), // 검색창 높이 설정
            
            searchBar.topAnchor.constraint(equalTo: searchContainerView.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: searchContainerView.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: searchContainerView.bottomAnchor),
            
            searchButton.topAnchor.constraint(equalTo: searchContainerView.topAnchor),
            searchButton.trailingAnchor.constraint(equalTo: searchContainerView.trailingAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 60),
            searchButton.bottomAnchor.constraint(equalTo: searchContainerView.bottomAnchor)
        ])
    }
    
    // 검색창 보이기
    @objc func showSearchBar() {
        searchBar.isHidden = false
    }
    
    // 재고 수가 적은 도서 라벨 설정
    func setupLowStockLabel() {
        lowStockLabel.text = "재고 수가 적은 도서"
        lowStockLabel.font = UIFont.boldSystemFont(ofSize: 18)
        lowStockLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(lowStockLabel)
        
        NSLayoutConstraint.activate([
            lowStockLabel.topAnchor.constraint(equalTo: searchContainerView.bottomAnchor, constant: 20),
            lowStockLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    // 재고 수가 적은 도서 TableView 설정
    func setupLowStockTableView() {
        lowStockTableView.delegate = self
        lowStockTableView.dataSource = self
        lowStockTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(lowStockTableView)
        
        NSLayoutConstraint.activate([
            lowStockTableView.topAnchor.constraint(equalTo: lowStockLabel.bottomAnchor, constant: 10),
            lowStockTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lowStockTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lowStockTableView.heightAnchor.constraint(equalToConstant: 200) // 테이블 높이 설정
        ])
    }
    
    // 새로 들어온 도서 라벨 설정
    func setupNewBooksLabel() {
        newBooksLabel.text = "새로 입고된 도서"
        newBooksLabel.font = UIFont.boldSystemFont(ofSize: 18)
        newBooksLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(newBooksLabel)
        
        NSLayoutConstraint.activate([
            newBooksLabel.topAnchor.constraint(equalTo: lowStockTableView.bottomAnchor, constant: 20),
            newBooksLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    // 인기 도서 CollectionView 설정
    func setupNewBooksCollectionView() {
        newBooksCollectionView.delegate = self
        newBooksCollectionView.dataSource = self
        newBooksCollectionView.showsHorizontalScrollIndicator = false
        newBooksCollectionView.translatesAutoresizingMaskIntoConstraints = false
        newBooksCollectionView.register(NewBookCell.self, forCellWithReuseIdentifier: "NewBookCell")
        self.view.addSubview(newBooksCollectionView)
        
        NSLayoutConstraint.activate([
            newBooksCollectionView.topAnchor.constraint(equalTo: newBooksLabel.bottomAnchor, constant: 10),
            newBooksCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newBooksCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            newBooksCollectionView.heightAnchor.constraint(equalToConstant: 150) // 컬렉션 뷰 높이 설정
        ])
        
        if let flowLayout = newBooksCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
    }
    
    // 지도 설정
    func setupMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mapView)
        
        // 서점 위치 설정 (한성대학교 중앙대학교 정보센터 기준)
        let bookstoreLocation = CLLocationCoordinate2D(latitude: 37.588856, longitude: 127.006471)
        let regionRadius: CLLocationDistance = 800
        let coordinateRegion = MKCoordinateRegion(center: bookstoreLocation, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        // 마커 추가
        let annotation = MKPointAnnotation()
        annotation.coordinate = bookstoreLocation
        annotation.title = "한성대학교 서점"
        mapView.addAnnotation(annotation)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: newBooksCollectionView.bottomAnchor, constant: 20), // 새로운 도서 CollectionView 아래에 위치
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mapView.heightAnchor.constraint(equalToConstant: 150) // 지도 높이 설정
        ])
    }
    
    // 초기 UI 설정
    func configureInitialUI() {
        lowStockTableView.isHidden = false // 초기에는 숨김 처리 해제
    }
    
    // TableView 데이터 소스 및 델리게이트 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lowbooks.count // 재고 수가 적은 도서의 개수 반환
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let book = lowbooks[indexPath.row]
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = "저자: \(book.author) / 출판사: \(book.publisher) / 재고: \(book.stock)"
        return cell
    }
    
    // CollectionView 데이터 소스 및 델리게이트 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count // 도서의 개수 반환
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewBookCell", for: indexPath) as! NewBookCell
        let book = books[indexPath.row]
        cell.configure(with: book)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: collectionView.frame.height) // 컬렉션 뷰 셀 크기 설정
    }
}

// Custom CollectionViewCell
class NewBookCell: UICollectionViewCell {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let publisherLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 셀 내 요소 추가
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(publisherLabel)
        
        // 요소 레이아웃 설정
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        publisherLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .black
        authorLabel.font = UIFont.systemFont(ofSize: 12)
        authorLabel.textColor = .darkGray
        publisherLabel.font = UIFont.systemFont(ofSize: 12)
        publisherLabel.textColor = .darkGray
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            publisherLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 2),
            publisherLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            publisherLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 셀 데이터 설정
    func configure(with book: (title: String, stock: Int, author: String, publisher: String, image: UIImage)) {
        imageView.image = book.image
        titleLabel.text = book.title
        authorLabel.text = book.author
        publisherLabel.text = book.publisher
    }
}
