//
//  ContentView.swift
//  Notch Sim
//
//  Created by MBP_A1990 on 2021/10/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                Image("topleft")
                Spacer()
                Image("notch")
                Spacer()
                Image("topright")
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.clear)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
