package options;

class CustomizeSubState extends BaseOptionsMenu
{
	public var wasClosed:Bool = false;

	public function new()
	{
		title = 'Customization Settings';
		rpcTitle = 'In Customization Settings'; //for Discord Rich Presence

		var option:Option = new Option('Menu Song: ', 
			'Change Main Menu Song.', 
			'menuSong',
			'string',
			['None', 'freakyMenu', 'Kade']); 
		addOption(option);

		super();
	} 
	
	override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (controls.BACK)
        {
           wasClosed = true; 
           close(); 
        }
   }

}