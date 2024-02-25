//
//  playground.swift
//  iSmile_DeepAR
//
//  Created by Marco Visentin on 1/27/24.
//

import Foundation


//func addFilterAfterDelay() {
//        // Dispatch after 2 seconds
//    print("Here")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            // Ensure DeepAR is available and initialized
//            if let filePath = Bundle.main.path(forResource: "viking_helmet", ofType: "deepar") {
//                // Use the file from the path
//                self.deepAR.switchEffect(withSlot: "effect", path: filePath)
//            } else {
//                print("File not found in bundle")
//            }
//            print("Effect should be shown")
//        }
//    }
//

//
//  ContentView.swift
//  iSmile_DeepAR
//
//  Created by Marco Visentin on 1/26/24.
//

//import SwiftUI
//import DeepAR
//
//struct ContentView: View {
//    @ObservedObject var arViewModel = DeepARViewModel()
//    
//    var body: some View {
//        DeepARViewContainer(arViewModel: arViewModel)
//                    .edgesIgnoringSafeArea(.all)
//    }
//}
//
//struct DeepARViewContainer: UIViewRepresentable {
//    var arViewModel: DeepARViewModel
//
//    func makeUIView(context: Context) -> UIView {
//        arViewModel.startSessionDelegate()
//        return arViewModel.arView
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {
//        // Update the view if needed
//    }
//}
//
//@MainActor
//struct DeepARModel {
//    // Your DeepAR logic here
//    var deepAR: DeepAR!
//    private var cameraController: CameraController!
//    var arView: UIView!
//    //var faceTrackingInitParameters: FaceTrackingInitParameters
//   // var lefMouthLandmark: [Float]
//    //var rightMouthLandmark: [Float]
//    var landmarks: [Float]?
//
//    init() {
//        // Initialize and configure DeepARView
//        deepAR = DeepAR()
//        deepAR.setLicenseKey("6797f5805a10457d7a1895ce68160718325190e60cc70f2c8629bfd811f416e6064a49ae88823260")
//        //faceTrackingInitParameters = FaceTrackingInitParameters(initializeEngineWithFaceTracking: true, initializeFaceTrackingSynchronously: true)
//        //deepAR.setFaceTrackingInitParameters(faceTrackingInitParameters)
//        
//        cameraController = CameraController()
//        cameraController.deepAR = deepAR
//        arView = deepAR.createARView(withFrame: UIScreen.main.bounds)
//        cameraController.startCamera()
//        deepAR.switchEffect(withSlot: "face", path: Bundle.main.path(forResource: "emptyeffect", ofType: "deepar"))
//        print("Is face visible: ", deepAR.faceVisible)
//    }
//    
//    mutating func update(multiFaceData: MultiFaceData) -> Void {
//        //self.lefMouthLandmark = tupleToArray(multiFaceData.faceData.0.landmarks)
//        //self.rightMouthLandmark = tupleToArray(multiFaceData.faceData.0.landmarks)
//        if let landmarks = self.landmarks {
//            let differences = zip(tupleToArray(multiFaceData.faceData.0.landmarks), landmarks).map {$0 - $1}.map{abs($0)}
//            let top10 = differences.enumerated()
//                            .sorted(by: { $0.element > $1.element })
//                            .prefix(10)
//            print(top10)
//        }
//        self.landmarks = tupleToArray(multiFaceData.faceData.0.landmarks)
//        }
//    
//    func tupleToArray(_ tuple:  (Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float, Float)
//) -> [Float] {
//        return [
//            tuple.0, tuple.1, tuple.2, tuple.3, tuple.4, tuple.5, tuple.6, tuple.7, tuple.8, tuple.9,
//            tuple.10, tuple.11, tuple.12, tuple.13, tuple.14, tuple.15, tuple.16, tuple.17, tuple.18, tuple.19,
//            tuple.20, tuple.21, tuple.22, tuple.23, tuple.24, tuple.25, tuple.26, tuple.27, tuple.28, tuple.29,
//            tuple.30, tuple.31, tuple.32, tuple.33, tuple.34, tuple.35, tuple.36, tuple.37, tuple.38, tuple.39,
//            tuple.40, tuple.41, tuple.42, tuple.43, tuple.44, tuple.45, tuple.46, tuple.47, tuple.48, tuple.49,
//            tuple.50, tuple.51, tuple.52, tuple.53, tuple.54, tuple.55, tuple.56, tuple.57, tuple.58, tuple.59,
//            tuple.60, tuple.61, tuple.62, tuple.63, tuple.64, tuple.65, tuple.66, tuple.67
//        ]
//    }
//    
//    }
//
//
//class DeepARViewModel: UIViewController, ObservableObject, DeepARDelegate {
//    @Published private var model : DeepARModel = DeepARModel()
//    var snapshot = true
//    
//    var arView : UIView {
//        model.arView
//    }
//    
//    func startSessionDelegate() {
//        print("Session delegate on")
//        model.deepAR.delegate = self
//        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { [weak self] _ in
//            self?.snapshot = true
//        }
//    }
//
//    func faceTracked(_ faceData: MultiFaceData) {
//            print("In the face Tracked")
//        if snapshot {
//            model.update(multiFaceData: faceData)
//            snapshot = false
//        }
//        
//        }
//}
//    
//
//#Preview {
//    ContentView()
//}


