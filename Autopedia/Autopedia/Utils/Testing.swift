import SwiftUI

struct Testing: View {
    @StateObject private var fetcher = GasPriceFetcher()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // MARK: - Statewide Average
            if let state = fetcher.state {
                VStack(alignment: .leading) {
                    Text("State: \(state.name)").font(.title2.bold())
                    Text("Regular: \(state.gasoline)")
                    Text("MidGrade: \(state.midGrade)")
                    Text("Premium: \(state.premium)")
                    Text("Diesel: \(state.diesel)")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }

            // MARK: - Cities
            List(fetcher.cities, id: \.name) { city in
                VStack(alignment: .leading) {
                    Text(city.name).font(.headline)
                    Text("Regular: \(city.gasoline)")
                    Text("MidGrade: \(city.midGrade)")
                    Text("Premium: \(city.premium)")
                    Text("Diesel: \(city.diesel)")
                }
                .padding(.vertical, 4)
            }
        }
        .padding()
        .task {
            await fetcher.fetchGasPrices(for: "WA") // Washington i guess
        }
    }
}


