//
//  Detail_View.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/18/25.
//



import SwiftUI

struct Detail_View: View {
    var body: some View {
        ZStack {
            Color.teal
                .edgesIgnoringSafeArea(.all)
            Text("Hello world.")
                .foregroundColor(.white)
                .font(.largeTitle)
        }
    }
}

struct Detail_View_Previews: PreviewProvider {
    static var previews: some View {
        Detail_View()
    }
}
