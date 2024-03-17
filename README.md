## Overview

This package is meant as a very simple HTTP client for use in HTTP connections that return JSON data. It only implements GET and POST URL methods. 

Methods available:

```Swift
func get<T: Decodable>(_ url: URL, headers httpHeaders: [String: String]?) async throws -> T

func postJSON<T: Decodable>(_ url: URL, body: Data, httpHeaders: [String: String]?) async throws -> T
``` 

Note that the ```postJSON``` method automatically adds **{ "Content-Type": "application.json" }** to the URLRequest headers.

The POST method's ```Data``` parameter doesn't need to be JSON related, but the method expects that some serialized JSON data will be returned, which it will try to decode to the type specified on it's invocation.

### Usage examples:

```Swift
public struct MovieSummary: Codable {
	public let id: Int
	public let overview: String
	public let posterPath: String
	public let releaseDate: String
	public let title: String
	public let voteAverage: Double
}

final class MoviesAPI {
    func fetchPopularMovies() async throws -> [MovieSummary] {
    		let popularMoviesPage: MovieSummariesPage = try await JSONHttpClient.shared.get(popularMoviesURL, headers: apiHeaders)
    		return popularMoviesPage.movieSummaries
    }    
}

```
*The example above uses the [The Movie Database](https://www.themoviedb.org/) free API to fetch popular movies and related info.
 
## Supported iOS Versions

This package is meant to work with iOS 13 onwards.

## Contact

otaviokz@gmail.com

[otaviokz.com](https://otaviokz.com)

[linkedin.com/in/otaviokz](http://www.linkedin.com/in/otaviokz)

## Licensing 

#### <p>```  MIT Lisense  ```</p>

Copyright (c) 2024 Otavio Zabaleta

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
