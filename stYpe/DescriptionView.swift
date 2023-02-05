//
//  DescriptionView.swift
//  stYpe
//
//  Created by Олег Коваленко on 01.02.2023.
//

import SwiftUI

struct DescriptionView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack{
                Text("123123123")
            }
            .frame(height: 500)
            .background(.black)
        }
    }
    
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView()
    }
}
