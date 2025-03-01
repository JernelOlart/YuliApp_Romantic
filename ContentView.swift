import SwiftUI

struct ContentView: View {
    @State private var isEnvelopeOpen = false
    @State private var rotation: Double = 0
    @State private var heartPosition = [CGSize](repeating: .zero, count: 20)
    @State private var confettiPosition = [CGSize](repeating: .zero, count: 30)
    @State private var bubblePosition = [CGSize](repeating: .zero, count: 10)
    
    let currentTime = Date()
    
    var body: some View {
        ZStack {
            backgroundImageView
            emojiVisualEffects
            animatedTimeBasedElements
            envelopeView
            heartAnimation
            confettiAnimation
            bubbleAnimation
            rayOfLightAnimation
            floatingClouds
            glowingParticles
        }
    }
    
    // MARK: - Background Image
    var backgroundImageView: some View {
        Group {
            if isEnvelopeOpen {
                Image("11468979")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 400) // Agrandé el tamaño de la imagen de fondo
                    .offset(y: 100)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    // MARK: - Emoji Visual Effects
    var emojiVisualEffects: some View {
        VStack {
            Spacer()
            Text(emojiText)
                .font(.system(size: 50))
                .foregroundColor(.white)
                .bold()
                .transition(.opacity)
                .animation(.easeInOut(duration: 1.5))
        }
        .padding(.top, 250)
    }
    
    // MARK: - Envelope View
    var envelopeView: some View {
        VStack {
            Image("lc")
                .resizable()
                .frame(width: 180, height: 150)
                .rotationEffect(.degrees(rotation))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.toggleEnvelope()
                    }
                }
                .padding()
                .zIndex(3) // Hacer que lc.png esté encima de otros elementos, siempre clickeable
            
            if isEnvelopeOpen {
                messageView
            }
        }
        .zIndex(2) // Asegura que la vista del sobre esté sobre el fondo
    }
    
    // MARK: - Message View
    var messageView: some View {
        VStack {
            Text(generateMessage())
                .font(.system(size: 18, weight: .bold, design: .rounded)) // Reduje el tamaño del texto a 18
                .foregroundColor(.black) // Texto en negro
                .multilineTextAlignment(.center)
                .frame(width: 320, height: 180)
                .offset(y: -30) // Bajé el texto más
        }
    }
    
    // MARK: - Heart Animation
    var heartAnimation: some View {
        ForEach(0..<heartPosition.count, id: \.self) { index in
            Image(systemName: "heart.fill")
                .resizable()
                .foregroundColor(.red)
                .frame(width: 30, height: 30)
                .offset(heartPosition[index])
                .opacity(Double.random(in: 0.5...1.0))
                .animation(Animation.easeInOut(duration: Double.random(in: 2...5)).repeatForever(autoreverses: true), value: heartPosition[index])
                .onAppear {
                    heartPosition[index] = CGSize(width: CGFloat.random(in: -150...150), height: CGFloat.random(in: -400...400))
                }
        }
    }
    
    // MARK: - Confetti Animation
    var confettiAnimation: some View {
        ForEach(0..<confettiPosition.count, id: \.self) { index in
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(.pink)
                .frame(width: 20, height: 20)
                .offset(confettiPosition[index])
                .opacity(Double.random(in: 0.3...1.0))
                .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: confettiPosition[index])
                .onAppear {
                    confettiPosition[index] = CGSize(width: CGFloat.random(in: -150...150), height: CGFloat.random(in: -500...500))
                }
        }
    }
    
    // MARK: - Emoji Text
    var emojiText: String {
        if currentTime.hour >= 6 && currentTime.hour < 12 {
            return "🐦🌸 Buenos días preciosaaa!!!"
        } else if currentTime.hour >= 12 && currentTime.hour < 18 {
            return "🌞 Buenas tardes preciosaaa!!!"
        } else {
            return "🌙 Buenas noches preciosaaa!!!"
        }
    }
    
    // MARK: - Generate Message
    func generateMessage() -> String {
        return "Ya es \(getDayOfWeek()) y hoy estás más hermosa que ayer 💖\n♡ Como tú, ninguna; ni siquiera las rosas; como tú no hay otra igual.\nEres la razón por la que el sol brilla más, y el cielo sonríe con tus ojos ♡"
    }
    
    // MARK: - Get Day of Week
    func getDayOfWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let dayString = formatter.string(from: currentTime)
        
        switch dayString.lowercased() {
        case "monday":
            return "lunes"
        case "tuesday":
            return "martes"
        case "wednesday":
            return "miércoles"
        case "thursday":
            return "jueves"
        case "friday":
            return "viernes"
        case "saturday":
            return "sábado"
        case "sunday":
            return "domingo"
        default:
            return dayString
        }
    }
    
    // MARK: - Toggle Envelope
    func toggleEnvelope() {
        withAnimation(.easeInOut(duration: 0.5)) {
            isEnvelopeOpen.toggle()
            rotation = isEnvelopeOpen ? 180 : 0
        }
    }
    
    // MARK: - Animated Time Based Elements
    var animatedTimeBasedElements: some View {
        Group {
            if currentTime.hour >= 18 || currentTime.hour < 6 {
                // Night: Moon and Stars
                moonAndStars
            } else if currentTime.hour >= 6 && currentTime.hour < 12 {
                // Morning: Birds
                birdsAnimation
            }
        }
    }
    
    // MARK: - Moon and Stars Animation (Night)
    var moonAndStars: some View {
        ZStack {
            Image(systemName: "moon.fill")
                .resizable()
                .foregroundColor(.yellow)
                .frame(width: 50, height: 50)
                .offset(x: -150, y: -150)
                .opacity(0.5)
                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: currentTime)
            
            ForEach(0..<10, id: \.self) { index in
                Image(systemName: "star.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
                    .offset(x: CGFloat.random(in: -200...200), y: CGFloat.random(in: -300...300))
                    .opacity(Double.random(in: 0.5...1.0))
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: currentTime)
            }
        }
    }
    
    // MARK: - Birds Animation (Morning)
    var birdsAnimation: some View {
        HStack {
            ForEach(0..<5, id: \.self) { _ in
                Image(systemName: "bird")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .offset(x: CGFloat.random(in: -200...200), y: CGFloat.random(in: -200...200))
                    .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: currentTime)
            }
        }
    }
    
    // MARK: - Bubble Animation
    var bubbleAnimation: some View {
        ForEach(0..<bubblePosition.count, id: \.self) { index in
            Circle()
                .fill(Color.blue.opacity(0.5))
                .frame(width: 30, height: 30)
                .offset(bubblePosition[index])
                .animation(Animation.easeInOut(duration: Double.random(in: 4...6)).repeatForever(autoreverses: true), value: bubblePosition[index])
                .onAppear {
                    bubblePosition[index] = CGSize(width: CGFloat.random(in: -150...150), height: CGFloat.random(in: -500...500))
                }
        }
    }
    
    // MARK: - Ray of Light Animation
    var rayOfLightAnimation: some View {
        ZStack {
            Image(systemName: "sun.max.fill")
                .resizable()
                .foregroundColor(.yellow)
                .frame(width: 100, height: 100)
                .opacity(0.2)
                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: currentTime)
            
            Image(systemName: "sunrise.fill")
                .resizable()
                .foregroundColor(.orange)
                .frame(width: 50, height: 50)
                .offset(x: 0, y: -250)
                .opacity(0.3)
                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: currentTime)
        }
    }
    
    // MARK: - Floating Clouds
    var floatingClouds: some View {
        HStack {
            Image(systemName: "cloud.fill")
                .resizable()
                .frame(width: 100, height: 60)
                .foregroundColor(.white)
                .offset(x: CGFloat.random(in: -250...250), y: CGFloat.random(in: -100...100))
                .opacity(0.6)
                .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true), value: currentTime)
        }
    }
    
    // MARK: - Glowing Particles
    var glowingParticles: some View {
        ForEach(0..<5, id: \.self) { _ in
            Circle()
                .fill(Color.white.opacity(0.8))
                .frame(width: 10, height: 10)
                .offset(x: CGFloat.random(in: -200...200), y: CGFloat.random(in: -400...400))
                .opacity(0.7)
                .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: currentTime)
        }
    }
}

extension Date {
    var hour: Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: self)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
