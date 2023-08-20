//
//  UIImageViewExtension.swift
//  BeerApp
//
//  Created by Joaquín Corugedo Rodríguez on 18/8/23.
//

import UIKit

extension UIImageView {
    
    func setImage(urlString: String?) {
        guard let urlString, let url = URL(string: urlString) else { return }
        
        downloadWithUrlSession(url: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
    private func downloadWithUrlSession(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            completion(image)
            
        }.resume()
    }
}
