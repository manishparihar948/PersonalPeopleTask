//
//  DetailView.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 12.10.23.
//

import SwiftUI

struct DetailView: View {
    @State private var userInfo: UserDetailResponse?
    var body: some View {
        ZStack {
            background
            
            ScrollView {
                VStack(alignment:.leading, spacing:18) {
                    
                    avatar
                    
                    Group {
                        general
                        link
                    }
                    .padding(.horizontal,8)
                    .padding(.vertical, 18)
                    .background(Theme.detailBackground,
                                in: RoundedRectangle(cornerRadius: 16,
                                                     style: .continuous))
                }
                .padding()
            }
        }
        .navigationTitle("Details") // If not able to see then add Navigation Stack in Preview
        .onAppear {
            do{
                userInfo = try StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self)
            }catch {
                // TODO: Handle any errors
                print(error)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView()
    }
}

private extension DetailView {
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges:.top)
    }
    
    @ViewBuilder
    var avatar: some View {
        if let avatarAbsoluteString = userInfo?.data.avatar,
           let avatarUrl = URL(string: avatarAbsoluteString) {
            
            AsyncImage(url:avatarUrl) {image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height:250)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
    
    @ViewBuilder
    var link: some View {
        
        if let supportAbsoluteString = userInfo?.support.url,
           let supportUrl = URL(string: supportAbsoluteString),
           let supportText = userInfo?.support.text {
            
            Link(destination: supportUrl) {
                VStack(alignment:.leading, spacing: 8){
                    
                    Text(supportText)
                        .foregroundStyle(Theme.text)
                        .font(
                            .system(.body, design: .rounded)
                            .weight(.semibold)
                        )
                    Text(supportAbsoluteString)
                }
                Spacer()
                
                HStack {
                    Symbols
                        .link
                        .font(.system(.title3, design: .rounded))
                }
            }
        }
    }
}


private extension DetailView {
    
    var general: some View {
        VStack(alignment:.leading, spacing:8) {
            PillView(id: userInfo?.data.id ?? 0)
            
            Group {
                firstname
                lastname
                email
            }
            .foregroundStyle(Theme.text)
        }
    }
    
    // ViewBuilder -  we use because complier does not know what view we are trying to return, So it allow to return one or more view to return
    @ViewBuilder
    var firstname: some View {
        Text("First Name")
            .font(
                .system(.subheadline, design: .rounded)
                .weight(.semibold)
            )
        
        Text(userInfo?.data.firstName ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
        
        Divider()
    }
    
    @ViewBuilder
    var lastname: some View {
        Text("Last Name")
            .font(
                .system(.subheadline, design: .rounded)
                .weight(.semibold)
            )
        
        Text(userInfo?.data.lastName ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
        
        Divider()
    }
    
    @ViewBuilder
    var email: some View {
        Text("Email")
            .font(
                .system(.subheadline, design: .rounded)
                .weight(.semibold)
            )
        
        Text(userInfo?.data.email ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
    }
}
