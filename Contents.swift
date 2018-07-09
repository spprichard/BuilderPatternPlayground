import UIKit
/*
"Chained" URL builder
 With this approach you can configure your object through various methods and every single one of them will return the same builder object.
 This way you can chain the configuration and as a last step build the final product.
*/

enum URLError: Error {
    case unableToBuildURL
}

class URLBuilder {
    private var components: URLComponents
    
    init() {
        self.components = URLComponents()
    }
    
    func set(scheme: String) -> URLBuilder {
        self.components.scheme = scheme
        return self
    }
    
    func set(host: String) -> URLBuilder {
        self.components.host = host
        return self
    }
    
    func set(port: Int) -> URLBuilder {
        self.components.port = port
        return self
    }
    
    func set(path: String) -> URLBuilder {
        var path = path
        if !path.hasPrefix("/") {
            path = "/" + path
        }
        
        self.components.path = path
        return self
    }
    
    func addQueryItem(name: String, value: String) -> URLBuilder {
        if self.components.queryItems == nil {
            self.components.queryItems = []
        }
        
        self.components.queryItems?.append(URLQueryItem(name: name, value: value))
        return self
    }
    
    func build() -> URL? {
        return self.components.url
    }
}

let url = URLBuilder()
    .set(scheme: "http")
    .set(host: "meetup-api")
    .set(path: "health")
    .set(port: 8080)
    .build()

guard let url = url else {
    throw URLError.unableToBuildURL
}

print(url)

