//
//  TableViewCell.swift
//  WeatherApp
//
//  Created by Lika Zurabiani on 17.02.22.
//

import UIKit

class TableViewCell: UITableViewCell{
    
    
    
    @IBOutlet var myTemp: UILabel!
    @IBOutlet var myTime: UILabel!
    @IBOutlet var myCondition: UILabel!
    @IBOutlet var myImage: UIImageView!
    
    
    var dailyForecast : [WeatherInfo] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyForecast.count
    }
    
    
    func configure(with hourlyForecast: WeatherInfo){
        
        myCondition.text = hourlyForecast.description.description
        myTemp.text = String(hourlyForecast.temp.kelvinToCeliusConverter().description) + "°C"
        myImage.image = UIImage(systemName: hourlyForecast.conditionName)
        
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        // myTime.text = item.dt_txt?.description
        if let date = dateFormatterGet.date(from: hourlyForecast.time) {
            myTime.text = dateFormatter.string(from: date)
        }
        
        
    }
    
    
}
