import Foundation

// MARK: - Response Models

struct GasPriceResponse: Codable {
    let success: Bool
    let result: GasResult
}

struct GasResult: Codable {
    let state: StatePrice
    let cities: [CityPrice]
}

struct StatePrice: Codable {
    let name: String
    let gasoline: String
    let midGrade: String
    let premium: String
    let diesel: String
}

struct CityPrice: Codable {
    let name: String
    let gasoline: String
    let midGrade: String
    let premium: String
    let diesel: String
}

// MARK: - Fetcher
@MainActor
class GasPriceFetcher: ObservableObject {
    @Published var state: StatePrice?
    @Published var cities: [CityPrice] = []

    func fetchGasPrices(for stateCode: String) async {
        guard let url = URL(string: "https://api.collectapi.com/gasPrice/stateUsaPrice?state=\(stateCode)") else {
            print("❌ Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("T", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            // Print raw JSON string for inspection
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📦 Raw JSON Response:\n\(jsonString)")
            }

            // Decode and update state
            let decoded = try JSONDecoder().decode(GasPriceResponse.self, from: data)
            self.state = decoded.result.state
            self.cities = decoded.result.cities
            print("✅ Successfully decoded gas prices")
        } catch {
            print("❌ Decoding error: \(error)")
        }
    }
}
