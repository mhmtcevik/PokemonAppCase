//
//  UnitTest.swift
//  PokemonAppTests
//
//  Created by Mehmet Çevık on 9.10.2023.
//

import XCTest
@testable import PokemonApp

class SearchViewModelTest: XCTestCase {
    
    private var viewModel: SearchViewModel?
    
    override func setUp() {
        super.setUp()
        
        viewModel = SearchViewModel()
    }
    
    func test_parameter_decideForParameter() {
        let parameter = viewModel?.decideForParameter(searchString: "1000")
        
        XCTAssertEqual(parameter as! [String : String], ["hp" : "gte1000"])
    }
}
