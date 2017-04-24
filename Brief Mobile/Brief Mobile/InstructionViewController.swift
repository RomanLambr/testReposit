//
//  InstructionViewController.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/23/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import UIKit

class InstructionViewController: UIViewController {
    
    struct Tab{
        let title       :String
        let content     :String
    }
    
    //MARK: - IBOutlet
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var segmentHightConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    var instruction : WhatList? = nil
    var tabs = [Tab]()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationBar()
        prepareSegment()
    }
    
    //MARK: - Private
    func addTabToArray(){
        guard let instruction = instruction else { return }
        let tab1 = Tab(title: instruction.tab1Title, content: instruction.tab1Content)
        let tab2 = Tab(title: instruction.tab2Title, content: instruction.tab2Content)
        tabs = [tab1, tab2]
    }
    
    func prepareSegment(){
        addTabToArray()
        infoLabel.textColor = Default.textColor
        guard let instruction = instruction else { return }
        navigationItem.title = instruction.title
        changeContext()
        if instruction.tabs == false{
            segmentHightConstraint.constant = 0.0
            segment.isHidden = true
            return
        }
        segment.tintColor = Default.textColor
        for i in 0..<segment.numberOfSegments{
            segment.setTitle(tabs[i].title.uppercased() , forSegmentAt: i)
        }
    }
    
    func changeContext(){
        let index = segment.selectedSegmentIndex
        infoLabel.text = tabs[index].content.htmlToString
    }
    
    //MARK: - Actions
    @IBAction func segmentChange(_ sender: Any) {
        changeContext()
    }
}
