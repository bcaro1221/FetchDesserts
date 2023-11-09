//
//  Dessert.swift
//  FetchDesserts
//
//  Created by Bryce Caro on 11/8/23.
//

import Foundation

protocol DessertType: Decodable, Identifiable {
    var id: String { get }
    var title: String { get }
    var url: URL? { get }
}

struct DessertPreview: DessertType {
    var id: String
    var title: String
    var url: URL?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decode(URL.self, forKey: .url)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case title = "strMeal"
        case url = "strMealThumb"
    }
}

struct Dessert: DessertType {
    var id: String
    var title: String
    var url: URL?
    
    var source: URL?
    var video: URL?
    var areaOfOrigin: String
    var instructions: String
    
    var ingredients: [String]
    var measurements: [String]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decode(URL.self, forKey: .url)
        
        self.source = try container.decode(URL.self, forKey: .source)
        self.video = try container.decode(URL.self, forKey: .video)
        self.areaOfOrigin = try container.decode(String.self, forKey: .areaOfOrigin)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        
        
        
        var ingredients: [String] = []
        for i in 1..<21 {
            var currentIngredient: String = try container.decode(String.self, forKey: CodingKeys(stringValue: "strIngredient\(i)")!)
            if currentIngredient == "" {
                break
            }
            ingredients.append(currentIngredient)
        }
        self.ingredients = ingredients
        
        
        var measurements: [String] = []
        for i in 1..<21 {
            var currentMeasurement: String = try container.decode(String.self, forKey: CodingKeys(stringValue: "strMeasure\(i)")!)
            if currentMeasurement == "" {
                break
            }
            measurements.append(currentMeasurement)
        }
        self.measurements = measurements
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case title = "strMeal"
        case url = "strMealThumb"
        case source = "strSource"
        case video = "strYoutube"
        case instructions = "strInstructions"
        case areaOfOrigin = "strArea"
        case ingredients, measurements
    }
}

struct DessertsResult<T: DessertType>: Decodable {
    var meals: [T]
}


// MARK: Test Data

#if DEBUG

extension DessertPreview {
    init(id: String, title: String, url: String) {
        self.id = id
        self.title = title
        self.url = URL(string: url)
    }
    
    public static let testDessertPreview = DessertPreview(id: "53046", title: "Portuguese custard tarts", url: "https://www.themealdb.com/images/media/meals/vmz7gl1614350221.jpg")
}

extension Dessert {
    init(id: String, title: String, url: String, source: String, video: String, areaOfOrigin: String, instructions: String, ingredients: [String], measurements: [String]) {
        self.id = id
        self.title = title
        self.url = URL(string: url)
        self.source = URL(string:source)
        self.video = URL(string:video)
        self.areaOfOrigin = areaOfOrigin
        self.instructions = instructions
        self.ingredients = ingredients
        self.measurements = measurements
    }
    
    public static let testDessert = Dessert(
        id: "53046",
        title: "Portuguese custard tarts",
        url: "https://www.themealdb.com/images/media/meals/vmz7gl1614350221.jpg",
        source:"https://www.olivemagazine.com/recipes/baking-and-desserts/portuguese-custard-tarts/",
        video: "https://www.youtube.com/watch?v=lWLCxui1Mw8",
        areaOfOrigin: "Portuguese",
        instructions: """
             STEP 1
             Roll the pastry
             Mix the flour and icing sugar, and use this to dust the work surface. Roll the pastry out to make a 45 x 30cm rectangle. Roll up lengthways to create a long sausage shape.
             
             STEP 2
             Cutting pastry into rounds
             Cut the pastry into 24 wheels, about 1-2cm thick.
             
             STEP 3
             Roll out each pastry portion
             Roll each wheel lightly with the rolling pin to fit 2 x 12-hole non-stick fairy cake tins.
             
             STEP 4
             Press pastry into the tin
             Press the pastry circles into the tins and mould into the tins to make thin cases. Chill until needed.
             
             STEP 5
             Make the infused syrup
             Heat the oven to 220C/fan 200C/gas 7. Make a sugar syrup by bringing the sugar, 200ml water, lemon zest and cinnamon stick to the boil. Reduce until syrupy, allow to cool, then remove the cinnamon and lemon. Whisk the eggs, egg yolks and cornflour until smooth in another large pan.
             
             STEP 6
             Making custard
             Heat the milk and vanilla pod seeds in a separate pan until just below the boil. Gradually pour the hot milk over the eggs and cornflour, then cook on a low heat, continually whisking.
             
             STEP 7
             Add syrup to custard
             Add the cooled sugar syrup to the custard and whisk until thickened slightly.
             
             STEP 8
             Pour custard into the tins
             Pour the custard through a sieve. Pour into the pastry cases and bake for 15 minutes until the pastry is golden and the custard has darkened.
             
             STEP 9
             cool and dust with icing sugar
             Cool completely in the tins then sift over icing sugar and ground cinnamon to serve.
             """,
        ingredients: [
            "Plain Flour",
            "Icing Sugar",
            "Puff Pastry",
            "Caster Sugar",
            "Lemon Zest",
            "Cinnamon",
            "Eggs",
            "Egg Yolks",
            "Corn Flour",
            "Whole Milk",
            "Vanilla",
            "Cinnamon",
        ],
        measurements: [
            "2 tbs",
            "2 tbs",
            "375g",
            "250g",
            "2 strips",
            "1 stick",
            "2",
            "4",
            "50g",
            "500ml",
            "Pod of",
            "To serve"
        ]
    )
}


#endif
