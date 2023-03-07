//
//  AppDiary.swift
//  AppDiary
//
//  Created by jcc on 2023/3/7.
//

import BaseUI
import UIRoute

public let diaryNavigationControllerType: NavigationController.Type = DiaryNavigationController.self

public let routableViewControllers: [Routable.Type] = [
    DiaryViewController.self,
]

public let actions: [Actable.Type] = []
