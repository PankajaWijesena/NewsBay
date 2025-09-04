//
//  DashboardPostsTests.swift
//  NewsBayTests
//
//  Created by Pankaja Wijesena.
//

import Combine
import NewsBay
import XCTest

@MainActor
final class DashboardPostsTests: XCTestCase {

    private var viewModel: DashboardViewModel!
    private var mockRepository: MockPostRepository!
    private var cancellables: Set<AnyCancellable>!

    
    override func setUp() {
        super.setUp()
        mockRepository = MockPostRepository()
        viewModel = DashboardViewModel(respository: mockRepository)
        cancellables = []
    }

    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        cancellables = nil
        super.tearDown()
    }

    
    func test_fetchPosts_whenSearchQueryIsEmpty_fetchesAllPosts() async throws {
        // GIVEN
        let expectedPosts = [
            Post(
                id: 1,
                title: "Test",
                body: "Body",
                tags: [],
                reactions: .init(likes: 1, dislikes: 0),
                views: 10,
                userId: 123
            )
        ]
        mockRepository.allPostsToReturn = expectedPosts

        // WHEN
        viewModel.fetchPosts()
        try await Task.sleep(for: .seconds(2))  // WAIT FOR TASK COMPLETION

        // THEN
        XCTAssertEqual(viewModel.posts.count, 1)
        XCTAssertEqual(viewModel.posts.first?.id, expectedPosts.first?.id)
        XCTAssertTrue(viewModel.isInitialLoadingComplete)
    }

    
    func test_fetchPosts_whenSearchQueryIsNotEmpty_fetchesSearchPosts() async throws {
        // GIVEN
        let expectedPosts = [
            Post(
                id: 2,
                title: "Search",
                body: "Result",
                tags: [],
                reactions: .init(likes: 2, dislikes: 1),
                views: 15,
                userId: 456
            )
        ]
        mockRepository.searchPostsToReturn = expectedPosts
        viewModel.searchQuery = "query"

        // WHEN
        viewModel.fetchPosts()
        try await Task.sleep(for: .seconds(2))  // WAIT FOR TASK COMPLETION

        // THEN
        XCTAssertEqual(viewModel.posts.count, 1)
        XCTAssertEqual(viewModel.posts.first?.id, expectedPosts.first?.id)
    }

    
    func test_searchPostsObservation_whenSearchQueryChanges_clearsAndFetchesNewPosts() async throws {
        // GIVEN
        let initialPosts = [
            Post(
                id: 1,
                title: "Initial",
                body: "Post",
                tags: [],
                reactions: .init(likes: 1, dislikes: 0),
                views: 5,
                userId: 111
            )
        ]
        mockRepository.allPostsToReturn = initialPosts
        viewModel.fetchPosts()
        try await Task.sleep(for: .seconds(2))  // WAIT FOR TASK COMPLETION
        XCTAssertEqual(viewModel.posts.count, 1)

        let searchedPosts = [
            Post(
                id: 99,
                title: "Searched",
                body: "Post",
                tags: [],
                reactions: .init(likes: 10, dislikes: 2),
                views: 100,
                userId: 222
            )
        ]
        mockRepository.searchPostsToReturn = searchedPosts

        let expectation = XCTestExpectation(description: "Wait for debounce search")

        viewModel.$posts
            .dropFirst(2)  // skip initial + cleared
            .sink { posts in
                if posts.contains(where: { $0.id == 99 }) {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // WHEN
        viewModel.searchQuery = "search term"

        // THEN
        await fulfillment(of: [expectation], timeout: 2)
    }

    
    func test_fetchPosts_whenCalledAgain_appendsNewPosts() async throws {
        // GIVEN
        let firstPage = [
            Post(
                id: 1,
                title: "Page1",
                body: "Body1",
                tags: [],
                reactions: .init(likes: 0, dislikes: 0),
                views: 1,
                userId: 1
            )
        ]
        mockRepository.allPostsToReturn = firstPage
        viewModel.fetchPosts()
        try await Task.sleep(for: .seconds(2))  // WAIT FOR TASK COMPLETION
        XCTAssertEqual(viewModel.posts.count, 1)

        let secondPage = [
            Post(
                id: 2,
                title: "Page2",
                body: "Body2",
                tags: [],
                reactions: .init(likes: 0, dislikes: 0),
                views: 2,
                userId: 2
            )
        ]
        mockRepository.allPostsToReturn = secondPage

        // WHEN
        viewModel.fetchPosts()
        try await Task.sleep(for: .seconds(2))  // WAIT FOR TASK COMPLETION

        // THEN
        XCTAssertEqual(viewModel.posts.count, 2)
        XCTAssertEqual(viewModel.posts.last?.id, 2)
    }

    
    func test_refreshPosts_whenCalled_clearsAndFetchesFreshData() async throws {
        // GIVEN
        let initialPosts = [
            Post(
                id: 1,
                title: "Old",
                body: "Post",
                tags: [],
                reactions: .init(likes: 1, dislikes: 0),
                views: 10,
                userId: 123
            )
        ]
        viewModel.posts = initialPosts

        let newPosts = [
            Post(
                id: 2,
                title: "New",
                body: "Post",
                tags: [],
                reactions: .init(likes: 2, dislikes: 1),
                views: 20,
                userId: 456
            )
        ]
        mockRepository.allPostsToReturn = newPosts

        // WHEN
        viewModel.refreshPosts()
        try await Task.sleep(for: .seconds(2))  // WAIT FOR TASK COMPLETION

        // THEN
        XCTAssertEqual(viewModel.posts.count, 1)
        XCTAssertEqual(viewModel.posts.first?.id, 2)
        XCTAssertTrue(viewModel.isInitialLoadingComplete)
    }

    
    func test_fetchPosts_whenCalledMultipleTimes_onlyLatestTaskCompletes() async throws {
        // GIVEN
        let firstBatch = [
            Post(
                id: 1,
                title: "Batch1",
                body: "Post1",
                tags: [],
                reactions: .init(likes: 0, dislikes: 0),
                views: 1,
                userId: 1
            )
        ]
        let secondBatch = [
            Post(
                id: 2,
                title: "Batch2",
                body: "Post2",
                tags: [],
                reactions: .init(likes: 0, dislikes: 0),
                views: 2,
                userId: 2
            )
        ]
        mockRepository.allPostsToReturn = firstBatch

        // WHEN
        viewModel.fetchPosts()
        mockRepository.allPostsToReturn = secondBatch
        viewModel.fetchPosts()  // IMMEDIATELY START FETCH AGAIN, CANCELS FIRST TASK

        try await Task.sleep(for: .seconds(2))  // WAIT FOR TASK COMPLETION

        // THEN
        XCTAssertEqual(viewModel.posts.count, 1)
        XCTAssertEqual(viewModel.posts.first?.id, 2, "Only the latest fetch should succeed")
    }
}
