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

For the environment, we have the network of those terminals (or we may say, companion groups). There is also a latent binary variable and a series of observables, which will all be generated every given turn.

```python
companion_groups = []

def share_observation(groups) # Each agent shares its personal observation with its group members
def distortion_negotiation(groups) # Each group negotiate and reach an agreement over the extent to which observations of its members should be distorted

# The variables will be generated with the assumed joint distribution
```

&nbsp; 

### 2) Agents
 
Every agent in our model corresponds to a bureaucrat in the hierarchy. Though there are different types of agents for different positions in the hierarchy, they are all assumed to be Bayesian rational, or at least partially Bayesian rational. For the simplest version, there are only two classes of agents.
 
For the supervisor, we have:
* _Supervisor-owned variables: bias, suspicion, tolerance, reported._
* _Supervisor-owned methods/procedures: analysis, penalty, self update._

For terminal agents, we have:
* _Terminal-owned variables: id, corresponding observable, observation, aggregated observations, outcome preference (for this version, a fixed binary/trinary value), distortion proposal, sophistication, subjective distributions of model parameters and supervisor-owned variables, knowledge of some other terminals' preferences._
* _Terminal-owned methods/procedures: observe, generate a distortion proposal, learn preference, develop companionship, report, self update._

```python
class supervisor:
    def __init__(self, ...)
    def analysis(self) # Conduct a naive Bayesian analysis, and then try to detect any anomalies (with self.suspicion as the p-value).
    def penalty(self, terminal_list) # When anomalies are detected, kick out the greatest cheater beyond self.tolerance
    def self_update(self, decision, anomaly_detected) # Update self.bias with the output of method 'analysis'. If anomaly_detected is True, then update self.suspicion and self.tolerance as well.
    
class terminal:
    def __init__(self, ...)
    def observe(self)
    def generate_distortion_proposal(self) # With the help of the subjective distributions
    def report(self, supervisor)
    def learn_preference(self, partner) # Learn the partner's preference by chance
    def develop_companionship(self, partner, companion_groups) # Merge the group containing self and the one containing partner
    def update(self) # Update the subjective distributions
```

&nbsp; 

### 3) Action and Interaction 
 
**_Interaction Topology_**

For the simplest version, we have a network structure with only one supervisor and several terminals. While there may be some initial structures, the network also evolves during our simulation.

For each step, certain numbers of random dyadic interactions between terminals occur, during which terminals may come to learn another's outcome preferences (asymmetrically, sophisticated agents have better chances to learn their partners). Agents will also develop companionships with those identified to have the same preference, and share personal observations with these companions.

With penalized terminals kicked out by the supervisor, and new terminals enrolled, the network also evolves.

_P.S. For simplicity, deceptions and betrayals are not considered here._
 
**_Action Sequence_**

Please refer to the next section.

&nbsp; 
### 4) Model Parameters and Initialization

Global parameters:

* _The number of terminals (and correspondingly, the number of observables)._
* _The joint distribution of the latent binary variable and the observables._
* _The distribution of terminal preferences._
* _The pattern of interaction occurences._
* _Prior distributions of parameters and supervisor-owned variables for terminals._
* _Analyses to be conducted by the supervisor (by default naive Bayesian analyis)._

Initialization:

1. Specify the parameters.
2. Initialize a supervisor.
3. Initialize a given number of terminals.
4. Initialize some mutual knowledge and companionship among the terminals.

The following steps are conducted for every given turn:

1. Generate a latent binary variable and the dependent observables.
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

### 5) Assessment and Outcome Measures

Accuracies of final decisions, the final bias of the supervisor, the network status in the end, how the proportion of each preference varies.

&nbsp; 

### 6) Parameter Sweep

If time permitted, I would like to sweep through different joint distributions of the latent and the observables, different patterns of interaction occurences, and different hierarchy structures (though I only present the simplest structure here).
