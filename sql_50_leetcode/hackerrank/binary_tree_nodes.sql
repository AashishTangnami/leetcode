
/*
You are given a table, BST, containing two columns: N and P, where N represents the value of a node in
Binary Tree, and P is the parent of N.
Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the
following for each node:
Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node.
Sample Input
Sample Output
1 Leaf
2 Inner
3 Leaf
5 Root
6 Leaf
8 Inner
*/



SELECT N,
 CASE 
    WHEN P IS NULL THEN 'Root'
    WHEN N IN (SELECT P FROM BST WHERE P IS NOT NULL) THEN 'Inner'
    ELSE 'Leaf'
 END AS TYPE
FROM BST
ORDER BY N;

--

-- WITH NodeTypes AS (
--     SELECT 
--         b1.N,
--         b1.P,
--         COUNT(b2.P) as children_count
--     FROM BST b1
--     LEFT JOIN BST b2 ON b1.N = b2.P
--     GROUP BY b1.N, b1.P
-- )
-- SELECT 
--     N,
--     CASE 
--         WHEN P IS NULL THEN 'Root'
--         WHEN children_count = 0 THEN 'Leaf'
--         ELSE 'Inner'
--     END AS Type
-- FROM NodeTypes
-- ORDER BY N;