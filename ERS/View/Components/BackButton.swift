//
//  ButtonView.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/1/23.
//

import SwiftUI

struct BackButton: View {
    let onPress: () -> Void

    var body: some View {
        Button() {
            onPress()
        } label: {
            HStack() {
                Image(systemName: "arrowshape.backward")
                Text("Menu")
                
            }
        }
        .frame(width: 150)
        .padding(10)
        .background(.black)
        .cornerRadius(10)
        .foregroundColor(.white)
        .shadow(radius: 2, x: -2, y: 2)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BackButton(onPress: {})
        }
    }
}
