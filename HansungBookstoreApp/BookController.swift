import UIKit

class BookController: UIViewController {

    // 학과, 학부, 트랙, 책 데이터 정의
    let departments = ["IT공과대학", "크리에이티브인문예술대학", "미래융합사회과학대학"]
    let majors: [String: [String]] = [
        "IT공과대학": ["컴퓨터공학부", "기계전자공학부"],
        "미래융합사회과학대학": ["사회과학부"],
        "크리에이티브인문예술대학": ["크리에이티브 인문학부", "예술학부"]
    ]
    let tracks: [String: [String]] = [
        "컴퓨터공학부": ["모바일소프트웨어트랙", "빅데이터트랙", "웹공학트랙"],
        "기계전자공학부": ["전자트랙", "시스템반도체트랙", "기계설계트랙"],
        "사회과학부": ["국제무역트랙", "글로벌비즈니스트랙", "경제금융투자트랙", "공공행정트랙", "부동산트랙"],
        "크리에이티브 인문학부": ["영미문화콘텐츠트랙", "영미언어정보트랙", "한국어교육트랙"],
        "예술학부": ["동양화전공", "서양화전공", "한국무용전공", "현대무용전공", "발레전공"]
    ]
    var books: [String: [(title: String, stock: Int)]] = [
        "모바일소프트웨어트랙": [("모바일 프로그래밍", 5), ("iOS 개발 입문", 3)],
        "빅데이터트랙": [("빅데이터 분석", 2), ("데이터 마이닝", 1)],
        "웹공학트랙": [("웹 프로그래밍", 7), ("HTML5 & CSS3", 8)],
        "전자트랙": [("전자기기 설계", 3), ("회로이론", 5), ("디지털 시스템 설계", 2)],
        "시스템반도체트랙": [("반도체 공정", 4), ("집적 회로 설계", 6)],
        "기계설계트랙": [("기계 요소 설계", 5), ("열유체 역학", 3), ("자동제어 시스템", 7)],
        "영미문화콘텐츠트랙": [("영미문학 개론", 10), ("문화 콘텐츠의 이해", 7)],
        "영미언어정보트랙": [("언어학 입문", 4), ("영어의 역사", 5)],
        "한국어교육트랙": [("한국어 교육론", 6), ("외국어로서의 한국어", 2)],
        "역사문화큐레이션트랙": [("역사 큐레이션", 3), ("박물관학", 4)],
        "역사콘텐츠트랙": [("역사 콘텐츠 기획", 5), ("디지털 역사", 6)],
        "도서관정보문화트랙": [("도서관 경영", 4), ("정보 서비스", 3)],
        "디지털인문정보학트랙": [("디지털 인문학", 7), ("정보 기술과 인문학", 5)],
        "동양화전공": [("동양화의 기초", 8), ("한국 동양화", 4)],
        "서양화전공": [("서양화의 기초", 6), ("유화 기법", 2)],
        "한국무용전공": [("한국 무용 이론", 3), ("전통 무용의 이해", 5)],
        "현대무용전공": [("현대 무용 실습", 7), ("무용 안무 기법", 2)],
        "발레전공": [("발레 기초", 6), ("발레의 역사", 4)],
        "국제무역트랙": [("국제 무역 이론", 5), ("무역 실무", 4), ("국제 경제학", 3)],
        "글로벌비즈니스트랙": [("글로벌 마케팅", 6), ("국제 비즈니스 전략", 5), ("해외 진출 사례 연구", 2)],
        "경제금융투자트랙": [("투자론", 4), ("금융 시장 분석", 3), ("경제학 원론", 7)],
        "공공행정트랙": [("공공 정책론", 5), ("행정학 개론", 4), ("공공 서비스 혁신", 2)],
        //"부동산트랙": [("부동산 관리론", 3), ("부동산 경제학", 4), ("부동산 투자 분석", 5)]
    ]
    
    // UI 요소들 정의
    let stackView = UIStackView()
    let bookList = UITextView()
    
    // 추가 UI 요소들 정의
    let majorStackView = UIStackView()
    let trackStackView = UIStackView()

    // 설명 레이블 정의
    let departmentLabel = UILabel()
    let majorLabel = UILabel()
    let trackLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 기본 UI 설정
        setupUI()
        
        // 첫 번째 버튼들 추가 (학부 선택)
        for department in departments {
            let button = createCustomButton(withTitle: department)
            button.addTarget(self, action: #selector(departmentButtonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    // UI 요소 초기화 및 설정
    func setupUI() {
        // 각 UI 요소들의 속성 설정
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        majorStackView.axis = .vertical
        majorStackView.distribution = .fillEqually
        majorStackView.spacing = 10
        majorStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(majorStackView)
        
        trackStackView.axis = .vertical
        trackStackView.distribution = .fillEqually
        trackStackView.spacing = 10
        trackStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(trackStackView)
        
        bookList.isEditable = false
        bookList.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bookList)
        
        departmentLabel.text = "학과를 선택하세요"
        departmentLabel.font = UIFont.boldSystemFont(ofSize: 18)
        departmentLabel.textAlignment = .center
        departmentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(departmentLabel)
        
        majorLabel.text = "학부를 선택하세요"
        majorLabel.font = UIFont.boldSystemFont(ofSize: 18)
        majorLabel.textAlignment = .center
        majorLabel.translatesAutoresizingMaskIntoConstraints = false
        majorLabel.isHidden = true
        self.view.addSubview(majorLabel)
        
        trackLabel.text = "트랙을 선택하세요"
        trackLabel.font = UIFont.boldSystemFont(ofSize: 18)
        trackLabel.textAlignment = .center
        trackLabel.translatesAutoresizingMaskIntoConstraints = false
        trackLabel.isHidden = true
        self.view.addSubview(trackLabel)
        
        // 제약조건 설정
        NSLayoutConstraint.activate([
            departmentLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            departmentLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            departmentLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: departmentLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            majorLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            majorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            majorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            majorStackView.topAnchor.constraint(equalTo: majorLabel.bottomAnchor, constant: 20),
            majorStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            majorStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            trackLabel.topAnchor.constraint(equalTo: majorStackView.bottomAnchor, constant: 20),
            trackLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            trackLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            trackStackView.topAnchor.constraint(equalTo: trackLabel.bottomAnchor, constant: 20),
            trackStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            trackStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            bookList.topAnchor.constraint(equalTo: trackStackView.bottomAnchor, constant: 20),
            bookList.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            bookList.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            bookList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20)
        ])
    }
    
    // 커스텀 버튼 생성 함수
    func createCustomButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
        return button
    }

    @objc func departmentButtonTapped(_ sender: UIButton) {
        guard let department = sender.title(for: .normal) else { return }
        
        // 전공 스택뷰의 모든 서브뷰 제거
        majorStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        trackStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        bookList.text = ""
        
        // 전공 버튼들 추가
        if let majorList = majors[department] {
            for major in majorList {
                let button = createCustomButton(withTitle: major)
                button.addTarget(self, action: #selector(majorButtonTapped(_:)), for: .touchUpInside)
                majorStackView.addArrangedSubview(button)
            }
        }
        
        // 설명 레이블 업데이트
        departmentLabel.isHidden = true
        majorLabel.isHidden = false
        trackLabel.isHidden = true
    }
    
    @objc func majorButtonTapped(_ sender: UIButton) {
        guard let major = sender.title(for: .normal) else { return }
        
        // 트랙 스택뷰의 모든 서브뷰 제거
        trackStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        bookList.text = ""
        
        // 트랙 버튼들 추가
        if let trackList = tracks[major] {
            for track in trackList {
                let button = createCustomButton(withTitle: track)
                button.addTarget(self, action: #selector(trackButtonTapped(_:)), for: .touchUpInside)
                trackStackView.addArrangedSubview(button)
            }
        }
        
        // 설명 레이블 업데이트
        departmentLabel.isHidden = true
        majorLabel.isHidden = true
        trackLabel.isHidden = false
    }
    
    @objc func trackButtonTapped(_ sender: UIButton) {
        guard let track = sender.title(for: .normal) else { return }
        
        // 책 목록 업데이트
        if let bookListData = books[track] {
            let bookText = bookListData.map { "\($0.title) - 재고: \($0.stock)" }.joined(separator: "\n")
            bookList.text = bookText
        } else {
            bookList.text = "해당 트랙에 대한 책 정보가 없습니다."
        }
    }
}
