# Model Proposal for Information Aggregation in Simple Bureaucratic Systems

_Ruikun Xiao_

* Course ID: CMPLXSYS 530,
* Course Title: Computer Modeling of Complex Systems
* Term: Winter, 2019



&nbsp; 

### Goal 
*****
 
This model is proposed for preliminary investigation into bottom-up information aggregation processes in bureaucratic systems. (If possible, I would also like to further complicate the model to simulate how top-down orders are executed.)

&nbsp;  
### Justification
****

Typically, modern bureaucratic systems are hierarchical organizations with especially heterogenous members (specialized bureaucrats, with diverged standpoints and different access to information) and complex interactional structures. Therefore, ABM is an important approach to look into how they function, and how collective outcomes are produced.

&nbsp; 
### Main Micro-level Processes and Macro-level Dynamics of Interest
****

In the highly symplified model, for each step, a bureaucratic system is going to learn a latent binary variable X by investigating into several observable variables which are correlated with the variable of interest.

Only terminal agents in the hierarchy have direct access to these observables and are then able to report their observations. However, they may distort their observations, or even collude to meet their diverged standpoints. (With personnel changes and interactions, the network structure also evolves as time goes by.)

Supervisors in the system do not have direct access to the observables, but they receive reports from inferior agents, with which they do simple statistical analyses and report what they learn through these analyses. They may identify and kick out cheaters, or become cheaters themselves.

Finally, with all the information aggregated, a decision would be made about the latent variable for each step. With different configurations of parameters, different overall outcomes would be produced, and the system may also evolve in different ways.

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
 
Every agent in our model corresponds to a bureaucrat in the hierarchy. Though there are different types of agents for different positions in the hierarchy, they are all assumed to be Bayesian rational, or at least partially Bayesian rational. For the simplest version, there are only two classes of agents.
 
For the supervisor, we have:
* _Supervisor-owned variables: bias, suspicion, tolerance._
* _Supervisor-owned methods/procedures: analysis, penalty, self update._

For terminal agents, we have:
* _Terminal-owned variables: outcome preference (for this version, a fixed binary/trinary value), sophistication, subjective distributions of model parameters and supervisor-owned variables, knowledge of some other terminals' preferences._
* _Terminal-owned methods/procedures: observe, learn preference, develop companionship, communicate, report, self update._

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

_P.S. For simplicity, deceptions and betrayals are not considered here._
 
**_Action Sequence_**

The following steps are conducted for each loop.

1. A latent binary variable is generated.
2. Each terminal conducts a single observation.
3. Each terminal collects information from its neighboring terminals (companions), and produces a personal posterior distribution of the latent variable.
4. With the help of the subjective distributions, each terminal proposes the extent to which observations should be distorted.
5. After group discussions, each group of companions agrees on the extent.
6. Each terminal reports a possibly distorted observation with randomness.
7. The supervisor conducts some analyses to generate the decision. When anomalies are detected, the supervior kicks out the terminal with the greatest distortion beyond its tolerance.
8. The supervisor updates its self-owned variables. If anomalies were detected before, its suspicion increases and tolerance decreases.
9. A new terminals is enrolled if some one was kicked out.
10. Some dyadic interactions between terminals occur, during which sophisticated terminals get knowledge about others. The pattern how these interactions occur can be manipulated.
11. Each terminal updates its self-owned variables according to what has happened.

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
