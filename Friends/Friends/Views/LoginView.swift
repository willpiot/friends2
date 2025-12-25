//
//  LoginView.swift
//  Friends
//
//  Created on 2025-12-25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var showingEmailLogin = false
    @State private var showingPhoneLogin = false
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var age = "25"
    @State private var selectedGender = User.Gender.other
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(.pink.gradient)
                    
                    Text("Create Your Account")
                        .font(.title)
                        .bold()
                    
                    Text("Choose how you'd like to sign in")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 40)
                
                // Social Login Buttons
                VStack(spacing: 12) {
                    LoginButton(icon: "applelogo", text: "Continue with Apple", color: .black) {
                        showingEmailLogin = true
                    }
                    
                    LoginButton(icon: "g.circle.fill", text: "Continue with Google", color: .red) {
                        showingEmailLogin = true
                    }
                    
                    LoginButton(icon: "x.circle.fill", text: "Continue with X", color: .black) {
                        showingEmailLogin = true
                    }
                    
                    LoginButton(icon: "envelope.fill", text: "Continue with Email", color: .blue) {
                        showingEmailLogin = true
                    }
                    
                    LoginButton(icon: "phone.fill", text: "Continue with Phone", color: .green) {
                        showingPhoneLogin = true
                    }
                }
                .padding(.horizontal)
                
                if showingEmailLogin || showingPhoneLogin {
                    Divider()
                        .padding(.vertical)
                    
                    // User Info Form
                    VStack(spacing: 16) {
                        Text("Tell us about yourself")
                            .font(.headline)
                        
                        TextField("Full Name", text: $name)
                            .textFieldStyle(.roundedBorder)
                        
                        HStack {
                            TextField("Age", text: $age)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                            
                            Picker("Gender", selection: $selectedGender) {
                                ForEach(User.Gender.allCases, id: \.self) { gender in
                                    Text(gender.rawValue).tag(gender)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        if showingEmailLogin {
                            TextField("Email", text: $email)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                        }
                        
                        if showingPhoneLogin {
                            TextField("Phone Number", text: $phone)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.phonePad)
                        }
                        
                        Button(action: {
                            createAccount()
                        }) {
                            Text("Create Account")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.pink)
                                .foregroundStyle(.white)
                                .cornerRadius(12)
                        }
                        .disabled(name.isEmpty || age.isEmpty)
                    }
                    .padding(.horizontal)
                }
                
                Spacer(minLength: 40)
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
    
    private func createAccount() {
        let userAge = Int(age) ?? 25
        dataManager.createUser(
            name: name,
            age: userAge,
            gender: selectedGender,
            email: showingEmailLogin ? email : nil,
            phone: showingPhoneLogin ? phone : nil
        )
    }
}

struct LoginButton: View {
    let icon: String
    let text: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                Text(text)
                    .font(.body)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(color.opacity(0.1))
            .foregroundStyle(color)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(color.opacity(0.3), lineWidth: 1)
            )
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(DataManager())
}
