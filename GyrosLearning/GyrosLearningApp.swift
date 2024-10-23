import SwiftUI

@main
struct GyrosLearningApp: App {
    @StateObject var gyroViewModel = GyroViewModel(gyroManager: GyroMotionManager()) 
    @StateObject var cameraViewModel = CameraViewModel(cameraManager: CameraManager())
    var body: some Scene {
        WindowGroup {
//            GyroView(viewModel: gyroViewModel)  // Pass the ViewModel to the View
//                .onAppear {
//                    gyroViewModel.startGyros()  // Use ViewModel to start gyros
//                }
//                .onDisappear {
//                    gyroViewModel.stopGyros()   // Use ViewModel to stop gyros
//                }
            
            CameraView(viewModel: cameraViewModel)
        }
    }
}
