//
//  RSWalletEditViewController.swift
//  FinanceManager
//
//  Created by Kirill on 22.09.21.
//

import UIKit


class RSWalletEditViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var themeIndex: UIImageView!
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var viewModel: RSWalletEditViewModelTypeProtocol? {
        didSet {
            viewModel?.viewController = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        subscribeKeyboardNotifications()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textFieldShouldReturn)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }

    // MARK: - Actions for VM Delegate
    @IBAction func deleteButtonPressed() {
        viewModel?.deleteButtonPressed()
    }
    
    @IBAction func backButtonPressed() {
        viewModel?.backButtonPressed()
    }
    
    @IBAction func colorThemeButtonPressed() {
        viewModel?.colorThemeButtonPressed()
    }
    
    @IBAction func currencyButtonPressed() {
        viewModel?.currencyButtonPressed()
    }
    
    func subscribeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardRect = keyboardValue.cgRectValue
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardRect.size.height - view.safeAreaInsets.bottom + 10, right: 0)
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }

}

// MARK: - RSWalletEditViewControllerProtocol
extension RSWalletEditViewController: RSWalletEditViewControllerProtocol{
    func updateView() {
        guard let viewModel = self.viewModel else { return }
        titleLabel.text = viewModel.titleLabel
        currencyButton.setTitle(viewModel.currencyLabel, for: .normal)
        textField.text = viewModel.walletName
        deleteButton.isHidden = viewModel.deleteButtonIsHidden
        themeIndex.image =  RSThemeImageViews[Int(viewModel.themeIndex)]
    }
    
    func textFieldBecomeFirstResponder() {
        textField.becomeFirstResponder()
    }
}

// MARK: - UITextFieldDelegate
extension RSWalletEditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return false
    }

    @IBAction func textFieldDidChange(_ sender: Any) {
        guard let title = textField.text else { return }
        viewModel?.textFieldDidChange(title: title)
    }
}

