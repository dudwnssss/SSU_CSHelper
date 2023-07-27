//
//  LogInViewController.swift
//  CSHelper
//
//  Created by 임영준 on 2023/06/16.
//

import UIKit

class SignupViewController: BaseViewController{
    
    let nicknameLabel = UILabel().then{
        $0.text = "Nickname"
    }
    let emailLabel = UILabel().then{
        $0.text = "Email"
    }
    let pwLabel = UILabel().then{
        $0.text = "Password"
    }
    
    let nicknameTextFeild = UITextField().then{
        $0.placeholder = "이름을 입력해주세요"
    }
    let emailTextFeild = UITextField().then{
        $0.placeholder = "이메일을 입력해주세요"
    }
    let passwordTextFeild = UITextField().then{
        $0.placeholder = "비밀번호를 입력해주세요"
    }

    let signupButton = UIButton().then{
        $0.setTitle("회원가입", for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 8

    }
    
    func setNavigationBar(){
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.title = "회원가입"
    }
    
    override func setLayouts(){
        self.view.addSubviews(nicknameLabel, nicknameTextFeild, emailLabel, emailTextFeild, pwLabel, passwordTextFeild, signupButton)
        
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(200)
        }
        
        nicknameTextFeild.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel.snp.leading)
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(10)
        }
        
        emailLabel.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel.snp.leading)
            $0.top.equalTo(nicknameTextFeild.snp.bottom).offset(30)
        }
        emailTextFeild.snp.makeConstraints {
            $0.leading.equalTo(emailLabel.snp.leading)
            $0.top.equalTo(emailLabel.snp.bottom).offset(10)
        }
        
        pwLabel.snp.makeConstraints {
            $0.leading.equalTo(emailLabel.snp.leading)
            $0.top.equalTo(emailTextFeild.snp.bottom).offset(30)
        }
        
        passwordTextFeild.snp.makeConstraints {
            $0.leading.equalTo(pwLabel.snp.leading)
            $0.top.equalTo(pwLabel.snp.bottom).offset(10)
        }
        
        signupButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(passwordTextFeild ).offset(100)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    override func setProperties() {
        setNavigationBar()
    }
    
    override func bind() {
        signupButton.rx.tap.bind{
            self.signup()
        }
    }
    
    func signup(){
        let provider = MoyaProvider<AuthService>(plugins: [NetworkLogPlugin()])
        provider.request(.signup(email: emailTextFeild.text!, name: nicknameTextFeild.text!, password: passwordTextFeild.text!)){ result in
            switch result {
            case let .success(response):
                self.navigationController?.popViewController(animated: true)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

#if DEBUG
import SwiftUI
import Moya

struct SignupViewController_Previews: PreviewProvider {
    static var previews: some View {
        let viewController = SignupViewController()
        return viewController.getPreview()
    }
}

#endif
