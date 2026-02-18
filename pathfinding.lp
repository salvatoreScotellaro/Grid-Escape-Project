% ==============================
% PATHFINDING WITH WALL BREAKING
% ==============================

% Input predicates:
%   - grid_size(N): defines an NxN grid
%   - input_door(X,Y): entrance position
%   - output_door(X,Y): exit position
%   - wall(X,Y): wall block at position (X,Y)

% --------------
% Grid Structure
% --------------

% Define all cells in the grid
cell(X,Y) :- grid_size(N), X=1..N, Y=1..N.

% Define neighbor predicate
neighbor(X,Y, X+1,Y) :- cell(X,Y), cell(X+1,Y).
neighbor(X,Y, X,Y+1) :- cell(X,Y), cell(X,Y+1).
neighbor(X2,Y2, X1,Y1) :- neighbor(X1,Y1,X2,Y2).

% Define free cells
free_cell(X,Y) :- cell(X,Y), not wall(X,Y).

% -----------------------------------------------------------
% Wall Breaking Decisions, Connectivity and Path Construction
% -----------------------------------------------------------

% Choose whether to break a wall at each position
{ break_wall(X,Y) : wall(X,Y) }.

% Cell passable if free or break the wall
passable(X,Y) :- free_cell(X,Y).
passable(X,Y) :- wall(X,Y), break_wall(X,Y).

% Choose path cells only among passable ones
{ in_path(X,Y) } :- passable(X,Y).

% Start position is connected
connected(X,Y) :- input_door(X,Y), in_path(X,Y).

% Recursively compute connectivity
connected(X,Y) :- in_path(X,Y), neighbor(X1,Y1,X,Y), connected(X1,Y1).

% -----------
% Constraints
% -----------

% Input and output doors must be in path
:- input_door(X,Y), not in_path(X,Y).
:- output_door(X,Y), not in_path(X,Y).

% Each non-start cell in path must be connected with other ones
:- in_path(X,Y), not connected(X,Y).

% Each non-start and non-end cell in path has exactly two neighbors 
:- in_path(X,Y), not input_door(X,Y), not output_door(X,Y), 
   not #count{ X1,Y1 : neighbor(X,Y,X1,Y1), in_path(X1,Y1) } = 2.

% ------------
% Optimization
% ------------

% Optimize with appropriate priorities
% First number of broken walls
% Second path length
#minimize{ 1@2,X,Y : break_wall(X,Y) }.
#minimize{ 1@1,X,Y : in_path(X,Y) }.

% ------
% Output
% ------
#show in_path/2.
#show break_wall/2.