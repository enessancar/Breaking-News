
import Foundation


struct ArticleList : Decodable {
    
    let articles : [Article]
}


struct Article  : Decodable {
    
    var author  : String?
    var title   : String?
    var description : String?
}

