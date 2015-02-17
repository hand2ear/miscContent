-- yields random numbers of divisions of cells in a grid
-- as a stimulus for drawings

rows = 4
columns = 4

minDivisions = 2
maxDivisions = 10

math.randomseed(os.time())

for i = 1, rows,1 do
  for j = 1, columns, 1 do
    print(math.random(minDivisions,maxDivisions))
  end
end

