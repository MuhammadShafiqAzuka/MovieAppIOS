//
//  Store.swift
//  SwiftUI-MovieApp
//
//  Created by Reşat Kut on 4.09.2022.
//

import Foundation


@MainActor
class Store: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var movieDetail: MovieDetail?
    
    func fetchMovies() async throws {
       movies = try await Webservice().loadMovies()
    }
    
    func fetchMovieById(_ movieId: String) async throws {
        movieDetail = try await Webservice().loadMovieBy(movieId)
    }
}
