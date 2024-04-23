//
//  MockCartNavigationView.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

final class MockCartNavigationView: CartNavigationViewInput {
    
    var isReloadCalled = false
    func reload() {
        isReloadCalled = true
    }
    
    var isConfigureNavigationViewCalled = false
    func configureNavigationView() {
        isConfigureNavigationViewCalled = true
    }
    
    var isConfigureObserverCalled = false
    func configureObserver() {
        isConfigureObserverCalled = true
    }
    
    var isConfigureTapGestureCalled = false
    func configureTapGesture() {
        isConfigureTapGestureCalled = true
    }
}
