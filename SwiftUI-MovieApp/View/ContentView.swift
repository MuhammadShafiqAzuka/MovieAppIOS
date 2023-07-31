import SwiftUI

struct ContentView: View {
    
    @StateObject private var repo = Repository()
    
    private func populateMovies() async {
        do {
            try await repo.fetchMovies()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        
        if #available(iOS 15.0, *) {
            NavigationView{
                List(repo.movies){ movie in
                    NavigationLink {
                        MovieDetailView(movie: movie)
                    } label: {
                        CardView(image: movie.poster, title: movie.title)
                    }
                }
                .refreshable {
                    do {
                        try await populateMovies()
                    } catch {
                        print(error)
                    }
                }
                .navigationTitle("MOVIES")
                .navigationBarTitleDisplayMode(.automatic)
            }
            .task {
                do {
                    try await populateMovies()
                } catch {
                    print(error)
                }
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
