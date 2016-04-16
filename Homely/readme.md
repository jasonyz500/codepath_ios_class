##user profiles:
	1. Parents getting kids to do chores:
		a. Create new home
		b. Add users to home by email/phone/other uid
		c. Add chores, configure difficulty, periodicity, reward if any
	2. Kids
		a. Log in to view pending tasks and due date
		b. View my saved up reward points
		c. Easily mark off chores as done
	3. College kids - all the above

##extra features:
	assign a chore to fixed person
	automatically assign remaining chores from the pool to people, in an evenly distributed way
	track and remindwith push notification

##models:
	1. Home: {
		id: int?
		name: String?
		members: [Member]?
		photo_url: String?
		chore_ids: [Chore]?
	}
	2. Member: {
		id: int?
		name: String?
		photo_url: String?
		home_id: int?
		max_level: <easy|medium|hard>
		age: <child|adult...>
		tasks: [Task]?
	}
	3. Chore: {
		id: int?
		name: String?
		description: String?
		type: <easy|medium|hard>
	}
	4. Task:
		id: int?
		name: String?
		parent_chore_id: int?
		assignee: Member
		start_date: String?
		end_date: String?
		status: <in_progress|done|pending>

##api endpoints:
	we need to support the following functionalities:
	1. Settings screen
		a. Members of home: CRUD
		b. Task types of home: CRUD
	2. User outlook
		a. Get all (complete/pending/past) task instances
		b. Mark task as done
	3. House outlook
		a. Get all (complete/pending/past) task instances

##different screens:
	1. Home screen
		a. See members of the home
		b. Add or remove chores from the pool
		c. Assign chores to specific members
	2. Outlook screen
		See my pending tasks and their due dates
	3. "Me" screen
		a. Configure profile (picture, name, log out, change home)
		b. View my rewards
	4. Login screen
		if you don't have a home after login, prompt you to join or create a new home


##outstanding tasks
- build & configure REST api + database
- design
	- layout screens 
	- create kickass logo
	- decide color scheme
- coding
	- build models
	- build screens according to designs
	- build api to populate models
