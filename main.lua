love.graphics.setDefaultFilter( "nearest", "nearest" )
math.randomseed(os.time())
love.graphics.setBackgroundColor(150,150,255)
Lfont = love.graphics.newFont("Font.ttf",75);
font = love.graphics.newFont("Font.ttf",24);
love.graphics.setFont(font);
function love.load()
	Enemies = require("Enemies");
	Messages = require("Messages");
	Powers = require("Powers");
  Player = require("Player");
	Game = {};
	Game.Score = 0;
	Game.AddScore = function()
		Game.Score = Game.Score + 1;
		if Game.Score == 50 then
			Enemies.defaultFall = .6;
			Messages.Alert("Difficulty up!",300);
		elseif Game.Score == 100 then
			Enemies.defaultFall = .7;
			Messages.Alert("Difficulty up!",300);
		elseif Game.Score == 250 then
			Enemies.defaultFall = .8;
			Messages.Alert("Difficulty up!",300);
		elseif Game.Score == 500 then
			Enemies.defaultFall = .9;
			Messages.Alert("Difficulty up!",300);
		elseif Game.Score == 750 then
			Enemies.defaultFall = 1;
			Messages.Alert("Difficulty up!",300);
		end
	end
	Game.GameOver = false;
	Game.Filth = 0;
end

function love.update(dt)
	if not Game.GameOver then
		Enemies.cooldown = Enemies.cooldown - 1;
		if Enemies.cooldown <= 0 then
			local Enemy = Enemies.addEnemy();
			Enemy.X = math.random(25,775);
			Enemies.cooldown = 500;
		end
		Powers.Delay = Powers.Delay - 1;
		if Powers.Delay <= 0 then
			local Power = Powers.addPower();
			Power.X = math.random(25,775);
			Power.Type = Powers.Types[math.random(1,#Powers.Types)];
			Powers.Delay = 10000;
		end
		if love.keyboard.isDown(" ") then
			Player.Fire();
		end
		if love.keyboard.isDown("left") then
			Player.X = Player.X - Player.Speed;
			if Player.X <=  -50 then
				Player.X = 749
			end
		end
		if love.keyboard.isDown("right") then
			Player.X = Player.X + Player.Speed;
			if Player.X >=  800 then
				Player.X = -49
			end
		end
		Player.cooldown = Player.cooldown - 1;
	end
end

function love.draw()
	if not Game.GameOver then
		love.graphics.print("FILTH: "..(Game.Filth*10).."%",15,50);
		love.graphics.print("TEETH CLEANED: "..Game.Score,15,100);
		if Messages.Active then
			Messages.Remove = Messages.Remove - 1;
			if Messages.Remove == 0 then
				Message.Active = false;
			else
				love.graphics.print(Messages.Text,15,150);
			end
		end
		love.graphics.setColor(255,255,255);
		love.graphics.draw(Player.Image,Player.X,Player.Y,0,1);
		love.graphics.setColor(255-(Game.Filth*(25.5/2)),255,255-(Game.Filth*(25.5/2)));
		love.graphics.rectangle("fill",0,550,800,50);
		love.graphics.setColor(255,255,255);
		for i,v in pairs(Player.Bullets) do
      print(v.Dir);
      if v.Dir == "left" then
        v.Y = v.Y - v.Speed/2;
        v.X = v.X - v.Speed/2;
      elseif v.Dir == "right" then
        v.Y = v.Y - v.Speed/2;
        v.X = v.X + v.Speed/2;
      else
        v.Y = v.Y - v.Speed;
      end   
			love.graphics.setColor(255,255,255);
			love.graphics.draw(Player.bulletImage,v.X,v.Y,v.R,1);
			for _,t in pairs(Enemies.Sprites) do
				if v.X + 5 > t.X and v.X < t.X + 50 and v.Y <= t.Y + 25 and v.Y + 100 > t.Y and not t.Cleaned then
					t.Cleaned = true;
					t.image = Enemies.Images[2];
					Game.AddScore();
					table.remove(Player.Bullets,i);
				end
			end
			for _,t in pairs(Powers.Sprites) do
				if v.X + 5 > t.X and v.X < t.X + 52.5*.5 and v.Y <= t.Y + 90*.25 and v.Y + 100 > t.Y and not t.Cleaned and t.Shootable then
					t.Falling = false;
				end
			end
			if v.Y < 0 then
				table.remove(Player.Bullets,i);
			end
		end
		Powers.floss_Count = Powers.floss_Count - 1;
		if Powers.floss_Count == 0 and Powers.floss_Active then
			Powers.floss_Active = false;
		end
		if Powers.floss_Active then
			love.graphics.rectangle("fill",0,200,800,10);
		end
    Player.specC = Player.specC - 1;
		if Player.specC <= 0 and Player.Special then
			Player.Special = false;
      Player.specC = 5000;
		end
		if Powers.floss_Active then
			love.graphics.rectangle("fill",0,200,800,10);
		end
		for i,v in pairs(Enemies.Sprites) do
			if v.Y >= 150 and Powers.floss_Active and not v.Cleaned then
				v.Cleaned = true;
				v.image = Enemies.Images[2];
				Game.AddScore();
			end
			if v.image == Enemies.Images[2] then
				v.R = v.R + .01;
				v.Y = v.Y - v.fallSpeed;
				love.graphics.draw(v.image,v.X,v.Y,v.R,.5);
			else
				v.Y = v.Y + v.fallSpeed;
				love.graphics.draw(v.image,v.X,v.Y,v.R,.5);
			end
			if v.Y >= 500  then
				table.remove(Enemies.Sprites,i);
				Game.Filth = Game.Filth + 1;
				if Game.Filth == 10 then
					Game.GameOver = true;
				end
			elseif v.Y < -50 then
				table.remove(Enemies.Sprites,i);
			end
		end
		for i,v in pairs(Powers.Sprites) do
			if v.Falling == false then
				v.R = v.R + .01;
				v.Y = v.Y - v.fallSpeed;
				love.graphics.draw(v.image,v.X,v.Y,v.R,.25);
			else
				v.Y = v.Y + v.fallSpeed;
				love.graphics.draw(v.image,v.X,v.Y,v.R,.25);
			end
			if v.Y <= -61 then
				table.remove(Powers.Sprites,i);
			end
			if v.Y >= 501  then
				v.fallSpeed = 0;
				v.Shootable = false;
				v.Despawn = v.Despawn - 1
				if v.Despawn == 0 then
					table.remove(Powers.Sprites,i);
				end
				if Player.X + 50 > v.X and Player.X <= v.X + 52.5*.5 then
					Messages.Alert("Power up: "..v.Type,500);
					if v.Type == "Brush" then
						Powers.summon_Brush();
					end
					if v.Type == "Floss" then
						Powers.summon_Floss();
					end
          if v.Type == "Multi-Shot" then
            Player.specC = 5000;
            Player.activate_Special();
          end
					table.remove(Powers.Sprites,i);
				end

			end

		end
					for i,v in pairs(Powers.brushes) do
				v.X = v.X + 2;
				love.graphics.draw(v.Image,v.X,v.Y,0,.35);
				if v.X >= 815 then
					Game.Filth = Game.Filth - 3
					if Game.Filth < 0 then
						Game.Filth = 0
					end
					table.remove(Powers.brushes,i);
				end
			end
	else
		love.graphics.setBackgroundColor(255,255,255)
		love.graphics.setColor(255,0,0);
		love.graphics.setFont(Lfont);
		love.graphics.print("GAMEOVER!",75,275);
	end
end