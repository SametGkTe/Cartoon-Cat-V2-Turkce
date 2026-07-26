package options;

class GameplaySettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Oynanış Ayarları';
		rpcTitle = 'Oynanış Ayarları Menüsü';

		var option:Option = new Option('Aşağı Oklar',
			'Açıksa notalar yukarı yerine aşağı akar, bu kadar basit.',
			'downScroll',
			'bool');
		addOption(option);

		var option:Option = new Option('Orta Oklar',
			'Açıksa notaların ortaya hizalanır.',
			'middleScroll',
			'bool');
		addOption(option);
		
		var option:Option = new Option('Oyun Sesi',
			'Oyunun genel ses seviyesini ayarlar. (0-100)',
			'gameVolume',
			'int');
		option.displayFormat = '%v%';
		option.scrollSpeed = 50;
		option.minValue = 0;
		option.maxValue = 100;
		option.changeValue = 5;
		addOption(option);
		option.onChange = onChangeGameVolume;

		var option:Option = new Option('Rakip Notaları',
			'Kapalıysa rakibin notaları gizlenir.',
			'opponentStrums',
			'bool');
		addOption(option);

		var option:Option = new Option('Hayalet Basış',
			'Açıksa, vurulabilecek nota yokken tuşlara basman\nkaçırma sayılmaz.',
			'ghostTapping',
			'bool');
		addOption(option);

		var option:Option = new Option('Otomatik Duraklatma',
			'Açıksa, oyun penceresi odakta değilken oyun otomatik olarak duraklatılır.',
			'autoPause',
			'bool');
		addOption(option);
		option.onChange = onChangeAutoPause;

		var option:Option = new Option('Sıfırlama Tuşunu Devre Dışı Bırak',
			'Açıksa, Sıfırla tuşuna basmak hiçbir şey yapmaz.',
			'noReset',
			'bool');
		addOption(option);

		var option:Option = new Option('Vuruş Sesi Seviyesi',
			'Notalara vurduğunda "Tik!" diye bir ses çalar.',
			'hitsoundVolume',
			'percent');
		addOption(option);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		option.onChange = onChangeHitsoundVolume;

		var option:Option = new Option('Derecelendirme Ayarı',
			'Bir notanın "Sick!" sayılması için ne kadar erken/geç basman gerektiğini değiştirir.\nDaha yüksek değerler, daha geç basman gerektiği anlamına gelir.',
			'ratingOffset',
			'int');
		option.displayFormat = '%vms';
		option.scrollSpeed = 20;
		option.minValue = -30;
		option.maxValue = 30;
		addOption(option);

		var option:Option = new Option('"Müq!" Vuruş Penceresi',
			'Bir notayı "Sick!" olarak vurabilmen için sahip olduğun\nsüreyi milisaniye cinsinden değiştirir.',
			'sickWindow',
			'int');
		option.displayFormat = '%vms';
		option.scrollSpeed = 15;
		option.minValue = 15;
		option.maxValue = 45;
		addOption(option);

		var option:Option = new Option('"iyi" Vuruş Penceresi',
			'Bir notayı "Good" olarak vurabilmen için sahip olduğun\nsüreyi milisaniye cinsinden değiştirir.',
			'goodWindow',
			'int');
		option.displayFormat = '%vms';
		option.scrollSpeed = 30;
		option.minValue = 15;
		option.maxValue = 90;
		addOption(option);

		var option:Option = new Option('"Kötü" Vuruş Penceresi',
			'Bir notayı "Kötü" olarak vurabilmen için sahip olduğun\nsüreyi milisaniye cinsinden değiştirir.',
			'badWindow',
			'int');
		option.displayFormat = '%vms';
		option.scrollSpeed = 60;
		option.minValue = 15;
		option.maxValue = 135;
		addOption(option);

		var option:Option = new Option('Güvenli Kareler',
			'Bir notaya erken ya da geç basmak için sahip olduğun\nzaman toleransını değiştirir.',
			'safeFrames',
			'float');
		option.scrollSpeed = 5;
		option.minValue = 2;
		option.maxValue = 10;
		option.changeValue = 0.1;
		addOption(option);

		var option:Option = new Option('Uzun Notaların Tek Sayılması',
			'Açıksa, uzatmalı notaları kaçırdıysan tekrar basamazsın\nve tek bir İsabet/Kaçırma olarak sayılır.\nEski input sistemini tercih ediyorsan bunu kapat.',
			'guitarHeroSustains',
			'bool');
		addOption(option);

		super();
	}

	function onChangeGameVolume()
	{
		ClientPrefs.applyGameVolume();
	}

	function onChangeHitsoundVolume()
		FlxG.sound.play(Paths.sound('hitsound'), ClientPrefs.data.hitsoundVolume);

	function onChangeAutoPause()
		FlxG.autoPause = ClientPrefs.data.autoPause;
}