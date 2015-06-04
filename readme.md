# A Nice Nest
*Find the right home to rent based on the criteria that matter most to you.*

[anicenest.com](http://anicenest.com)

A Nice Nest ranks homes available to rent based on how well they fit a user's
preferences. Users complete one survey per household member saying what each
member would like in a home. They can then search for properties using the
Zillow API. The application will then rank each property based on how well it
matches up with the household's preferences.

## Next steps

I'm unsure whether I will continue developing this app because it relies too
heavily on a single API. Many realtors have chosen not to share
detailed information about their listings through the API, which makes using
the app somewhat frustrating. Furthermore, the API's search features are quite
limited so a user must search for an address that matches an address on Zillow
exactly. Searches by city, zipcode, or latitude and longitude are not possible
yet.

If I do continue to work on A Nice Nest, some of the next steps would be to:

* Improve and refactor the ranking algorithm
* Allow users to select from search results on a map
* Include contact information for a property's listing agent(s)
* Make site responsive on all devices
* Add more ranking categories
* Continue to improve test suite

## Contribute

Fork this repository and submit a pull request. If you're not a developer and have ideas about how this app could be improved, please [get in touch](http://nabil.io).

## Find a bug?

Please submit a [new issue](https://github.com/nhashmi/a-nice-nest/issues/new)!
