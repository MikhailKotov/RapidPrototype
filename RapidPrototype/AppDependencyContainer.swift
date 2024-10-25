//
//  AppDependencyContainer.swift
//  RapidPrototype
//
//  Created by Mykhailo Kotov on 24/10/2024.
//

import Foundation

class AppDependencyContainer {

    static let shared = AppDependencyContainer()
    private lazy var localRepository: Repository = LocalRepository()
    private lazy var previewRepository: Repository = PreviewRepository()

    @MainActor
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(repository: localRepository)
    }

    @MainActor
    func makePreviewHomeViewModel() -> HomeViewModel {
        return HomeViewModel(repository: previewRepository)
    }
}
