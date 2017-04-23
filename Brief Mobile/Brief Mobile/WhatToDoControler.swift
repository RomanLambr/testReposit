//
//  WhatToDoControler.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/23/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import UIKit
fileprivate struct Def{
       static let cellIdentifier = "reuseIdentifierCellWhat"
        static let instViewController = "InstructionViewControler"
    
}
class WhatToDoControler: UITableViewController {

    //MARK: Properties
    var instructions = [WhatList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  instructions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Def.cellIdentifier, for: indexPath)
        cell.textLabel?.text = instructions[indexPath.row].title
        return cell
    }
}
//MARK: - UITableViewDelegate
extension WhatToDoControler{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: Def.instViewController ) as! InstructionViewController
        viewController.instruction = instructions[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
