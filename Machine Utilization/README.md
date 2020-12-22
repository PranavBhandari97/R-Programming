# Machine Utilization

## Business Problem

#### The provided dataset is for a coal terminal. They would like to investigate one of their heavy machines - RL1.
#### One month's worth of data for all of their machines. 
#### The dataset shows what percentage of capacity for each machine was idle in any given hour. 

### An R list needs to be delivered with the following components:
### Character: Machine name
### Vector: (min, mean, max) utilization for the month (excluding unknown hours)
### Logical: Has utilization ever fallen below 90%?
### Vector: All hours where utilization is unknown (NA’s)
### Dataframe: For this machine
### Plot: For all machines
