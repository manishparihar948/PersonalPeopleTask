//
//  ContentView.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 11.10.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            
            Text("Hello, world!")
                .padding()
                .onAppear {
                    print("User Response ------>")
                    dump(
                       try? StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
                    )
                    
                    print("Single User Response ----->")
                    dump(
                       try? StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self)
                    )
                }
        
        
    }
}

#Preview {
    ContentView()
}
