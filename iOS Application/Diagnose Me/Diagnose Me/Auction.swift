

import Foundation


class Auction {
    var id, reserve_price, end_date, remedy_id: String?
    
    init(id: String, reserve_price: String, end_date: String, remedy_id: String) {
        self.id = id
        self.remedy_id = remedy_id
        self.reserve_price = reserve_price
        self.end_date = end_date
    }
    
}
