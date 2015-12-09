Powers = {};
Powers.Sprites = {};
Powers.Delay = 0;
Powers.floss_Count = 0;
Powers.floss_Active = false;
Powers.Types = {"Floss","Brush","Multi-Shot"};
Powers.Image = love.graphics.newImage("Power.png");
Powers.brushImage = love.graphics.newImage("Brush.png");
Powers.brushes = {};

Powers.addPower = function()
	local Power = {};
	Power.Y = -60;
	Power.R = 0;
	Power.Falling = true;
	Power.fallSpeed = .5;
	Power.Despawn = 2500;
	Power.Shootable = true;
	Power.image = Powers.Image;
	table.insert(Powers.Sprites,Power);
	return Power
end

Powers.summon_Brush = function()
	local Brush = {};
	Brush.Image = Powers.brushImage;
	Brush.X = -104;
	Brush.Y = 507;
	table.insert(Powers.brushes,Brush);
end

Powers.summon_Floss = function()
	Powers.floss_Active = true;
	Powers.floss_Count = 5000;
end

return Powers