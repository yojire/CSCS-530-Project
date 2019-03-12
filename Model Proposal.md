# Model Proposal for Information Aggregation in Simple Bureaucratic Systems

_Ruikun Xiao_

* Course ID: CMPLXSYS 530,
* Course Title: Computer Modeling of Complex Systems
* Term: Winter, 2019



&nbsp; 

### Goal 
*****
 
_This model is proposed for preliminary investigation into bottom-up information aggregation processes in bureaucratic systems. (If possible, I would also like to further complicate the model to simulate how top-down orders are executed.)_

&nbsp;  
### Justification
****

_Typically, modern bureaucratic systems are hierarchical organizations with especially heterogenous members (specialized bureaucrats, with diverged standpoints and different access to information) and complex interactional structures. Therefore, ABM is an important approach to look into how they function, and how collective outcomes are produced._

&nbsp; 
### Main Micro-level Processes and Macro-level Dynamics of Interest
****

_In the highly symplified model, for each step, a bureaucratic system is going to learn a latent binary variable X by investigating into several observable variables which are correlated with the variable of interest._

_Only terminal agents in the hierarchy have direct access to these observables and are then able to report their observations. However, they may distort their observations, or even collude to meet their diverged standpoints. (With personnel changes and interactions, the network structure also evolves as time goes by.)_

_Supervisors in the system do not have direct access to the observables, but they receive reports from inferior agents, with which they do simple statistical analyses and report what they learn through these analyses. They may identify and kick out cheaters, or become cheaters themselves._

_Finally, with all the information aggregated, a decision would be made about the latent variable for each step. With different configurations of parameters, different overall outcomes would be produced, and the system may also evolve in different ways._

&nbsp; 

## Model Outline
****

Here I would only present the simplest version, where there is only one supervisor for all terminal agents. It should not be hard to extend the model.

&nbsp; 
### 1) Environment

_There are generally three_


```python
# Include first pass of the code you are thinking of using to construct your environment
# This may be a set of "patches-own" variables and a command in the "setup" procedure, a list, an array, or Class constructor
# Feel free to include any patch methods/procedures you have. Filling in with pseudocode is ok! 
# NOTE: If using Netlogo, remove "python" from the markdown at the top of this section to get a generic code block
```

&nbsp; 

### 2) Agents
 
 _Every agent in our model corresponds to a bureaucrat in the hierarchy. Though there are different types of agents for different positions in the hierarchy, they are all assumed to be Bayesian rational, or at least partially Bayesian rational. For the simplest version, there are only two classes of agents._
 
_For the supervisor, we have:_
* _Supervisor-owned variables: bias, suspicion, tolerance._
* _Supervisor-owned methods/procedures: analysis, penalty, self update_

_For terminal agents, we have:_
* _Terminal-owned variables: outcome preference (for this version, a fixed binary value), sophistication, subjective distributions of environment parameters and supervisor-owned variables, knowledge of some other terminals' preferences._
* _Terminal-owned methods/procedures: observe, learn preference, develop companionship, communicate, report_

```python
# Include first pass of the code you are thinking of using to construct your agents
# This may be a set of "turtle-own" variables and a command in the "setup" procedure, a list, an array, or Class constructor
# Feel free to include any agent methods/procedures you have so far. Filling in with pseudocode is ok! 
# NOTE: If using Netlogo, remove "python" from the markdown at the top of this section to get a generic code block
```

&nbsp; 

### 3) Action and Interaction 
 
**_Interaction Topology_**

For the simplest version, we have a network structure with only one supervisor and several terminals. While there may be some initial structures, the network also evolves during our simulation.

For each step, certain numbers of random dyadic interactions between terminals occur, during which terminals may come to learn another's outcome preferences (asymmetrically, sophisticated agents have better chances to learn their partners). Agents will also develop companionships with those identified to have the same preference, and share personal observations with these companions.

With penalized terminals kicked out by the supervisor, and new terminals enrolled, the network also evolves.

P.S. For simplicity, deceptions and betrayals are not considered here.
 
**_Action Sequence_**

_What does an agent, cell, etc. do on a given turn? Provide a step-by-step description of what happens on a given turn for each part of your model_

1. Step 1
2. Step 2
3. Etc...

&nbsp; 
### 4) Model Parameters and Initialization

_Describe and list any global parameters you will be applying in your model._

_Describe how your model will be initialized_

_Provide a high level, step-by-step description of your schedule during each "tick" of the model_

&nbsp; 

### 5) Assessment and Outcome Measures

_What quantitative metrics and/or qualitative features will you use to assess your model outcomes?_

&nbsp; 

### 6) Parameter Sweep

_What parameters are you most interested in sweeping through? What value ranges do you expect to look at for your analysis?_
