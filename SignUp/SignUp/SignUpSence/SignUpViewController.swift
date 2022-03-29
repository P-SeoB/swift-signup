//
//  SignUpViewController.swift
//  SignUp
//
//  Created by 박진섭 on 2022/03/28.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    private let stackView = UIStackView(frame: .zero)
    private let nextButton = SignUpNextButton(frame: .zero)
    private var IDInputView:SignUpInputViewable?
    private var passwordInputView:SignUpInputViewable?
    private var passwordRecheckInputView:SignUpInputViewable?
    private var nameInputView:SignUpInputViewable?
    
    private var inputViewCreator:SignUpInputViewCreator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSignUpView()
        
    }

    private func configureSignUpView() {
        setTitle()
        configureNextButton()
        configureStackView()
    }
    
    //StackView
    private func configureStackView() {
        let constant:CGFloat = 32.0
        let inputViewComponents = configureInputViewComponents()
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        inputViewComponents.forEach{ inputViewable in
            guard let view = inputViewable as? SignUpInputView else { return }
            stackView.addArrangedSubview(view)
        }
        
        self.view.addSubview(stackView)
    
        stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: constant).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -constant).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.nextButton.topAnchor,constant: -constant).isActive = true
        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: constant / 2).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    //title
    private func setTitle() {
        let label = UILabel()
        label.text = "회원가입"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .blue
        self.navigationItem.titleView = label
    }
    
    //inputViewComponent
    private func configureInputViewComponents() -> [SignUpInputViewable?]{
        let id:(label:String,placeHolder:String) = (label:"아이디",placeHolder:"영문 대/소문자, 숫자, 특수기호(_,-) 5~20자")
        let password:(label:String,placeHolder:String) = (label:"비밀번호",placeHolder:"영문 대/소문자, 숫자, 특수문자(!@#$% 8~16자")
        let passwordRecheck:(label:String,placeHolder:String) = (label:"비밀번호 재확인",placeHolder:"")
        let name:(label:String,placeHolder:String) = (label:"이름",placeHolder:"")
        
        inputViewCreator(creator: SignUpInputViewFactory())
        guard let factory = inputViewCreator else { return [] }
        
        IDInputView = factory.makeSignUpViewComponent(labelText: id.label, placeHolder: id.placeHolder)
        passwordInputView = factory.makeSignUpViewComponent(labelText: password.label, placeHolder: password.placeHolder)
        passwordRecheckInputView = factory.makeSignUpViewComponent(labelText: passwordRecheck.label, placeHolder: password.placeHolder)
        nameInputView = factory.makeSignUpViewComponent(labelText: name.label, placeHolder: name.placeHolder)
        
        return [IDInputView,passwordInputView,passwordRecheckInputView,nameInputView]
    }
    
    //button
    private func configureNextButton() {
        let bottomInset:CGFloat = 300.0
        self.view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -bottomInset).isActive = true
    }
    
    //injection creator
    private func inputViewCreator(creator:SignUpInputViewCreator) {
        self.inputViewCreator = creator
    }
}

