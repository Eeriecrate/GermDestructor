	Player = {}
	Player.Image = love.graphics.newImage("ToothPaste.png");
	Player.X = 375;
	Player.Y = 450;
	Player.Speed = 1;
  Player.Special = false;
	Player.Bullets = {};
	Player.cooldown = 109;
  Player.specC = 5000;
	Player.bulletImage = love.graphics.newImage("Paste.png");
	Player.Fire = function()
		if Player.cooldown < 0 then
		Player.cooldown = 100;
      if Player.Special then
        local lBullet = {};
        lBullet.X = Player.X + 20;
        lBullet.R = 0;
        lBullet.Y = Player.Y - 30;
        lBullet.Speed = 4;
        lBullet.Dir = "left";
        local rBullet = {};
        rBullet.X = Player.X + 20;
        lBullet.R = 0;
        rBullet.Y = Player.Y - 30;
        rBullet.Speed = 4;
        rBullet.Dir = "right";
        table.insert(Player.Bullets,lBullet);
        table.insert(Player.Bullets,rBullet);
      end
      local Bullet = {};
      Bullet.Dir = nil;
      Bullet.X = Player.X + 20;
      Bullet.Y = Player.Y - 30;
      Bullet.R = 0;
      Bullet.Speed = 4;
      table.insert(Player.Bullets,Bullet);
		end
	end
  
  Player.activate_Special = function()
    if not Player.Special then
      Player.Special = true;
    end 
  end
  
  
  return Player