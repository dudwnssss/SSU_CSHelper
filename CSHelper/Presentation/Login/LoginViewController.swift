//
//  LogInViewController.swift
//  CSHelper
//
//  Created by 임영준 on 2023/06/16.
//

import UIKit
import Moya

class LoginViewController: BaseViewController{
    
    let emailLabel = UILabel().then{
        $0.text = "Email"
    }
    let pwLabel = UILabel().then{
        $0.text = "Password"
    }
    let noAccountButton = UIButton().then{
        $0.setTitle("아이디가 없으신가요?", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
    let loginButton = UIButton().then{
        $0.setTitle("시작하기", for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 8
        
    }
    let emailTextFeild = UITextField().then{
        $0.borderStyle = .roundedRect
        $0.placeholder = "이메일을 입력해주세요"
    }
    let passwordTextFeild = UITextField().then{
        $0.borderStyle = .roundedRect
        $0.placeholder = "비밀번호를 입력해주세요"
    }
    
    func setNavigationBar(){
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.barTintColor = .white
        title = "로그인"
    }
    
    override func setLayouts(){
        self.view.addSubviews(emailLabel, emailTextFeild, pwLabel, passwordTextFeild, loginButton, noAccountButton)
        
        emailLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(200)
        }
        emailTextFeild.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(emailLabel.snp.bottom).offset(10)
        }
        
        pwLabel.snp.makeConstraints {
            $0.leading.equalTo(emailLabel.snp.leading)
            $0.top.equalTo(emailTextFeild.snp.bottom).offset(60)
        }
        
        passwordTextFeild.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20 )
            $0.top.equalTo(pwLabel.snp.bottom).offset(10)
        }
        
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(passwordTextFeild ).offset(100)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        noAccountButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(10)
        }
    }
    
    override func setProperties() {
        setNavigationBar()
    }
    
    override func bind() {
        loginButton.rx.tap.bind{
            self.login()
        }.disposed(by: disposeBag)
        noAccountButton.rx.tap.bind{
            let vc = SignupViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
    }
    
    func login(){
        let provider = MoyaProvider<AuthService>(plugins: [NetworkLogPlugin()])
        provider.request(.login(email: emailTextFeild.text!, password: passwordTextFeild.text!)){ result in
            switch result {
            case let .success(response):
                let result = try? response.map(Token.self)
                UserDefaultHandler.shared.accessToken = result?.accessToken ?? ""
                RootSwitcher.update(.main)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }

    }
    
    //#if DEBUG
    //import SwiftUI
    //import Moya
    //
    //struct LoginViewController_Previews: PreviewProvider {
    //    static var previews: some View {
    //        let viewController = LoginViewController()
    //        return viewController.getPreview()
    //    }
    //}
    //
    //#endif
}
