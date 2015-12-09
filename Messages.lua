Message = {};
Message.Active = false;
Message.Text = "";
Message.Remove = 0;

Message.Alert = function(What,Time)
	Message.Text = What;
	Message.Remove = Time;
	Message.Active = true;
end

return Message