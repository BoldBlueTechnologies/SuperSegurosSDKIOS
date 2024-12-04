//
//  Untitled.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 02/12/24.
//

import UIKit

class CustomSegmentedControl: UIView {


    var buttonTitles: [String] = []
    var buttons: [UIButton] = []
    var selectorView: UIView?

    var textColor: UIColor = .black
    var selectedTextColor: UIColor = .black
    var selectorLineColor: UIColor = UIColor.moduleColor(named: "mainSuper") ?? UIColor.blue

    var selectedIndex: Int = 0

  
    var onTabChanged: ((_ index: Int) -> Void)?


    convenience init(frame: CGRect, buttonTitles: [String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitles
        self.configureView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

   
    func configureView() {
        createButtons()
        configureStackView()
        configureSelectorView()
    }

    func createButtons() {
        buttons = [UIButton]()
        for (index, title) in buttonTitles.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.poppinsSemiBold(size: 12)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            button.tag = index
            buttons.append(button)
        }
        buttons[selectedIndex].setTitleColor(selectedTextColor, for: .normal)
    }

    func configureStackView() {
       
        let totalButtonWidth = buttons.reduce(0) { $0 + $1.intrinsicContentSize.width }

        if totalButtonWidth <= self.frame.width {

            let stackView = UIStackView(arrangedSubviews: buttons)
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.spacing = 0
            stackView.distribution = .fillEqually
            addSubview(stackView)

            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: self.topAnchor),
                stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        } else {
           
            let scrollView = UIScrollView()
            scrollView.showsHorizontalScrollIndicator = false
            addSubview(scrollView)

            scrollView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: self.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])

            let stackView = UIStackView(arrangedSubviews: buttons)
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.spacing = 0
            stackView.distribution = .fill
            scrollView.addSubview(stackView)

            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
            ])
        }
    }

    func configureSelectorView() {
        layoutIfNeeded()
        guard buttons.indices.contains(selectedIndex) else { return }
        let selectedButton = buttons[selectedIndex]
        let selectorWidth = selectedButton.frame.width
        let selectorPosition = selectedButton.frame.origin.x
        selectorView = UIView(frame: CGRect(x: selectorPosition, y: self.frame.height - 2, width: selectorWidth, height: 2))
        selectorView?.backgroundColor = selectorLineColor
        if let selectorView = selectorView {
            addSubview(selectorView)
        }
    }

    @objc func buttonTapped(button: UIButton) {
        let index = button.tag
        updateSegmentedControl(index: index)
        onTabChanged?(index)
    }

    func updateSegmentedControl(index: Int) {
        buttons.forEach { $0.setTitleColor(textColor, for: .normal) }
        guard buttons.indices.contains(index) else { return }
        let selectedButton = buttons[index]
        selectedButton.setTitleColor(selectedTextColor, for: .normal)
        selectedIndex = index

        guard let selectorView = selectorView else { return }
        let selectorWidth = selectedButton.frame.width
        let selectorPosition = selectedButton.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            selectorView.frame.origin.x = selectorPosition
            selectorView.frame.size.width = selectorWidth
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
      
        updateSelectorPosition()
    }

    func updateSelectorPosition() {
        guard let selectorView = selectorView else { return }
        guard buttons.indices.contains(selectedIndex) else { return }
        let selectedButton = buttons[selectedIndex]
        let selectorWidth = selectedButton.frame.width
        let selectorPosition = selectedButton.frame.origin.x
        selectorView.frame = CGRect(x: selectorPosition, y: self.frame.height - 2, width: selectorWidth, height: 2)
    }
}
