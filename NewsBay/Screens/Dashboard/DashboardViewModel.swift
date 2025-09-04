//
//  DashboardViewModel.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Combine
import Foundation

@MainActor
final class DashboardViewModel: ObservableObject {
    @Published var isInitialLoadingComplete: Bool = false
    @Published var posts: [Post] = []
    @Published var searchQuery: String = ""
    
    private var fetchTask: Task<Void, Never>? = nil
    private var cancellables = Set<AnyCancellable>()
    
    private let respository: PostRepository

    init(respository: PostRepository) {
        self.respository = respository
        self.searchPostsObservation()
    }

    func fetchPosts() {
        fetchTask?.cancel()  // MAKE SURE ONLY ONE FETCH TASK IS RUNNING
        fetchTask = Task {
            do {
                if searchQuery.isEmpty {
                    posts += try await self.respository.fetchAllPosts(
                        skip: posts.count,
                    )
                } else {
                    posts += try await self.respository.searchPosts(
                        query: searchQuery,
                        skip: posts.count,
                    )
                }
                self.isInitialLoadingComplete = true
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func refreshPosts() {
        isInitialLoadingComplete = false
        posts.removeAll()
        fetchPosts()
    }
    
    private func searchPostsObservation() {
        $searchQuery
            .debounce(
                for: .milliseconds(Constant.API.debounceDelay),
                scheduler: RunLoop.main
            )
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.posts.removeAll()
                self?.fetchPosts()
            }
            .store(in: &cancellables)
    }
}
