//
//  ProfileView.swift
//  ThaiFoody
//
//  Created by Michael Haslam on 3/16/21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewRouter: ViewRouter

    var body: some View {
        VStack {
            HStack {
                Button(action: {}) {
                    Text("Edit")
                          .foregroundColor(Color("BrandPrimary"))
                }
                Spacer()

            }
            Image(systemName: "camera")
                .resizable()
                .cornerRadius(4)
                .frame(width: 175, height: 175)
                .padding(.top)
            
            HStack{
                Spacer()
                Text("username")
                Spacer()
            }
            .foregroundColor(Color("TextColor").opacity(0.6))
            VStack(alignment: .leading) {
                Text("Bio")
                    .foregroundColor(Color("TextColor").opacity(0.6))
                Text("Bio")
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
    }

}

    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView().environmentObject(ViewRouter())
        }
    }

