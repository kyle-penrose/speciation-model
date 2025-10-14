# speciation-model
An agent-based model to simulate allopatric and sympatric speciation, written with NetLogo

# WHAT IS IT?
This simulation is designed for the purpose of demonstrating and learning about speciation, the evolutionary process by which one species splits into two.

The biological species concept defines a species as a population which can interbreed to produce viable and fertile offspring. In this model, agents are given a genome sequence at birth (represented by a string of binary digits) as a combination of the genomes of the parents. At the beginning of the model, all agents will be suitable mates to all other agents, but agents must be within a certain distance from another in order to mate. For the sake of simplicity and to ignore population issues, one of two parents will "die" upon the birth of a new generation.

# HOW TO USE IT
At each time step, a new generation will be born with new genomes. The genomes will be shaped by those of the parents, with slight mutations and changes. If two genomes are too different, then two agents will not be able to produce offspring. If, however, one of the "different" genomes can find a mate that whose genome is compatible, then they will produce offspring. If this process continues, then we classify it as a new species.

To investigate different kinds of speciation, there will be options to geographically split a population (by placing a river down the middle of the simulation area). This will make the left and right groups of agents unable to reach each other, making them more likely to speciate. There will also be agent properties like what "season" they prefer mating (selecting certain time step multiples, like even-numbered time steps, or multiples of 5).

A line graph will show the number of species over time, starting at 1. Data can be gathered to see which kinds of prezygotic barriers (geographic, temporal, etc.) produce the most biodiversity in our model.

# REAL WORLD BACKGROUND
Speciation happens as a result of a multitude of natural occurrences like geographic separation (known as allopatric speciation) or temporal, behavioral or mechanical isolation (known as sympatric speciation). Changes in allele frequencies over time among the breeding population result in further broad changes to the population. Eventually, a population that could once interbreed viable and fertile offspring become too different in one way or another, and two species appear.
