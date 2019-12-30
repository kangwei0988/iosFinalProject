//
//  MotherView.swift
//  iostest
//
//  Created by User21 on 2019/12/28.
//  Copyright © 2019 kang. All rights reserved.
//

import SwiftUI
struct MotherView: View {
    @ObservedObject var logged = loginState()

    var body: some View {
        VStack{
            if logged.state == true{
                MainView().environmentObject(logged)
            }
            else{
                loginPage().environmentObject(logged)
            }
        }
    }
}


struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView()
    }
}
