//
//  ButtonView.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/1/23.
//

import SwiftUI

struct ButtonView: View {
    
    let text: String

    var body: some View {
        Text(text)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text:"yee")
    }
}
