//
//  StoryAuthorProfileView.swift
//  ThaiFoody
//
//  Created by Michael Haslam on 5/12/21.
//

import SwiftUI

struct StoryAuthorProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var profileImage: UIImage = UIImage(named: "addCameraImg")!
    @State private var username = "Username"
    @State private var bio = "Bio"
    
    let storyUserID: String
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Text("X")
                        .foregroundColor(Color("BrandPrimary"))
                }
                Spacer()
            }
            Image(uiImage: profileImage)
                .resizable()
                .cornerRadius(4)
                .frame(width: 175, height: 175)
                .padding(.top)
            
            HStack {
                Spacer()
                Text(username)
                Spacer()
            }
            .foregroundColor(Color("TextColor").opacity(0.6))
            VStack(alignment: .leading) {
                Text("Bio")
                    .foregroundColor(Color("TextColor").opacity(0.6))
                Text(bio)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, alignment: .topLeading)
                    .font(.system(size: 17))
                    .padding()
                    .foregroundColor(Color("TextColor").opacity(0.7))
                    .overlay(RoundedRectangle(cornerRadius: 6)
                                .stroke(Color("TextColor").opacity(0.5), lineWidth: 1))
            }

            Spacer()
        }
        .padding()
        .onAppear {
            getAuthorProfile()
        }
    }
    private func getAuthorProfile(){
        //code here
    }
}

struct StoryAuthorProfileView_Previews: PreviewProvider {
    static var previews: some View {
        StoryAuthorProfileView(storyUserID: "123")
    }
}
