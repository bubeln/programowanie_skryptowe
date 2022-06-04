board = {}
isActive = {}
objVer = {}
left = 0
lowest = 0
right = 0
loc = 3
rotation = 1
IBrick = {{1},{1},{1},{1}}
OBrick = {{1,1},{1,1}}
LBrick = {{1,0},{1,0},{1,1}}
SBrick = {{0,1,1},{1,1,0}}
TBrick = {{0,1,0}, {1,1,1}}
math.randomseed(os.time())

for i=1,20 do
	row = {}
	isActive[i] = {}

	for j=1,10 do
		row[j] = {20*j,20*i, 20*j+20,20*i, 20*j+20,20*i+20, 20*j,20*i+20}
		isActive[i][j] = 0
	end
	board[i] = row
end

function Transpose(m)
	tran = {}
	h = table.getn(m)
	w = table.getn(m[1])

	for i=1,w do
		tran[i] = {}

		for j=1,h do
			tran[i][j] = m[j][i]
		end
	end

	return tran
end

function ColumnChange(m)
	tran = Transpose(m)
	tran = RowChange(tran)

	return Transpose(tran)
end

function RowChange(m)
	h = table.getn(m)
	row1 = m[1]
	m[1] = m[h]
	m[h] = row1

	return m
end

function CleanBricks()
	IBrick = {{1},{1},{1},{1}}
	OBrick = {{1,1},{1,1}}
	LBrick = {{1,0},{1,0},{1,1}}
	SBrick = {{0,1,1},{1,1,0}}
	TBrick = {{0,1,0}, {1,1,1}}
end

function InitRotate(m, n)
 	if n == 1 then
 		return m
 	end
 	if n == 2 then
 		tran = Transpose(m)
 		return RowChange(tran)
 	end
 	if n == 3 then
 		colch = ColumnChange(m)
 		return RowChange(colch)
 	end
 	if n == 4 then
 		tran = Transpose(m)
 		return ColumnChange(tran)
 	end
end

function FindCollisionDown()
	for i,v in ipairs(objVer) do
		for j,k in ipairs(v) do
			if k[1] > 0 and (k[1]+1 > 20 or isActive[k[1]+1][k[2]] == 2) then
				lowest = 20
				return lowest
			end
		end
	end
end

function FindCollisionSide(s)
	for i,v in ipairs(objVer) do
		for j,k in ipairs(v) do
			if k[2] > 0 and (k[2]+s > 10 or k[2]+s < 1 or isActive[k[1]][k[2]+s] == 2) then
				return 1
			end
		end
	end

	return 0
end

function Rotate()	
	for i,v in ipairs(objVer) do
		for j,k in ipairs(v) do
			if k[1] > 0 then
				isActive[k[1]][k[2]] = 0
			end
		end
	end

	objVer = Transpose(objVer)

	for i,v in ipairs(objVer) do
		for j,k in ipairs(v) do
			if k[1] > 0 then
				isActive[k[1]][k[2]] = 1
			end
		end
	end
end

function MoveDown()
	for i,v in ipairs(objVer) do
		for j,k in ipairs(v) do
			if k[1] > 0 then
				isActive[k[1]][k[2]] = 0
			end
		end
	end

	for i,v in ipairs(objVer) do
		for j,k in ipairs(v) do
			if k[1] > 0 then
				isActive[k[1]+1][k[2]] = 1
			end
		end
	end

	for i,v in ipairs(objVer) do
		for j,k in ipairs(v) do
			if k[1] > 0 then
				objVer[i][j][1] = k[1]+1
			end
		end
	end

	lowest = lowest + 1
end

function FreezeBrick()
	for i,v in ipairs(objVer) do
		for j,k in ipairs(v) do
			if k[1] > 0 then
				isActive[k[1]][k[2]] = 2
			end
		end
	end
end

function Falling(c)
	if c == 1 then
		FindCollisionDown()
		if lowest == 20 then
			FreezeBrick()
			CheckFullRow()
			lowest = 21
		else
			MoveDown()
		end
	else
		repeat
			FindCollisionDown()
			if lowest == 20 then
				FreezeBrick()
				CheckFullRow()
				lowest = 21
			else
				MoveDown()
			end
		until lowest > 20
	end
end

function MoveSide(s)
	for i,v in ipairs(objVer) do
		for j,k in ipairs(v) do
			if k[1] > 0 then
				isActive[k[1]][k[2]] = 0
			end
		end
	end

	for i,v in ipairs(objVer) do
		for j,k in ipairs(v) do
			if k[1] > 0 then
				isActive[k[1]][k[2]+s] = 1
			end
		end
	end

	for i,v in ipairs(objVer) do
		for j,k in ipairs(v) do
			if k[1] > 0 then
				objVer[i][j][2] = k[2]+s
			end
		end
	end

	left = left + s
	right = right + s
end

function CleanRow(row)
	for i=1,10 do
		isActive[row][i] = 0
	end
end

function MoveAllDown(row)
	rowToUp = row
	for i=1,row-1 do
		for j=1,10 do
			isActive[rowToUp][j] = isActive[rowToUp-1][j]
		end
		rowToUp = row - i
	end
end

function CheckFullRow()
	for i=1,20 do
		freezed = 0

		for j=1,10 do
			if isActive[i][j] == 2 then
				freezed = freezed + 1
			end
		end

		if freezed == 10 then
			CleanRow(i)
			MoveAllDown(i)
			CheckFullRow()
		end
	end
end

function GenerateBrick()
	CleanBricks()
	brick = math.random() and math.random() and math.random() and math.random(5)
	rotation = math.random() and math.random() and math.random() and math.random(4)

	if brick == 1 then
		tmp = InitRotate(LBrick, rotation)
	elseif brick == 2 then
		tmp = InitRotate(TBrick, rotation)
	elseif brick == 3 then
		tmp = InitRotate(OBrick, rotation)
	elseif brick == 4 then
		tmp = InitRotate(IBrick, rotation)
	else
	    tmp = InitRotate(SBrick, rotation)
	end

	objVer = tmp
	height = table.getn(tmp)
	width = table.getn(tmp[height])
	lowest = height
	left = loc + 1
	right = left + width - 1

	for i=1,height do
		for j=1,width do
			if isActive[i][loc+j] == 2 and tmp[i][j] == 1 then
				love.window.showMessageBox("Game over", "Game over", "info")
				love.event.quit("restart")
				break
			end

			isActive[i][loc+j] = tmp[i][j]

			if tmp[i][j] == 1 then
				objVer[i][j] = {i,loc+j}
			else
				objVer[i][j] = {0,0}
			end
		end
	end
end

GenerateBrick()

function love.draw()
	for i, row in ipairs(board) do
		for j, field in ipairs(row) do
			love.graphics.polygon("line", field)
		end
	end

	for i,row in ipairs(isActive) do
		for j,field in ipairs(row) do
			if field > 0 then
			    love.graphics.polygon("fill", board[i][j])
			end
		end
	end
end

total_frame = 0
function love.update(dt)
	total_frame = total_frame + 1
	
	if total_frame%20 == 0 then
		if lowest <= 20 then
			Falling(1)
		end
	end

	if lowest > 20 then
		GenerateBrick()
	end
end

function love.keypressed(key)
	if lowest < 20 then
		if key == "left" and left > 1 then
			c = FindCollisionSide(-1)

			if c == 0 then
				MoveSide(-1)
			end
		end

		if key == "right" and right < 10 then
			c = FindCollisionSide(1)

			if c == 0 then
				MoveSide(1)
			end
		end

		if key == "down" then
			Falling(20)
		end

		if key == "up" then
			rotation = (rotation + 1)%4 + 1
			Rotate()
		end
	end
end