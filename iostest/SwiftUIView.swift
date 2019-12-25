//
//  SwiftUIView.swift
//  iostest
//
//  Created by User21 on 2019/12/11.
//  Copyright © 2019 kang. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View{
    var body: some View {
        getMatched{ (data) in
            ForEach(data,id:\.self){ (index) in
                EventRow(event: index)
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
