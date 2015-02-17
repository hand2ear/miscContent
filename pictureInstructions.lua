-- A program to make instructions for abstract paintings
-- Yields a background description and several sets of lines
-- to be drawn on the background.

colors = { "white", "red", "blue", "yellow", "orange", "purple", "green", "black" }

colorQuality = { "light", "dark", "medium", "mottled" }

linequality = { "solid", "broken", "dots", "dashes" }

linewidth = { "thin", "medium", "thick" }

lineDirection = { "vertical", "horiz", "loL-upR", "loR-upL" }

lineType = { "straight", "curved", "irreg" }

math.randomseed(os.time())

function choose(aTable)
  local maxIndex = # aTable
  local choice = math.random(1,maxIndex)
  return aTable[choice]
end

function backgroundDescription()
  local bgcolor = choose(colors)
  print("background:",choose(colorQuality), bgcolor)
  return bgcolor
end

function lineDescription()
  local nLines = math.random(4,24)
  print("Lines:", nLines, choose(lineType), choose(lineDirection),choose(linewidth),choose(linequality),choose(colorQuality), choose(colors))
end

function pictureInstructions()
  local bgColor = backgroundDescription()
   
  --table.remove(colors,bgColor)
  
  for i = 1, 10 do
    lineDescription()
  end
end

pictureInstructions()
