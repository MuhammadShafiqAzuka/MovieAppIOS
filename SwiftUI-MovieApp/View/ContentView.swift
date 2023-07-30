import SwiftUI

struct ContentView: View {
    
    @StateObject private var store = Store()
    
    private func populateMovies() async {
        do {
            try await store.fetchMovies()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        
        if #available(iOS 15.0, *) {
            NavigationView{
                List(store.movies){ movie in
                    NavigationLink {
                        MovieDetailView(movie: movie)
                    } label: {
                        HStack {
                            AsyncImage(url: movie.poster) { image in
                                image.resizable()
                                    .frame(width: 75, height: 75)
                            } placeholder: {
                                ProgressView()
                            }
                            Text(movie.title)
                        }
                    }
                    
                }
                .refreshable {
                    await populateMovies()
                }
                .navigationTitle("MOVIES")
                .navigationBarTitleDisplayMode(.automatic)
            }.task {
                await populateMovies()
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
