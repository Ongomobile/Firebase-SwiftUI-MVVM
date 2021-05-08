//
//  AuthenticationService.swift
//  Firebase-SwiftUI-MVVM
//
//  Created by Michael Haslam on 5/7/21.
//

import Foundation

import Firebase

class AuthenticationService: ObservableObject {
  @Published var user: User?
  private var authenticationStateHandler: AuthStateDidChangeListenerHandle?

  static let instance = AuthenticationService()
  init() {
    addListeners()
  }

  static func signIn() {
    if Auth.auth().currentUser == nil {
      Auth.auth().signInAnonymously()
    }
  }

  private func addListeners() {
    if let handle = authenticationStateHandler {
      Auth.auth().removeStateDidChangeListener(handle)
    }

    authenticationStateHandler = Auth.auth()
      .addStateDidChangeListener { _, user in
        self.user = user
      }
  }
}

