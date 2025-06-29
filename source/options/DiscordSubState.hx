package options;

class DiscordSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Discord Settings';
		rpcTitle = 'In Discord Settings'; //for Discord Rich Presence

		var option:Option = new Option('Rich Presence', 
			'Uncheck this to prevent accidental leaks, it will hide the Application from your \"Playing\" box on Discord', 
			'discordRPC',
			'bool'); 
		addOption(option);

		super();
	} 
	
}