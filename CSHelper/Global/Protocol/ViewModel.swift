//
//  ViewModel.swift
//  CSHelper
//
//  Created by 임영준 on 2023/10/31.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag {get set}
    func transform(input: Input) -> Output
}
