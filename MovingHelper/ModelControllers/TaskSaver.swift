//
//  TaskSaver.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/15/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import Foundation

/*
Struct to save tasks to JSON.
*/
public struct TaskSaver {
  
  /*
  Writes a file to the given file name in the documents directory
  containing JSON storing the given tasks.
  
  :param: The tasks to write out.
  :param: The file name to use when writing out the file.
  */
  static func writeTasksToFile(_ tasks: [Task], fileName: FileName) {
    let dictionaries = tasks.map {
      task in
      return task.asJson()
    }
    
    guard let fullFilePath = URL(string:fileName.jsonFileName().pathInDocumentsDirectory()) else { return }
    if let jsonData = try? JSONSerialization.data(withJSONObject: dictionaries, options: .prettyPrinted) {
        do {
            try jsonData.write(to: fullFilePath, options: Data.WritingOptions.atomic)
        }
        catch let error {
            print("error: \(error)")
            NSLog("Error writing tasks to file: \(error.localizedDescription)")
        }
    }
    
  }
  
  public static func nukeTaskFile(_ fileName: FileName) {
    guard let fullFilePath = URL(string: fileName.jsonFileName().pathInDocumentsDirectory()) else { return }
    
    do {
        try FileManager.default.removeItem(at: fullFilePath)
    }
    catch let error {
        print("error: \(error)")
        NSLog("Error deleting file: \(error.localizedDescription)")
    }
  }
}
