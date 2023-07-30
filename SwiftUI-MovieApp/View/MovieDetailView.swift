import SwiftUI

struct MovieDetailView: View {
    
    @StateObject private var store = Store()
    let movie: Movie
    
    var body: some View {
        if #available(iOS 15.0, *) {
            List {
                if let movieDetail = store.movieDetail {
                    AsyncImage(url: movieDetail.poster)
                    
                    Text(movieDetail.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text(movieDetail.director)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(movieDetail.plot)
                    
                }
            }.task {
                do {
                    try await store.fetchMovieById(movie.imdbId)
                } catch {
                    print(error)
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie.preview)
    }
}
