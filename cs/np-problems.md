# P / NP problems

P (Polynomial Time): As name itself suggests, these are the problems which can be solved in polynomial time.

NP (Non-deterministic-polynomial Time): These are the decision problems which can be verified in polynomial time. That means, if I claim that there is a polynomial time solution for a particular problem, you ask me to prove it. Then, I will give you a proof which you can easily verify in polynomial time. These kind of problems are called NP problems. Note that, here we are not talking about whether there is a polynomial time solution for this problem or not. But we are talking about verifying the solution to a given problem in polynomial time.

NP-Hard: These are at least as hard as the hardest problems in NP. If we can solve these problems in polynomial time, we can solve any NP problem that can possibly exist. Note that these problems are not necessarily NP problems. That means, we may/may-not verify the solution to these problems in polynomial time.

NP-Complete: These are the problems which are both NP and NP-Hard. That means, if we can solve these problems, we can solve any other NP problem and the solutions to these problems can be verified in polynomial time.

----------------------------

____________________________________________________________
| Problem Type | Verifiable in P time | Solvable in P time | Increasing Difficulty
___________________________________________________________|           |
| P            |        Yes           |        Yes         |           |
| NP           |        Yes           |     Yes or No (1)  |           |
| NP-Complete  |        Yes           |      Unknown       |           |
| NP-Hard      |     Yes or No (2)    |      Unknown (3)   |           |
____________________________________________________________           V

(1) An NP problem that is also P is solvable in P time.
(2) An NP-Hard problem that is also NP-Complete is verifiable in P time.
(3) NP-Complete problems (all of which form a subset of NP-hard) might be. The rest of NP hard is not.
