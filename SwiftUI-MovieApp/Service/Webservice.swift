import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidRequest
}

class Webservice {
    
    func loadMovies() async throws -> [Movie] {
        
        guard let url = URL(string: "https://www.omdbapi.com/?s=Superman&page=2&apikey=b2b00439") else {
            throw NetworkError.badUrl
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: data)
        return movieResponse?.search ?? []
    }
    
    func loadMovieBy(_ movieId: String) async throws -> MovieDetail {
        
        guard let url = URL(string: "http://www.omdbapi.com/?i=\(movieId)&apikey=b2b00439") else {
            throw NetworkError.badUrl
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let movieDetail = try? JSONDecoder().decode(MovieDetail.self, from: data) else {
            throw NetworkError.invalidRequest
        }
        
        return movieDetail
    }
}
