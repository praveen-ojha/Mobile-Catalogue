//
//  TransitionMode.swift
//  Mobile Catalogue
//
//  Created by Praveen Ojha on 1/8/18.
//  Copyright © 2018 Praveen Ojha. All rights reserved.
//

import Foundation

/*
    Possible directions of the transition
 
    Present - Present new controller
    Dismiss - Dismiss old controller
 
*/

@objc public enum TransitionMode: Int {
    case Present
    case Dismiss
}
