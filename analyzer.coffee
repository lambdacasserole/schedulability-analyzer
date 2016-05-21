# Represents a task.
# 
class Task
	constructor: (@priority, @wcet, @deadline, @period) ->
		# No need to do anything here.

# Represents the result of a schedulability analysis for a task.
#
class Result
	constructor: (@task, @result) ->
		# No need to do anything here.
		
# These tasks will be analysed.
tasks = [
	new Task(1, 5, 10, 100)
	new Task(2, 3, 100, 100)
	new Task(3, 120, 150, 150)
	new Task(4, 150, 200, 500)
	new Task(5, 300, 500, 500)
]

# Computes the interference measure for one task against another.
# 
# @param [Task] i	the task to compute for
# @param [Task] j	the task to compute against
#
getInterferenceMeasure = (i, j) -> Math.ceil(i.deadline / j.period) * j.wcet 

# Computes the interference measure for a task.
# 
# @param [Task] i	the task to calculate the interference for
#
getInterference = (i) ->
	higher = tasks.filter (t) -> 
		t.priority < i.priority # Get tasks with higher priority.	
	if higher.length == 0 then return 0
	# Get measure for each task.
	measures = higher.map (j) -> getInterferenceMeasure i, j 
	measures.reduce (x, y) -> x + y # Sum the measures.
	
# Returns true if a task is schedulable.
#
# @param [Task] i	the task to check
#
isSchedulable = (i) ->
	(i.wcet / i.deadline) + (getInterference(i) / i.deadline) < 1

# Compute schedulability for all tasks.
results = tasks.map (t) -> new Result(t, isSchedulable t) 

console.log results
