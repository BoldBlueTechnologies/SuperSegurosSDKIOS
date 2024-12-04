//
//  CustomSegmentedControl.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 02/12/24.
//

import UIKit

class SegmentedViewController: UIViewController {


    var viewControllers: [UIViewController] = []
    var segmentedControl: CustomSegmentedControl!

    var containerView: UIView!
    var segmentControlHeight: CGFloat = 50.0
    var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        setupContainerView()
        displayCurrentViewController(index: selectedIndex)
        segmentedControl.updateSegmentedControl(index: selectedIndex)
    }

    func setupSegmentedControl() {
        let titles = viewControllers.map { $0.title ?? "Tab" }
        segmentedControl = CustomSegmentedControl(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: segmentControlHeight), buttonTitles: titles)
        segmentedControl.onTabChanged = { [weak self] index in
            self?.displayCurrentViewController(index: index)
        }
        self.view.addSubview(segmentedControl)
    }

    func setupContainerView() {
        containerView = UIView()
        self.view.addSubview(containerView)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    func displayCurrentViewController(index: Int) {
      
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }

        let vc = viewControllers[index]
        addChild(vc)
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
}
