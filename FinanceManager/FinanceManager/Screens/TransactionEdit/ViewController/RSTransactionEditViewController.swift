//
//  RSTransactionEditViewController.swift
//  FinanceManager
//
//  Created by Kirill on 22.09.21.
//

import UIKit


class RSTransactionEditViewController: UIViewController, RSTransactionEditViewControllerProtocol, UIScrollViewDelegate {
    
    @IBOutlet weak var headerTitile: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var controllerTitleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleField: RSTextField!
    @IBOutlet weak var changeField: RSTextField!
    @IBOutlet weak var segmentedControl: RSSegmentedControl!
    @IBOutlet weak var noteField: RSTextView!
    
    var textFieldDidEdited: ((String?, String?, String?) -> ())?

    var viewModel: RSTransactionEditViewModelType! {
        didSet {
            viewModel.viewController = self
            viewModel.updateTextFieldsWhenDidEditing()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleField.delegate = self
        changeField.delegate = self
        noteField.delegate = self
        scrollView.delegate = self
                
        subscribeKeyboardNotifications()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        updateView()
    }
    
    func updateView() {
        guard let viewModel = self.viewModel else { return }
        headerTitile.text = viewModel.title
        titleField.text = viewModel.name
        if let value = viewModel.value?.int32Value {
            changeField.text = viewModel.value == 0 ? "" : abs(value).description
        } else {
            changeField.text = ""
        }
        if viewModel.note != nil && viewModel.note?.isEmpty == false {
            noteField.text = viewModel.note
            noteField.textColor = .rsRickBlack
        }
        segmentedControl.changeStateTo(state: viewModel.transactionState)
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
        scrollView.setContentOffset(CGPoint(x: 0, y: -44), animated: true)
    }
    
    @objc func hideKeyboard() {
        if titleField.isFirstResponder {
            titleField.resignFirstResponder()
        }
        if changeField.isFirstResponder {
            changeField.resignFirstResponder()
        }
        if noteField.isFirstResponder {
            noteField.resignFirstResponder()
        }
    }

    // MARK: - Actions for VM Delegate
    @IBAction func backButtonPressed() {
        textFieldDidChange()
        viewModel?.backButtonPressed()
    }
    @IBAction func segmentedControlAction(_ sender: Any) {
        segmentedControl.changeState()
        viewModel?.segmentedControlAction(segmentControlState: segmentedControl.segmentControlState)
        textFieldDidChange()
    }
    
    @IBAction func textFieldDidChange() {
        if noteField.text == noteField.placeholder {
            textFieldDidEdited?(titleField.text, changeField.text, nil)
        } else {
            textFieldDidEdited?(titleField.text, changeField.text, noteField.text)
        }
    }
    
    func goBackToTextField(alert: PostAlert) {
        switch alert {
        case .nilValue:
            changeField.becomeFirstResponder()
        case .nullValue:
            changeField.text = ""
            changeField.becomeFirstResponder()
        case .nameNil:
            titleField.becomeFirstResponder()
        case .tooLongName:
            titleField.text?.removeLast()
            titleField.becomeFirstResponder()
        case .tooLongNote:
            noteField.text?.removeLast()
            noteField.becomeFirstResponder()
        }
    }

}

// MARK: - UITextFieldDelegate
extension RSTransactionEditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
}

// MARK: - UITextViewDelegate
extension RSTransactionEditViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textFieldDidChange()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if let textView = textView as? RSTextView {
            if textView.textColor == textView.placeholderColor {
                textView.text = nil
                textView.textColor = .rsRickBlack
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let textView = textView as? RSTextView {
            if textView.text.isEmpty {
                textView.text = textView.placeholder
                textView.textColor = textView.placeholderColor
            }
        }
    }
}







