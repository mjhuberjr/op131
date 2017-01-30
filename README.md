# opertation thirteenOne's Website
This website is built using the [Vapor](https://github.com/vapor) web framework.

## Setup
Being a pretty simple website that will not be taking a lot of daily changes, I've decided not to build this as an actual web app. All database entries are handled locally before being secure transfered to my server.

### Things to do
- Need to build a Custom Tag to display the blocks two on a line, right now it's done in the Section Controller and adds a `newLine` parameter. Very hacky.
- Do separate queries for release and in development. Display them using `#embed`. Each will have their separate views created.
- Need to dynamically get sections to display and build url accordingly
