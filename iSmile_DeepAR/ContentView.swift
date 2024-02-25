//
//  ContentView.swift
//  iSmile_DeepAR
//
//  Created by Marco Visentin on 1/26/24.
//

import SwiftUI
import DeepAR

struct ContentView: View {
    @ObservedObject var arViewModel = DeepARViewModel()
    
    var body: some View {
        ZStack {
            DeepARViewContainer(arViewModel: arViewModel)
                        .edgesIgnoringSafeArea(.all)
            if !arViewModel.filterApplier.isFilterOn {
                AnyView(smileStatusView(arViewModel: arViewModel))
            } else {
                AnyView(imageLayout())
            }
        }
    }
}

@MainActor
func smileStatusView(arViewModel: DeepARViewModel) -> some View {
        VStack {
            Text(arViewModel.smileChecker.isSmiling ? "Smiling 😄" : "Not Smiling 😐")
                .padding()
                .foregroundColor(arViewModel.smileChecker.isSmiling ? .green : .red)
                .background(RoundedRectangle(cornerRadius: 25).fill(.regularMaterial))
            Spacer()
        }
    }

func imageLayout() -> some View {
    ZStack {
        VStack {
            HStack {
                Image("ray_ban_qr") // Top left image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.top, 60) // Add 60 points padding from the top
                    .padding(.leading, 20) // Add 20 points padding from the left
                Spacer()
            }
            Spacer()
        }

        VStack {
            Spacer()
            HStack {
                Spacer()
                Image("ray_ban_logo") // Bottom right image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(20) // Keep the uniform padding for the bottom right image
            }
        }
    }
    .edgesIgnoringSafeArea(.all) // Ensures the view uses the full screen, ignoring safe area
}


struct DeepARViewContainer: UIViewRepresentable {
    var arViewModel: DeepARViewModel

    func makeUIView(context: Context) -> UIView {
        arViewModel.startSessionDelegate()
        return arViewModel.arView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the view if needed
    }
}


struct DeepARModel {
    // Your DeepAR logic here
    var deepAR: DeepAR!
    private var cameraController: CameraController!
    var arView: UIView!
    var happiness: Float = 0

    init() {
        // Initialize and configure DeepARView
        deepAR = DeepAR()
        deepAR.setLicenseKey("6797f5805a10457d7a1895ce68160718325190e60cc70f2c8629bfd811f416e6064a49ae88823260")
        cameraController = CameraController()
        cameraController.deepAR = deepAR
        arView = deepAR.createARView(withFrame: UIScreen.main.bounds)
        cameraController.startCamera()
        deepAR.switchEffect(withSlot: "face", path: Bundle.main.path(forResource: "InvisibleEmotions", ofType: "deepar"))
    }
    
    mutating func update(multiFaceData: MultiFaceData) -> Void {
        self.happiness = Float(multiFaceData.faceData.0.emotions.1)
        }
    }


class DeepARViewModel: UIViewController, ObservableObject {
    @Published private var model : DeepARModel = DeepARModel()
    var smileChecker: SmileChecker = SmileChecker()
    var filterApplier: FilterApplier = FilterApplier()
    var smileTreshold: Float = 0.7
    
    var arView : UIView {
        model.arView
    }
    
    func startSessionDelegate() {
        model.deepAR.delegate = self
    }
    
    }
    

extension DeepARViewModel: DeepARDelegate {
    
    func faceTracked(_ faceData: MultiFaceData) {
        model.update(multiFaceData: faceData)
        smileChecker.isSmiling = model.happiness > smileTreshold
            if smileChecker.success && !filterApplier.isFilterOn {
                smileChecker.success = false
                filterApplier.applyFilter(to: model.deepAR) // it makes isFilteron = true
            }
            if !smileChecker.success && !filterApplier.isFilterOn && !smileChecker.isDetectionActive {
                smileChecker.isDetectionActive = true
        }
        }
    
}
    

#Preview {
    ContentView()
}


// TODO:
// 1. app stop workin after 3 mins if on free lience
// 2. Slow opening
// 3. why when of filters stop tracking face + when no face says is smiling 
