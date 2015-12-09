Enemies = {};
Enemies.Sprites = {};
Enemies.Images = {love.graphics.newImage("Plaque.png");love.graphics.newImage("White.png");}
Enemies.canSpawn = true;
Enemies.image = Enemies.Images[1];
Enemies.defaultFall = .5;
Enemies.cooldown = 500;
Enemies.addEnemy = function()
	if Enemies.canSpawn then
	local Enemy = {};
	Enemy.Y = -50;
	Enemy.R = 0;
	Enemy.fallSpeed = Enemies.defaultFall;
	Enemy.image = Enemies.Images[1];
	table.insert(Enemies.Sprites,Enemy);
	return Enemy
	end
end

return Enemies