import SwiftUI

struct MonoClock: View {
    @State private var currentTime = Time.now
    @State private var quoteText: String = "Loading..."
    @State private var quoteAuthor: String = ""

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 40) {
                GeometryReader { geo in
                    VStack {
                        HStack(spacing: geo.size.width * 0.02) {
                            FlipDigit(digit: currentTime.hourTens)
                            FlipDigit(digit: currentTime.hourOnes)
                            
                            Text(":")
                                .font(.system(size: geo.size.width * 0.08, weight: .bold, design: .monospaced))
                                .foregroundColor(.gray)
                                .padding(.bottom, geo.size.height * 0.02)

                            FlipDigit(digit: currentTime.minuteTens)
                            FlipDigit(digit: currentTime.minuteOnes)
                        }
                        .frame(maxWidth: .infinity, maxHeight: geo.size.height * 0.5)
                        .onReceive(timer) { _ in
                            self.currentTime = Time.now
                        }
                    }
                }
                .frame(height: 300)

                VStack(spacing: 10) {
                    Text("\"\(quoteText)\"")
                        .font(.system(size: 18, weight: .medium, design: .serif))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Text("- \(quoteAuthor)")
                        .font(.system(size: 14, weight: .light, design: .serif))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
        .preferredColorScheme(.dark) // 🔥 FORCE Dark Mode
        .task {
            await fetchQuote()
        }
    }
}





// MARK: - Flip Digit with Basic Animation
struct FlipDigit: View {
    let digit: Int
    @State private var animatedDigit: Int = 0

    var body: some View {
        Text("\(animatedDigit)")
            .font(.system(size: 80, weight: .bold, design: .monospaced))
            .frame(width: 80, height: 120)
            .background(Color.secondary.opacity(0.5))
            .cornerRadius(10)
            .shadow(radius: 10)
            .foregroundStyle(.primary)
            .animation(.easeInOut(duration: 0.3), value: animatedDigit) // < Basic smooth change
            .onAppear {
                animatedDigit = digit
            }
            .onChange(of: digit) {
                animatedDigit = digit
            }
    }
}

// MARK: - Fetch Daily Quote
extension MonoClock {
    func fetchQuote() async {
        guard let url = URL(string: "https://zenquotes.io/api/today") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decoded = try? JSONDecoder().decode([ZenQuote].self, from: data),
               let firstQuote = decoded.first {
                quoteText = firstQuote.q
                quoteAuthor = firstQuote.a
            }
        } catch {
            print("Error fetching quote: \(error.localizedDescription)")
        }
    }
}

// MARK: - API Model
struct ZenQuote: Codable {
    let q: String // Quote text
    let a: String // Author
}

// MARK: - Time helper
struct Time {
    let hourTens, hourOnes, minuteTens, minuteOnes: Int

    static var now: Time {
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
      //  let seconds = calendar.component(.second, from: now)
        
        return Time(
            hourTens: hour / 10,
            hourOnes: hour % 10,
            minuteTens: minute / 10,
            minuteOnes: minute % 10
            
        )
    }
}

#Preview {
    MonoClock()
}
