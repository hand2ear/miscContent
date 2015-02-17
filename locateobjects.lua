-- A program to make locate objects randomly within a square field
-- yields pairs of coordinates in undefined units
-- assumes a square of 100 x 100 units of measurement

numberOfObjects = 10

math.randomseed(os.time())

function chooseCoordsWithin(horiz, vertical)
  local h = math.random(1,horiz)
  local v = math.random(1,vertical)
  return h,v
end

function objectLocations()
  local h
  local v
   h,v = chooseCoordsWithin(100,100)
   print ("h = ", h, "v = ", v)
end

for i = 1,numberOfObjects do
  objectLocations()
end
