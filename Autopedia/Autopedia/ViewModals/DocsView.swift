import SwiftUI

struct DocsView: View {

    // MARK: - Veri Modeli
    struct DummyData: Codable {
        let data: [Dummy]
    }

    struct Dummy: Codable, Identifiable {
        let id = UUID()
        let title: String
        let author: String
        let genre: String
        let content: String
    }

    @StateObject private var docsModel = DocsModel()

    var body: some View {
        TopNavBar(title: "Info")
        NavigationView {
            
            LazyVStack {
                ScrollView{
                    if let docs = docsModel.result?.data {
                        ForEach(docs) { doc in
                              NavigationLink {
                                  
                                  VStack(alignment: .leading, spacing: 10) {
                                      Text(doc.author)
                                      Text(doc.genre)
                                      Text(doc.content)
                                  }
                                  .padding()
                                  .navigationTitle(doc.title)
                                  .navigationBarTitleDisplayMode(.inline)
                              } label: {
                                  
                                  Text(doc.title)
                                      .padding()
                                      .frame(maxWidth: .infinity, alignment: .leading)
                                      .background(Color.gray.opacity(0.1))
                                      .cornerRadius(8)
                              }
                              .padding(.horizontal)
                          }
                    } else {
                        Text("Loading...")
                    }
                }
                .task {
                    if docsModel.result == nil {
                        await docsModel.fetchData()
                    }
                }
                }
        }
    }

    // MARK: - API ViewModel
    @MainActor
    class DocsModel: ViewModel<DummyData> {
        init() {
            super.init(endpoint: "https://fakerapi.it/api/v2/texts?_quantity=32&_characters=500", type: DummyData.self)
        }
    }
}

#Preview {
    DocsView()
}
