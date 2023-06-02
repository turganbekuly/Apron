//
//  AIRecommendation+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27/05/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models

extension AIRecommendationViewController {
    
    // MARK: - Network

    func getRecipesList(familyCount: Int, dayCount: Int) {
        let body = SearchAIRecommendationRequestBody()
        let promt = "Act like the most popular and high skill brand chef in Kazakhstan. I need to create \(dayCount) week meal plan for \(familyCount) person. Exclude pork and not halal ingredients. All recipes should be localized for Kazakhstan market. Give me recipes with instructions and ingredients segmented for breakfast, lunch, dinner. In russian without any introduction words"
    }
}
