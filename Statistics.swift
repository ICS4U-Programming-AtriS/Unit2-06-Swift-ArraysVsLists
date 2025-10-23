//
//  Statistics.swift
//
//  Created by Atri Sarker
//  Created on 2025-10-22
//  Version 1.0
//  Copyright (c) 2025 Atri Sarker. All rights reserved.
//
// Program that performs statistical operations on an input text file.
// It will find and report the mean, median, and mode of an integer dataset.

import Foundation

// Function that finds and returns the mean of an array.
func calcMean(_ arr: [Int]) -> Double {
    // Initialize a variable for the sum
    var sum = 0.0
    // Loop through the values of the array
    for num in arr {
        // Increment the sum
        sum += Double(num)
    }
    // Calculate the mean
    let mean = sum / Double(arr.count)
    // Return the mean
    return mean
}

// Function that finds and returns the median of an array.
func calcMedian(_ arr: [Int]) -> Double {
    // Get the size of the array
    let size = arr.count
    // Initialize variable for the median
    var median = 0.0
    // Check if the array is evenly sized or oddly sized
    if size % 2 == 0 {
        // If the array has an even size.
        // Set the median to the average of the middle two elements.
        median = Double(arr[size / 2] + arr[(size / 2) + 1]) / 2.0
    } else {
        // If the array has an odd size.
        // Set the median to the value of the middle element.
        median = Double(arr[size / 2])
    }
    // Return the median
    return median
}

// Function that finds and returns the mode[s] of an array.
func calcMode(_ arr: [Int]) -> [Int] {
    // List to hold the mode[s]
    var modesList: [Int] = []
    // Variable for the population threshold to be a mode.
    var modePop = 0
    // Variable for the population of a current chain of numbers.
    var currentPop = 0
    // Variable for the current chain's number
    var currentNum = 0
    // Go through every number in the array
    for num in arr {
        // Reset the chain if it's a new chain
        if num != currentNum {
            currentNum = num
            currentPop = 0
        }
        // Increment the population of the current chain by 1
        currentPop += 1
        // Check if the population is bigger than the current mode threshold.
        if currentPop > modePop {
            // If so, make currentPop the new modePop
            modePop = currentPop
            // and clear the list
            modesList.removeAll()
        }
        // Check if the population meets the current mode threshold.
        if currentPop == modePop {
            // If so, add it to the list of modes.
            modesList.append(num)
        }
    }
    // Return the array
    return modesList
}

// Loop through the arguments
for inputFilePath in CommandLine.arguments[1...] {
    print("Processing " + inputFilePath)
    // Access the input file
    guard let inputFile = FileHandle(forReadingAtPath: inputFilePath) else {
        print("CANNOT OPEN "  + inputFilePath)
        continue
    }

    // Read the contents of the input file
    let inputData = inputFile.readDataToEndOfFile()

    // Convert the data to a string
    guard let inputString = String(data: inputData, encoding: .utf8) else {
        print("CANNOT CONVERT FILE DATA TO A STRING")
        continue
    }

    // Create a list of all available lines
    let listOfLines = inputString.components(separatedBy: .newlines)

    // Array [list] to hold all the integers
    var arrOfInts: [Int] = []
    // Loop through all the lines in the list
    for line in listOfLines {
        // Try converting line to an integer
        if let num = Int(line) {
            // Add the number to the list
            arrOfInts.append(num)
        } else {
            // If the line can't be converted to an integer,
            // the program just ignores the line and continues.
            continue
        }
    }

    // Check if array isn't empty
    if !arrOfInts.isEmpty {
        // Sort the array
        arrOfInts.sort()
        // Display the array
        print(arrOfInts)
        print()
        // Calculate the mean, median, and mode
        let mean = calcMean(arrOfInts)
        let median = calcMedian(arrOfInts)
        let modes = calcMode(arrOfInts)
        // Display the mean, median, and mode
        print("The mean is: \(mean)")
        print("The median is: \(median)")
        print("The mode(s) is/are: \(modes)")
    } else {
        // Otherwise, display an error message [IN RED]
        print("\u{001B}[31m", terminator: "") // Red color code
        print("ERROR: DATASET IS EMPTY.")
    }
    print("Processing complete for " + inputFilePath)
}
