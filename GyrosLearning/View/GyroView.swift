import SwiftUI
struct GyroView: View {
    @ObservedObject var viewModel: GyroViewModel
        var body: some View {
            VStack {
                ZStack {
                    // Pitch rectangle (red)
                    Rectangle()
                        .stroke(lineWidth: 5)
                        .foregroundColor(.red)
                        .frame(width: 50, height: 50)
                        .rotation3DEffect(
                            .degrees(viewModel.pitch * 180 / .pi),
                            axis: (x: 1, y: 0, z: 0)
                        )

                    // Yaw rectangle (blue)
                    Rectangle()
                        .stroke(lineWidth: 5)
                        .foregroundColor(.blue)
                        .frame(width: 100, height: 100)
                        .rotation3DEffect(
                            .degrees(viewModel.yaw * 180 / .pi),
                            axis: (x: 0, y: 1, z: 0)
                        )

                    // Roll rectangle (green)
                    Rectangle()
                        .stroke(lineWidth: 5)
                        .foregroundColor(.green)
                        .frame(width: 150, height: 150)
                        .rotation3DEffect(
                            .degrees(viewModel.roll * 180 / .pi),
                            axis: (x: 0, y: 0, z: 1)
                        )
                }
                .padding()

                Spacer().frame(height: 20)

                // Lock Gyroscope Button
                Button(action: {
                    viewModel.lockGyroCoordinates()
                    viewModel.resetGyroValues()
                }) {
                    Text("Lock Gyroscope")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer().frame(height: 20)

                Text(viewModel.guidanceText)
                    .font(.title)
                    .foregroundColor(viewModel.isSuccess ? .green : .red)
            }
            .onAppear {
                viewModel.startGyros()
            }
            .onDisappear {
                viewModel.stopGyros()
            }
        }
}

#Preview {
    GyroView(viewModel: GyroViewModel())
}
