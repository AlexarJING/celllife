--初始化框架，
local cell={}
cell.grid={}
cell.lifeTime=0.05
cell.age=0
cell.generation=1
for i=1,100,1 do 
	cell.grid[i]={}
	for j=1,100,1 do
		cell.grid[i][j]=0
	end
end

--规则
function cell:rule(x,y)
	local env=cell:testEnv(x,y)
	local result=nil
	result=result or cell:rule_dead(env)
	result=result or cell:rule_burn(env)
	result=result or cell.grid[x][y]
return result
end


function cell:rule_burn(env)
	if env==3 then return 1 end
end

function cell:rule_alive(env)
	if env==2 then return end
end

function cell:rule_dead(env)
	if env>3 or env<2 then return 0 end
end

function cell:next_generation()
	cell.next={}
	for i=1,100,1 do 
		cell.next[i]={}
		for j=1,100,1 do
			cell.next[i][j]=cell:rule(i,j)
		end
	end
	--将新一代覆盖原来一代
	for i=1,100,1 do 
		for j=1,100,1 do
			cell.grid[i][j]=cell.next[i][j]
		end
	end
	cell.generation=cell.generation+1
	love.window.setTitle("现在是第"..tostring(cell.generation).."代")
end	

function cell:update(dt)
	cell.age=cell.age+dt
	if cell.age>cell.lifeTime then
		cell.age=0
		cell:next_generation()
	end
end	

function cell:draw()
	for i=1,100,1 do 
		for j=1,100,1 do
			if cell.grid[i][j]~=0 then
			love.graphics.polygon("fill", (i-1)*5,(j-1)*5,(i-1)*5+4,(j-1)*5,(i-1)*5+4,(j-1)*5+4,(i-1)*5,(j-1)*5+4,(i-1)*5,(j-1)*5)
			end
		end
	end
end


function cell:testEnv(x,y)
	local cell_count=0
	local testx=nil
	local testy=nil
	for i=x-1,x+1,1 do
		testx=nil
		if i>100 then testx=1 end
		if i<1 then testx=100 end
		testx=testx or i
		for j=y-1,y+1,1 do
			testy=nil
			if j>100 then testy=1 end
			if j<1 then testy=100 end
			testy=testy or j
			if cell.grid[testx][testy]~=0 and not(testx==x and testy==y) then
				cell_count=cell_count+1
			end	
		end
	end 
return cell_count
end

function cell:newSeed(x,y)
	local gridX=math.floor(x/5)+1
    local gridY=math.floor(y/5)+1
    if gridX<1 then gridX=1 end; if gridX>95 then gridX=95 end
    if gridY<1 then gridY=1 end; if gridY>95 then gridY=95 end
    for i=gridX,gridX+5,1 do
        for j=gridY,gridY+5,1 do
            cell.grid[i][j]=math.random(0,1)
        end
    end
    cell.generation=1
end	

return cell