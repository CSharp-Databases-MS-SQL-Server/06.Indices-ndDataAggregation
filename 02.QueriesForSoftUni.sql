--13. Departments Total Salaries
SELECT DepartmentID, SUM(Salary) AS TotalSalaty
	FROM Employees
	GROUP BY DepartmentID
	ORDER BY DepartmentID

--14. Employees Minimum Salaries
SELECT DepartmentID, MIN(Salary) AS MinimumSalary
	FROM Employees
	WHERE HireDate > '01/01/2000' AND DepartmentID IN(2, 5, 7)
	GROUP BY DepartmentID


--15. Employees Average Salaries
SELECT * INTO SubTable FROM Employees
WHERE Salary > 30000

DELETE FROM SubTable WHERE ManagerID = 42

UPDATE SubTable 
SET Salary += 5000 
WHERE DepartmentID = 1

SELECT DepartmentID,
	   AVG(Salary) AS  AverageSalary
	   FROM SubTable
	   GROUP BY DepartmentID


--16. Employees Maximum Salaries
SELECT *
FROM(SELECT DepartmentID, MAX(Salary) AS MaxSalary
	FROM Employees
	GROUP BY DepartmentID
	)AS SubQuery
	WHERE MaxSalary NOT BETWEEN 30000 AND 70000


--17. Employees Count Salaries
SELECT COUNT(Salary) AS [Count] FROM Employees
	WHERE ManagerID IS NULL


--18. 3rd Highest Salary
SELECT DepartmentID, Salary AS ThirdHighestSalary 
FROM(SELECT DepartmentID, Salary,
DENSE_RANK() OVER(PARTITION BY DepartmentID ORDER BY Salary DESC) AS RankedSalary
	FROM Employees
	GROUP BY DepartmentID, Salary
	)AS SubQuery
	WHERE RankedSalary =3


--19. Salary Challenge
SELECT TOP(10) e.FirstName, e.LastName, e.DepartmentID
	FROM Employees AS e
	WHERE Salary > (
					SELECT AVG(esub.Salary) AS AverageSalary
					FROM Employees AS esub
					WHERE esub.DepartmentID = e.DepartmentID
					GROUP BY esub.DepartmentID
	                )
    ORDER BY DepartmentID