//
//  File.swift
//  
//
//  Created by jcc on 2023/3/2.
//


public extension PinLayout{
    
    var safeAreaWithoutBottom: PEdgeInsets {
        var inset = safeArea
        inset.bottom = 0
        return inset
    }
    
}
