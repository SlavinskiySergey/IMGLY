# Take-home assignment: ****Senior UI/UX Engineer, iOS****

# Intro

Welcome to the [IMG.LY](http://IMG.LY) take-home task for the ****Senior UI/UX Engineer iOS**** position! As part of our hiring process, we would like you to work on a small assignment before our first technical interview. 

It shouldn’t take you more than 3-4 hours and it is not about delivering a perfect solution. Focus on writing well-structured, understandable code. ****We want to see how you approach and tackle a problem, and structure your solution. More importantly, it gives us a common ground for further discussions during the technical interview. At some point, we will talk about your solution, what technical decisions you’ve made and what problems you’ve encountered. Keep this in mind before you decide to add a library to do all the heavy lifting for you.

Please use Swift and ****SwiftUI****. But apart from that feel free to use whatever tech stack you feel comfortable with.

# Description

Inside your app, you are going to fetch JSON data from an endpoint. It represents a tree structure like this:

```json
[
  {
    "label": "img.ly",
    "children": [
      {
        "label": "Workspace A",
        "children": [
          { "id": "imgly.A.1", "label": "Entry 1" },
          { "id": "imgly.A.2", "label": "Entry 2" },
          { "id": "imgly.A.3", "label": "Entry 3" },
					{
            "label": "Entry 4",
            "children": [
              {
                "id": "imgly.A.4.1",
                "label": "Sub-Entry 1"
              }
            ]
          }
        ]
      },
      // ...
    ]
  },
  {
    "label": "9elements",
    "children": [
      // ...
    ]
  }
]
```

Please solve the following tasks with this kind of data format. Of course, your solution should work with any data in the same format.

1. **Fetch and display the data**. 
Your first task is to fetch the data from [`https://ubique.img.ly/frontend-tha/data.json`](https://ubique.img.ly/frontend-tha/data.json) and display it in a navigation hierarchy in your app.

2. **Interact with the data**.
Add interaction to the tree. Allow removing and moving children in the list by enabling the edit mode.

3. **Fetch additional data.**
If the user clicks on a leaf, fetch data from `https://ubique.img.ly/frontend-tha/entries/${id}.json` (where `${id}` is the id of an entry). Display the data in a detail view on a new screen. Beware that some data might not exist (404 status code).

4. **Add theming**
Add the ability to easily change the theme of your UI to a different customized set of colors.

5. **Polish the design**
Tweak the overview and detail screens to be aesthetically pleasing. Feel free to make it reflect your personal taste in user interface design.

## Deliverables

- Please create a GitHub repository for your project and share it with us
- Solve the tasks defined above with a reasonable Git commit history
- Add 1-2 tests for critical code paths
- Last but not least: Add documentation to your code and overall project