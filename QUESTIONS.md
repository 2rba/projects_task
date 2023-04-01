Project questions

- Q: Do we need users for this demo
- A: Yes

- Q: How should UI looks like? Is it possible to have pages details?
- A: It should be projects index/new/edit/show pages. Show page should display comments+status changes. And add new comment form.

- Q: What are expected statuses for a project?
- A: It should be: new, in progress, done, cancelled

- Q: Are we expecting a lot of comments/status changes for a project? 
If we are expecting scale challenges and would like to keep database load low and the same time we are expecting few comments/status changes per project,
we can join them in memory to avoid heavy database queries.
- A: please use database queries
