//
//  EventRow.swift
//  iostest
//
//  Created by User21 on 2019/12/25.
//  Copyright © 2019 kang. All rights reserved.
//

import SwiftUI

struct EventRow: View {
    var event : Event
    var body: some View {
        VStack{
            HStack{
                Text("時間:        ")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Spacer()
                Text("\(event.getOnTime)")
                    .font(.callout)
                    .fontWeight(.black)
                    .foregroundColor(Color.yellow)
                Spacer()
            }
            HStack{
                Text("上車地點：")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Text("\(event.post_location)")
                    .font(.callout)
                    .fontWeight(.black)
                    .foregroundColor(Color.red)
                Spacer()
            }
            HStack{
                Text("前往：          ")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Text("\(event.post_goto)")
                    .font(.callout)
                    .fontWeight(.black)
                    .foregroundColor(Color.blue)
                Spacer()
            }
        }
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        EventRow(event: Event(id: "5df52c8574a9ed09248cdf9f", getOnTime: "2019-12-26T05:34:00",
                              target_id: "df108810590bfb442faa46f",
                              post_location: "基隆市立圖書館",
                              post_goto: "基隆海事",
                              post_notice: "webpush test",
                              sender_name: "test"))
    }
}
