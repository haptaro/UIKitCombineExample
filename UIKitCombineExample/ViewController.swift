//
//  ViewController.swift
//  UIKitCombineExample
//
//  Created by Kotaro Fukuo on 2022/08/06.
//

import UIKit
import Combine

final class ViewController: UIViewController {
    private let viewModel = ViewModel()
    private var cancellables = Set<AnyCancellable>()
    private let textLabel = UILabel()
    private let button = UIButton()
    private let indicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutComponents()
        bind()
    }
}

private extension ViewController {
    func layoutComponents() {
        setupLabel()
        setupButton()
        setupLoadingIndicator()
    }
    
    func setupLabel() {
        textLabel.text = ""
        textLabel.sizeToFit()
        textLabel.backgroundColor = UIColor.gray
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textLabel)
        
        textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupButton() {
        button.setTitle("Tap", for: .normal)
        button.backgroundColor = UIColor.red
        button.sizeToFit()
        button.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 100).isActive = true
    }
    
    func setupLoadingIndicator() {
        indicator.frame = CGRect(x: 0, y: 0, width: 400, height: 200)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func didTapButton(sender: UIButton) {
        Task.detached { [weak self] in
            await self?.viewModel.tapButton()
        }
    }
    
    func bind() {
        viewModel
            .$text
            .map { Optional($0) }
            .assign(to: \.text, on: textLabel)
            .store(in: &cancellables)

        viewModel
            .$showErrorAlert
            .sink(receiveValue: { [weak self] in
                guard $0 else {
                    return
                }
                self?.showAlert()
            })
            .store(in: &cancellables)
        
        viewModel
            .$isLoading
            .sink(receiveValue: { [weak self] isLoading in
                self?.indicator.isHidden = !isLoading
            })
            .store(in: &cancellables)
    }
    
    func showAlert() {
        let controller = UIAlertController(title: "Error", message: "Error message", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default)
        controller.addAction(action)
        present(controller, animated: true)
    }
}
