## TODO Tally Take Home Project

Overview: This is a take home coding challenge to be completed within a 30 minute time frame.
The requirements outlined below were implemented, and successfully working, in just over the 30 minute time period. 
Once the two pages were displaying the results I spent a little extra time cleaning a few things up.

Because of the time allotted, I left out the following:
1. Testing. I do have another branch ```added_tests``` that contains a couple unit tests.
2. Fancy web views. My goal was to display the proper results in a quick and simple manner.
3. Rails. It seemed overkill to scaffold for a simple web view or two to display real time data.
Also, the instructions strictly says Ruby. So I took that as not using Rails and ruby core only.

### Instructions:
If you look at the following URL (https://jsonplaceholder.typicode.com/todos) you will see a response containing data that is a list of todo items. Your task is to create an
 application/program (script/webpage) using Ruby, to do the following:
 
 - Read the JSON response from the URL and calculate the number of completed
 todo items for each user.
 - Find the user that has completed the most todo items. I coded for more than one user as there could be a tie on max completed.
 
[JSON Response](https://jsonplaceholder.typicode.com/todos)