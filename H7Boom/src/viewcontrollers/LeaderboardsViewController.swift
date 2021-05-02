//
//  LeaderboardsViewController.swift
//  H7Boom
//
//  Created by שחר זנגי on 01/05/2021.
//  Copyright © 2021 שחר זנגי. All rights reserved.
//

import Foundation
import UIKit

class LeaderboardsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    private var leaderboardsArr : [String] = []

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        
        // convert json to array
        //let json = try? JSONSerialization.jsonObject(with: ScoreHandler.publicLeaderboardJSON!, options: []) as? [String: Int]
        
        sleep(1)
        var count = 1
        var scorearr: [Int] = []
        var nickarr: [String] = []
        for (nickname, highscore) in ScoreHandler.publicLeaderboardDict!{
            scorearr.append(highscore)
            nickarr.append(nickname)
        }
        
        // sort into array
        var newarr: [String] = []
        while (!scorearr.isEmpty){
            for maybeBiggest in 0 ..< scorearr.count {
                var isBiggest = true
                for othernum in 0 ..< scorearr.count {
                    if (scorearr[othernum] > scorearr[maybeBiggest]){
                        isBiggest = false
                        break
                    }
                }
                if isBiggest{
                    newarr.append("\(nickarr[maybeBiggest]): \(scorearr[maybeBiggest])")
                    nickarr.remove(at: maybeBiggest)
                    scorearr.remove(at: maybeBiggest)
                    break
                }
            }
        }
        leaderboardsArr = newarr
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) -> Int{
        return leaderboardsArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderboardsCell", for: indexPath)
        print(leaderboardsArr)
        cell.textLabel!.text = "\(String(indexPath.row + 1)). " + leaderboardsArr[indexPath.row]
        return cell
    }
}
