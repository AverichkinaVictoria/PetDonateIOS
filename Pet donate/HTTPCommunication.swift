//
//  HTTPCommunication.swift
//  Pet donate
//
//  Created by Виктория on 06.05.2020.
//  Copyright © 2020 Виктория. All rights reserved.
//

import Foundation
import UIKit
// Inheriting from NSObject to obey (conform) NSObjectProtocol,
// because URLSessionDownloadDelegate inherits From this Protocol,
// and since we obey it, we must also follow the parent Protocol.
class HTTPCommunication: NSObject {

    // The completionHandler property in the class is a closure that will
    // contain code for processing data received from the site and displaying it
    // in the interface of our app.
    var completionHandler: ((Data) -> Void)!
    
   // retrieveURL(_: completionHandler:) loads data
    // with url to temporary storage
    func retrieveURL(_ url: URL, completionHandler: @escaping ((Data) -> Void)) {
        self.completionHandler = completionHandler
        let request: URLRequest = URLRequest(url: url)
        let session: URLSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let task: URLSessionDownloadTask = session.downloadTask(with: request)
        task.resume()
    }
}

// We are creating a class extension that inherits from NSObject
// and obeys (conforms) the URLSessionDownloadDelegate Protocol,
// to use the capabilities of this Protocol for processing
// loaded data.
extension HTTPCommunication: URLSessionDownloadDelegate {

    // This method is called after successful data loading
    // from the site to temporary storage for further processing.
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        do {
            let data: Data = try Data(contentsOf: location)
           // Next, we perform completionHandler with the received data.
            // And since loading occurred asynchronously in the background queue,
            // then for the ability to change the interface, which works in
            // main queue, we need to perform a closure in the main queue.
            DispatchQueue.main.async(execute: {
                self.completionHandler(data)
            })
        } catch {
            print("Can't get data from location.")
        }
    }
}
