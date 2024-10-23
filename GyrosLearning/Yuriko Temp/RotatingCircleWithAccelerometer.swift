import SwiftUI
struct PitchSensorView: View {
    @Binding var pitch: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Outer circle
                Circle()
                    .stroke(Color.red, lineWidth: 3)
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.8)
                
                // Inner rotating ellipse
                Ellipse()
                    .fill(Color.red.opacity(0.3))
                    .frame(width: geometry.size.width * 0.6, height: geometry.size.width * 0.4)
                    .rotationEffect(Angle(degrees: pitch * 3.6)) // Assuming pitch range is 0-100
                
                // Indicator dot
                Circle()
                    .fill(Color.green)
                    .frame(width: 10, height: 10)
                    .offset(y: -geometry.size.width * 0.4 - 10)
            }
            .frame(width: geometry.size.width, height: geometry.size.width)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
