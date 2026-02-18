## Pathfinding with Wall Breaking in Clingo

This Clingo program solves a pathfinding problem in a square grid building world. Given an entrance door (denoted as I) and exit door (denoted as O), the goal is to find the shortest path through the building. Movement is restricted to horizontal and vertical directions and walls are present. Moreover, whenever walls block all paths to the exit, the program finds a route that breaks the minimum number of wall blocks. More details about the project are given in `project_report` pdf available in this folder.

## Requirements

- Clingo 5.x or higher. To install, use `.zip` file for Clingo 5.4.0 at this [link](https://github.com/potassco/clingo/releases?page=2) or follow guidelines available [here](https://potassco.org/clingo/).

### Basic usage

To run the program, just use the following command. Note that multiple test instances are available and can be tested just changing the second argument.

```bash
clingo pathfinding.lp ./instances/test1.lp --opt-mode=optN 1
```
