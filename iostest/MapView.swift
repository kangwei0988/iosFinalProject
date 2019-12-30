//
//  MapView.swift
//  iostest
//
//  Created by User21 on 2019/12/29.
//  Copyright © 2019 kang. All rights reserved.
//

import SwiftUI
import MapKit
import Alamofire


struct MapView : UIViewRepresentable {
    @EnvironmentObject var location : LocationData//useful?
    typealias UIViewType = MKMapView
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        return MKMapView(frame: .zero)//return view
    }
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        let mylocation = location.location
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)// set 地圖範圍
        let region = MKCoordinateRegion(center: mylocation, span: span)
        uiView.setRegion(region, animated: true)
        uiView.removeAnnotations(uiView.annotations)//clear all pin
        
        let annotation = MKPointAnnotation()
        uiView.removeAnnotation(annotation)
        annotation.coordinate = mylocation
        annotation.title = "對方的位置"
        annotation.subtitle = ""
        uiView.addAnnotation(annotation)//add pin
    }
}
struct MapView_Preview: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
